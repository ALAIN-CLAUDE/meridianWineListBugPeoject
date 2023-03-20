public class ParseXML {
    public static void parseXMLBody(String xmlString) {
        String Description;
        String invoiceNo;
        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);
        List <Order> ordersToUpdate = new List<Order> ();
        for (Dom.XmlNode fluxNode: doc.getRootElement().getChildElements()) {
            for (Dom.XmlNode fluxChildNode: fluxNode.getChildElements()) {
                String responseNameSpace = fluxChildNode.getNamespace();
                System.debug('test: '+responseNameSpace);
                for (Dom.XmlNode nextfluxChildNode: fluxChildNode.getChildElements()) {
                    for (Dom.XmlNode nextnextfluxChildNode: nextfluxChildNode.getChildElements()) {
                       
                        invoiceNo = nextnextfluxChildNode.getChildElement('No', responseNameSpace).getText();
                        String salesOrderNo = nextnextfluxChildNode.getChildElement('Order_No', responseNameSpace).getText();
                        System.debug('invoiceNo: '+invoiceNo);
                        System.debug('salesOrderNo: '+salesOrderNo);
                        
                        List <Order> orderInvoice = [SELECT Id, OrderNumber, Sales_Order_No__c,Invoice_Created__c 
                                     FROM Order 
                                     WHERE Sales_Order_No__c =: salesOrderNo];

                         System.debug('macthedOrders: '+orderInvoice);
                        
                        Invoice__c invoice = new Invoice__c();
                        
                        invoice.Invoice_No__c = invoiceNo;

                        for(Order ord : orderInvoice){
                            ord.Invoice_Created__c = true;
                            ordersToUpdate.add(ord);
                            Update ord;
                            invoice.Order__c = ord.Id;
                        }

                        insert invoice;
                        
                        for (Dom.XmlNode nextnextnextfluxChildNode: nextnextfluxChildNode.getChildElements()) {
                            
                            // Only perform next for sales invoice lines
                            if(nextnextnextfluxChildNode.getName() == 'SalesInvLines'){
                                // Loop over all the child nodes (Web_Posted_Sales_Invoice_Sub) and get your children text as shown below and save child item on each iteration
                                for (Dom.XmlNode nextnextnextnextfluxChildNode: nextnextnextfluxChildNode.getChildElements()) {
                                    if(nextnextnextnextfluxChildNode.getChildElement('Type', responseNameSpace).getText() == 'Item'){
                                      	Description = nextnextnextnextfluxChildNode.getChildElement('Description', responseNameSpace).getText();
                                        System.debug('Description: '+Description);
                                        
                                        Invoice_Line_Item__c invl = new Invoice_Line_Item__c();
                                        invl.Invoice__c = invoice.Id;
                                        
                                        invl.Description__c = Description;
                                        insert invl;  
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        //Update ordersToUpdate;
    }
}