/**=================================================================================================================================
* Created By: Denson Zunga & Tawanda Madavo
* Created Date: 14/01/2021
* Description: Class to handle customer card callout
===================================================================================================================================**/

public class MeridianCustomerCard implements Schedulable {
  public class MeridianCustomerCardException extends Exception{}
  public static HttpRequest httpRequest = new HttpRequest();
  public static HttpResponse httpResponse = new HttpResponse();
  public static String navCustomerODATAUrl = 'callout:NAVPRODODATA/ODataV4/Company(\'Cool%20Wines\')/Customer_Webservice';

  public void execute(SchedulableContext ctx) {
    Datetime dt = Datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day());
    start(dt.format('yyyy-MM-dd'));
  }

  public static void start(String dateString){
    try{
      //Get full count for that day
      String returnBody =  manageCustomerCallouts(dateString, '1', null);
      Meridian_Customer_ODATA respData = (Meridian_Customer_ODATA) JSON.deserialize(returnBody, Meridian_Customer_ODATA.class);
      Decimal allCount = Decimal.valueOf(respData.odata_count);
      Integer totalNumberOfBatches = Integer.valueOf(Math.ceil(allCount.divide(500, 1)));
      Integer skipCount = 0;
      System.debug('Total count: '+allCount);
      System.debug('Total batches of 500: '+totalNumberOfBatches);
      //Async process batches
      for(Integer i = 1; i <= totalNumberOfBatches ; i++){
        manageDMLAccounts(dateString,String.valueOf(skipCount));
        skipCount+=500;
        i++;
      }
    }
    catch(Exception e){
      Util_NavEnvironment.logWebCall(
        'Get Customers',
        'Outbound',
        '',
        e.getMessage(),
        false,
        ''
      );
    }
  }

  public static String manageCustomerCallouts(String filterDate, String top, String skip){
    String topFilter = (top != null && top != '') ? '&$top='+ top : '';
    String skipFilter = (skip != null && skip != '') ? '&$skip='+ skip : '';
    String countFilter = '&$count=true';
    String apiFilter= '?$filter=Last_Date_Modified%20eq%20' + filterDate + topFilter + skipFilter + countFilter;
    Map<String, String> headers = new Map<String, String>();
    headers.put('Content-Type', 'application/json');
    httpResponse = Util_NavEnvironment.makeWebCallout(
      'GET',
      navCustomerODATAUrl + apiFilter,
      null,
      headers,
      120000
    );

    if (
      httpResponse.getStatusCode() == 200 || httpResponse.getStatusCode() == 201 || httpResponse.getStatusCode() == 204
    ) {
      return httpResponse.getBody().replace('@odata.count', 'odata_count');
    }
    else{
      throw new MeridianCustomerCardException('Customer API callout failed.');
    }
  }

  @future
  public static void manageDMLAccounts(String dateString, String skipCount){
    try{
      String jsonBody = manageCustomerCallouts(dateString, '500', skipCount);
      List<Account> accsToUpdate = Meridian_Customer_ODATA_Parser.parse(jsonBody);
        Database.UpsertResult[] upserts = Database.upsert(accsToUpdate, Account.No__c, false);
        for(Integer index = 0, size = upserts.size(); index < size; index++) {
          Database.UpsertResult result = upserts[index];
            if(!upserts[index].isSuccess()) {
              for (Database.Error err : result.getErrors()) {
                  Util_NavEnvironment.logWebCall(
                  'Get Customers',
                  'Outbound',
                  '',
                  'Accout No #'+accsToUpdate[index].No__c+' failed to update for the following reason:'+err.getMessage(),
                  false,
                  ''
                );
              }
            }
        }
    }
    catch(Exception e){
      Util_NavEnvironment.logWebCall(
        'Get Customers',
        'Outbound',
        '',
        e.getMessage(),
        false,
        ''
      );
    }
  }
}