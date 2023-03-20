public class Util_NavEnvironment {
  public static string getNavBaseUrl() {
    if ([SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox == true) {
      return 'callout:NAVPROD';
      //return 'callout:NAVQA';
    } else {
      return 'callout:NAVPROD';
    }
  }

  //Mail Sender
  public static void sendMail(List<String> toAddress, List<String> ccAddress, String subject, String htmlBody) {
    Messaging.reserveSingleEmailCapacity(2);
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(toAddress);
    mail.setCcAddresses(ccAddress);
    mail.setSenderDisplayName('Salesforce - Meridian Wines');
    mail.setSubject(subject);
    mail.setHtmlBody(htmlBody);
    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
  }

  //Global logger handler
  public static void logWebCall(
    String operation,
    String direction,
    String requestBody,
    String responseBody,
    Boolean success,
    String recordId
  ) {
     Web_Callout_Log__c webLog = new Web_Callout_Log__c();
     webLog.Direction__c = direction;
     webLog.Request__c = (requestBody.length() < 32768) ? requestBody : requestBody.substring(0, 32760);
     webLog.Response__c = (responseBody.length() < 32768) ? responseBody : responseBody.substring(0, 32760);
     webLog.Operation__c = operation;
     webLog.Related_Record__c = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + recordId;
     webLog.Status__c = (success == true) ? 'Success' : 'Failed';
     Insert webLog;
  }

  //Global logger handler -- Overload
  public static void logWebCall(
    String operation,
    String direction,
    String requestBody,
    String responseBody,
    Boolean success,
    String recordId,
    String additionalData
  ) {
     Web_Callout_Log__c webLog = new Web_Callout_Log__c();
     webLog.Direction__c = direction;
     webLog.Request__c = (requestBody.length() < 32768) ? requestBody : requestBody.substring(0, 32760);
     webLog.Response__c = (responseBody.length() < 32768) ? responseBody : responseBody.substring(0, 32760);
     webLog.Operation__c = operation;
     webLog.Related_Record__c = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + recordId;
     webLog.Status__c = (success == true) ? 'Success' : 'Failed';
     webLog.Additional_Reference__c = additionalData;
     Insert webLog;
  }

  //Global callout handler
  public static HttpResponse makeWebCallout(String method, String url, String body, Map<String, String> headers, Integer timeout){
    Http http = new Http();
    HttpRequest httpRequest = new HttpRequest();
    if(method == 'POST'){
      httpRequest.setBody(body);
    }
    httpRequest.setEndpoint(url);
    httpRequest.setMethod(method);
    httpRequest.setTimeout(120000);
    for(String key : headers.keySet()){
        httpRequest.setHeader(key,headers.get(key));
    }
    return http.send(httpRequest);
  }
}