public class MeridianCustomerPriceList implements Schedulable{
    public static HttpRequest httpRequest = new HttpRequest();
    public static HttpResponse httpResponse = new HttpResponse();
    
    public void execute(SchedulableContext ctx) {
        makePriceListRequest();
    }
    
    @future(callout=true)
    public static void makePriceListRequest(){ //DKZ: later change back to void
        Http http = new Http();
        httpRequest.setBody(getSoapEnvelope());
        httpRequest.setEndpoint(Util_NavEnvironment.getNavBaseUrl() + '/WS/Cool%20Wines/Page/Customer_Price_List');
        httpRequest.setMethod('POST');
        httpRequest.setTimeout(30000);
        httpRequest.setHeader('Content-Type','text/xml;charset=UTF-8');
        httpRequest.setHeader('Accept-Encoding','gzip,deflate');
        httpRequest.setHeader('SOAPAction', '"urn:microsoft-dynamics-schemas/page/customer_price_list:ReadMultiple"');
        
        String username ='GROUPMERIDIAN\\SALESFORCE';
        String password = 'EOpaOEe6X4vFbNxd78hV#';
        String name = 'SALESFORCE';
        String Domain = 'GROUPMERIDIAN';
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' +EncodingUtil.base64Encode(headerValue);
        System.debug('authorizationHeader: ' +authorizationHeader);
        httpRequest.setHeader('Authorization', authorizationHeader);
        
        System.debug('Request: '+httpRequest);
        
        httpResponse = http.send(httpRequest);
        System.debug('Response Status**:' + httpResponse.getStatusCode());
        System.debug('Response Status***:' + httpResponse.getStatus());
        
        
        dom.Document resDoc = httpResponse.getBodyDocument();
        System.debug('debug: '+resDoc.toXmlString());
        
        List<Customer_Price_List__c> custPriceList = [SELECT Id, Unit_of_Measure_Code__c, Variant_Code__c, Specific_Price_Available__c, 
                                                      Customer_List_Price__c, Customer_Nett_Price__c, Item_No__c, Name,Key__c  
                                                      FROM Customer_Price_List__c];
        
        custPriceList = CustomerPriceListParse.customerPriceListInfo(resDoc);
        
        System.debug('The customer PriceList List: '+custPriceList);
        if(!custPriceList.isEmpty()){
            System.debug('Number of customer PriceList: '+custPriceList.size());
            
            UPSERT custPriceList Key__c ;
        }
        
        System.debug('Server Response: ' + httpResponse);
        //return httpResponse; //DKZ delete this when done
    }
    
    public static String getSoapEnvelope(){
        String XMLBody;
        
        XMLBody =('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cus="urn:microsoft-dynamics-schemas/page/customer_price_list">'
                  +'<soapenv:Header/>'
                  +'<soapenv:Body>'
                  +'<cus:ReadMultiple>'
                  +'<!--1 or more repetitions:-->'
                  +'<cus:filter>'
                  +'<cus:Field>Customer_No</cus:Field>'
                  +'<cus:Criteria>*</cus:Criteria>'
                  +'</cus:filter>'
                  +'<!--Optional:-->'
                  +'<cus:bookmarkKey></cus:bookmarkKey>'
                  +'<cus:setSize>200</cus:setSize>'
                  +'</cus:ReadMultiple>'
                  +'</soapenv:Body>'
                  +'</soapenv:Envelope>'
                 );
        
        system.debug('XML Body'+XMLBody);
        return XMLBody;
    }
}