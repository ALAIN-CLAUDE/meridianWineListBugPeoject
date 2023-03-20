public class MeridianItemVariant implements Schedulable{
    public static HttpRequest httpRequest = new HttpRequest();
    public static HttpResponse httpResponse = new HttpResponse();
    
    public void execute(SchedulableContext ctx) {
        makeItemVariantRequest();
    }
    
    @future(callout=true)
    public static void makeItemVariantRequest(){
        Http http = new Http();
        httpRequest.setBody(getSoapEnvelope());
        httpRequest.setEndpoint(Util_NavEnvironment.getNavBaseUrl() + '/WS/Cool%20Wines/Page/Item_Variant');
        httpRequest.setMethod('POST');
        httpRequest.setTimeout(40000);
        httpRequest.setHeader('Content-Type','text/xml;charset=UTF-8');
        httpRequest.setHeader('Accept-Encoding','gzip,deflate');
        httpRequest.setHeader('SOAPAction', '"urn:microsoft-dynamics-schemas/page/item_variant:ReadMultiple"');
        
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
        System.debug('Response Status Code**:' + httpResponse.getStatusCode());
        System.debug('Response Status***:' + httpResponse.getStatus());
        System.debug('Response Body****:' + httpResponse.getBody());
        
        dom.Document resDoc = httpResponse.getBodyDocument();
        System.debug('resDoc:'+resDoc);
        //System.debug('debug: '+resDoc.toXmlString());
        
        List<Item_Variant__c> ItemVariant = [SELECT Item__c, Commisionable__c, Strategy__c, Status__c, Exclude_from_Consignment__c, 
                                             Description_2__c, Available_Inventory__c, Description__c, Code__c, Item_No__c,Key__c, Name, Id 
                                             FROM Item_Variant__c];
        
       ItemVariant = ItemVariantParse.itemVariantInfo(resDoc);
        
        System.debug('The Item Variant List: '+ItemVariant);
        if(!ItemVariant.isEmpty()){
            System.debug('Number of Item Variant: '+ItemVariant.size());
            
            UPSERT ItemVariant Key__c;
        }
    }
    
    public static String getSoapEnvelope(){
        String XMLBody;
        
        XMLBody =('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:item="urn:microsoft-dynamics-schemas/page/item_variant">'
                  +'<soapenv:Header/>'
                  +'<soapenv:Body>'
                  +'<item:ReadMultiple>'
                  +'<!--1 or more repetitions:-->'
                  +'<item:filter>'
                  +'<item:Field>Status</item:Field>'
                  +'<item:Criteria>Transition|Current</item:Criteria>'
                  +'</item:filter>'
                  
                  //+'<item:filter>'
                  //+'<item:Field>Available_Inventory</item:Field>'
                  //+'<item:Criteria>>0</item:Criteria>'
                  //+'</item:filter>'
                  
                  +'<!--Optional:-->'
                  +'<item:bookmarkKey></item:bookmarkKey>'
                  +'<item:setSize></item:setSize>'
                  +'</item:ReadMultiple>'
                  +'</soapenv:Body>'
                  +'</soapenv:Envelope>'
                 );
        
        //system.debug('XML Body'+XMLBody);
        return XMLBody;
    }
}