public class CustomerPriceListParse {
    public static List<Customer_Price_List__c> customerPriceListInfo(dom.Document doc){
        
        List<Customer_Price_List__c> customerPriceList = new List<Customer_Price_List__c>();
        
        Map<String, Account> myMap2 = new Map<String, Account>(); 
        for(Account obj : [SELECT Id, No__c FROM Account WHERE No__c != null]){
            myMap2.put(obj.No__c, obj);    
        }
        
        Map<String, Product2> myMap = new Map<String, Product2>(); 
        for(Product2 obj : [Select Id, No__c From Product2 WHERE No__c != null]){
            myMap.put(obj.No__c, obj);    
        }
        
        
        Dom.XmlNode rootElement = doc.getRootElement();
        for(Dom.XmlNode childElement : rootElement.getChildElements()){
            If(!String.isBlank(rootElement.getName())){
                //System.debug('Name: '+childElement.getName());
                if(childElement.getName()=='Body'){
                    for(Dom.XmlNode childElement1 : childElement.getChildElements()){
                        //System.debug('Name childElement1 : '+childElement1.getName());
                        if(childElement1.getName()=='ReadMultiple_Result'){
                            for(Dom.XmlNode childElement2 : childElement1.getChildElements()){
                                //System.debug('Name childElement2 : '+childElement2.getName());
                                if(childElement2.getName()=='ReadMultiple_Result'){
                                    for(Dom.XmlNode childElement3 : childElement2.getChildElements()){
                                        //System.debug('Name childElement3 : '+childElement3.getName());
                                        if(childElement3.getName()=='Customer_Price_List'){
                                            
                                            Customer_Price_List__c itemInfo = new Customer_Price_List__c();
                                            
                                            for(Dom.XmlNode childElement4 : childElement3.getChildElements()){
                                                
                                                //System.debug('Name childElement4 : '+childElement4.getName());
                                                //System.debug('children4 : '+childElement4.getText());
                                                
                                                if(childElement4.getName()=='Key'){
                                                    itemInfo.Key__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Customer_No'){
                                                    Account ItemNo = myMap2.get(childElement4.getText());    
                                                   
                                                    if(ItemNo!=null){                                                            
                                                        System.debug('Line 46'+ItemNo.Id);
                                                        itemInfo.Account__c = ItemNo.Id;
                                                        
                                                        }
                                                    itemInfo.Name = childElement4.getText();
                                                    
                                                }
                                                
                                                if(childElement4.getName()=='Item_No'){
                                                    Product2 ItemNo = myMap.get(childElement4.getText());    
                                                   
                                                    if(ItemNo!=null){                                                            
                                                        System.debug('Line 58'+ItemNo.Id);
                                                        itemInfo.Product__c = ItemNo.Id;
                                                        
                                                        }
                                                    itemInfo.Item_No__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Customer_Nett_Price'){
                                                    itemInfo.Customer_Nett_Price__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                
                                                if(childElement4.getName()=='Customer_List_Price'){
                                                    itemInfo.Customer_List_Price__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                
                                                if(childElement4.getName()=='Specific_Price_Available'){
                                                    if(childElement4.getText()=='true'){
                                                        itemInfo.Specific_Price_Available__c = true;
                                                    }
                                                    if(childElement4.getText()=='false'){
                                                        itemInfo.Specific_Price_Available__c = false;
                                                    }
                                                }
                                                
                                                if(childElement4.getName()=='Variant_Code'){
                                                   itemInfo.Variant_Code__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Unit_of_Measure_Code'){
                                                   itemInfo.Variant_Code__c = childElement4.getText();
                                                }
                                            }
                                            customerPriceList.add(itemInfo);
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return customerPriceList;
    }
}