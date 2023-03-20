public class ItemVariantParse {
    public static List<Item_Variant__c> itemVariantInfo(dom.Document doc){
        
        List<Item_Variant__c> itemVariant = new List<Item_Variant__c>();
        
        //List<Product2> Producttemp = [SELECT Id, No__c FROM Product2 WHERE No__c != null];      
        
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
                                        if(childElement3.getName()=='Item_Variant'){
                                            Item_Variant__c itemInfo = new Item_Variant__c();
                                            for(Dom.XmlNode childElement4 : childElement3.getChildElements()){
                                                
                                                //System.debug('Name childElement4 : '+childElement4.getName());
                                                //System.debug('children4 : '+childElement4.getText());
                                                
                                                if(childElement4.getName()=='Key'){
                                                    itemInfo.Key__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Item_No'){
                                                    //for(Product2 ItemNo :myMap.get(childElement4.getText())){
                                                    Product2 ItemNo = myMap.get(childElement4.getText());    
                                                    //System.debug('Line 41'+ItemNo.Id);
                                                    if(ItemNo!=null){                                                            
                                                        //System.debug('Line 43'+ItemNo.Id);
                                                        itemInfo.Item__c = ItemNo.Id;
                                                        /*Boolean result = ItemNo.No__c.equals(childElement4.getText());
                                                            //System.debug('result: '+result);
                                                            if(result==true){
                                                                System.debug('ItemNo.No__c: '+ItemNo.No__c);
                                                                System.debug('childElement4.getText(): '+childElement4.getText());
                                                                //itemInfo.Item_No__c = childElement4.getText();
                                                                //itemInfo.Item__c = ItemNo.Id;
                                                            }*/
                                                        }
                                                    //}
                                                    
                                                    //System.debug('Product Size: '+Product.size());
                                                    
                                                    //System.debug('Product Id: '+Product[0].Id);
                                                    //System.debug('No__c : '+Product[0].No__c);
                                                    //System.debug('Item_No__c : '+Item_No__c);
                                                    itemInfo.Item_No__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Code'){
                                                    itemInfo.Code__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Description'){
                                                    itemInfo.Description__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Available_Inventory'){
                                                    itemInfo.Available_Inventory__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                
                                                if(childElement4.getName()=='Description_2'){
                                                    itemInfo.Description_2__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Exclude_from_Consignment'){
                                                    if(childElement4.getText()=='true'){
                                                        itemInfo.Exclude_from_Consignment__c = true;
                                                    }
                                                    
                                                    if(childElement4.getText()=='false'){
                                                        itemInfo.Exclude_from_Consignment__c = false;
                                                    }
                                                }
                                                
                                                if(childElement4.getName()=='Strategy'){
                                                    itemInfo.Strategy__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Commisionable'){
                                                    itemInfo.Commisionable__c = childElement4.getText();
                                                }
                                            }
                                            itemVariant.add(itemInfo);
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return itemVariant;
    }
}