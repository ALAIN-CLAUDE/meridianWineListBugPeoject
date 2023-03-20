public class CreateSalesOrder {
/*public static HttpRequest httpRequest = new HttpRequest();
    public static HttpResponse httpResponse = new HttpResponse();
    public static List <Order> orderRecords;
    Public static string salesOrderNo;
    Public static string errorMessage;
    
    
    @InvocableMethod
    public static void invokeMethod(List <Order> orderRecords){
        System.debug('Order Record: '+orderRecords);
        callRequestMethod(orderRecords.get(0).AccountId,orderRecords.get(0).Id);
        
    }
    
    @future(callout=true)
    public static void callRequestMethod(String accId,String orderId){
        try{        
            List <Account> AccList = [SELECT Id, Name, No__c
                                    FROM Account
                                    WHERE Id =:accId
                                    ];
            
            List <Order> order = [SELECT Id, AccountId, Pricebook2Id, External_Document_No__c, OrderNumber,Sales_Order_No__c, OwnerId 
                                FROM Order
                                WHERE Id =:orderId];
            
            List <OrderItem> orderItems = [SELECT Id, Product2Id, Quantity, Product2.No__c, Sales_Unit_Of_Measure__c, OrderId, Item_Variant__r.Code__c, Product2.Unit_of_Measure_Code__c, Product2.ProductCode 
                                        FROM OrderItem
                                        WHERE OrderId =: order.get(0).Id];
            
            System.debug('orderItems Size: '+orderItems.size());
            
            if(orderItems.size()>0){
                List <Product2> orderProduct = [SELECT Id, Name, Description, No__c 
                                                FROM Product2
                                                WHERE Id =: orderItems.get(0).Product2Id];
                
                createSalesOrdersRequest(AccList.get(0).No__c,order.get(0).OrderNumber,orderItems,orderId, order.get(0).OwnerId, order.get(0).External_Document_No__c);
            }
        }
        catch(Exception e){
            Util_NavEnvironment.logWebCall('Create Sales Order', 'Outbound', 'General Exception', e.getMessage(), false, orderId);
        }
    }
    
    //@future(callout=true)
    public static httpResponse createSalesOrdersRequest(String customerNo, String orderNo,List<OrderItem> orderItems, String orderId, String ownerId, String externalDocNo){

            //Get owner name
            User usr = [SELECT Id, Name FROM User Where Id =: ownerId];
            String requestBody = getSoapEnvelope(customerNo, orderNo,orderItems, usr.Name, externalDocNo);
            
            Http http = new Http();
            httpRequest.setBody(requestBody);
            httpRequest.setEndpoint(Util_NavEnvironment.getNavBaseUrl() + '/WS/Cool%20Wines/Page/Integration_Sales_Order');
            httpRequest.setMethod('POST');
            httpRequest.setTimeout(120000);
            httpRequest.setHeader('Content-Type','text/xml;charset=UTF-8');
            httpRequest.setHeader('Accept-Encoding','gzip,deflate');
            httpRequest.setHeader('SOAPAction', '"urn:microsoft-dynamics-schemas/page/integration_sales_order:Create"');
            
            System.debug('Request: '+httpRequest);
            
            httpResponse = http.send(httpRequest);
            System.debug('Response Status Code**:' + httpResponse.getStatusCode());
            
            
            dom.Document resDoc = httpResponse.getBodyDocument();
            System.debug('debug: '+resDoc.toXmlString());
            
            if(httpResponse.getStatusCode() == 200){
                salesOrderNo = SalesOrdersParse2.salesOrderResp(resDoc);
                updateOrder(OrderID, salesOrderNo, errorMessage, true);
                Util_NavEnvironment.logWebCall('Create Sales Order', 'Outbound', requestBody, httpResponse.getBody(), true, orderId);
            }
            else{           
                errorMessage = SalesOrdersParse2.salesOrderErrorResp(resDoc);
                updateOrder(OrderID, salesOrderNo, errorMessage, false);
                Util_NavEnvironment.logWebCall('Create Sales Order', 'Outbound', requestBody, httpResponse.getBody(), false, orderId);
            }
            
            return httpResponse;
        }
    
    public static String getSoapEnvelope(String customerNo, String orderNo, List<OrderItem> orderItems, String Username, String externalDocNo){
        String XMLBody;
        List<String> orderItem = new List<String>();
        externalDocNo = (externalDocNo == null) ? '' : externalDocNo;
        
        for(OrderItem oli : orderItems){
            System.debug('Product2 No: '+ oli.Product2.No__c);
            System.debug('Quantity: '+ oli.Quantity);
            System.debug('Item Variant Code: '+ oli.Item_Variant__r.Code__c);
            
            orderItem.add(+'<int:Sales_Order_Subform_Integratio>'   
                          +'<int:Type>Item</int:Type>'
                          +'<!--Optional:-->'
                          +'<int:No>'+oli.Product2.ProductCode+'</int:No>'
                          +'<int:Unit_of_Measure_Code>'+oli.Sales_Unit_Of_Measure__c+'</int:Unit_of_Measure_Code>'
                          +'<int:Quantity>'+oli.Quantity+'</int:Quantity>'
                          +'</int:Sales_Order_Subform_Integratio>');
        }
        
        
        XMLBody =('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:int="urn:microsoft-dynamics-schemas/page/integration_sales_order">'
                  +'<soapenv:Header/>'
                  +'<soapenv:Body>'
                  +'<int:Create>'
                  +'<int:Integration_Sales_Order>'
                  +'<int:Sell_to_Customer_No>'+customerNo+'</int:Sell_to_Customer_No>'
                  +'<int:External_Document_No>'+externalDocNo+'</int:External_Document_No>'
                  +'<int:Tradezone_Username>'+Username+'</int:Tradezone_Username>'
                  +'<int:SalesLines>'
                  +'<!--1 or more repetitions:-->'                  
                  +String.join(orderItem,'')                  
                  +'</int:SalesLines>'
                  +'</int:Integration_Sales_Order>'
                  +'</int:Create>'
                  +'</soapenv:Body>'
                  +'</soapenv:Envelope>'
                 );
        
        system.debug('XML Body'+XMLBody);
        return XMLBody;
    }
    
    public static void updateOrder(String OrderID, String salesOrderNo, String errorMessage, Boolean passedPost){
        
        
        List <Order> order = [SELECT Id, AccountId, Pricebook2Id, OrderNumber,Sales_Order_No__c,Error_Message__c 
                              FROM Order
                              WHERE Id =:OrderID];
        
        order.get(0).Sales_Order_No__c = salesOrderNo;
        order.get(0).No__c = salesOrderNo;
        
        order.get(0).Error_Message__c = errorMessage;
        order.get(0).Nav_Message__c = errorMessage;
        order.get(0).Nav_Status__c = (passedPost == true) ? 'Posted' : 'Failed';
        order.get(0).Status = (passedPost == true) ? 'Activated' : 'Draft';
        UPDATE order;
    }*/
}