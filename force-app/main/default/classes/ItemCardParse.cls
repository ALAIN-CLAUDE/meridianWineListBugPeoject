public class ItemCardParse {
    
    public class ProductItem {
        public List<Product2> items;
        public Map<String, Decimal> priceMap;
        
        public ProductItem(List<Product2> items, Map<String, Decimal> priceMap){
            this.items = items;
            this.priceMap = priceMap;
        }
    }
    
    public static ProductItem itemInfo(dom.Document doc){
        
        
        List<Product2> item = new List<Product2>();
        Map<String, Decimal> priceMap = new Map<String, Decimal>();
        
        Dom.XmlNode rootElement = doc.getRootElement();
        
        If(!String.isBlank(rootElement.getName())){
            for(Dom.XmlNode childElement : rootElement.getChildElements()){
                System.debug('Name: '+childElement.getName());
                if(childElement.getName()=='Body'){
                    for(Dom.XmlNode childElement1 : childElement.getChildElements()){
                         System.debug('Name childElement1 : '+childElement1.getName());
                        if(childElement1.getName()=='ReadMultiple_Result'){
                            for(Dom.XmlNode childElement2 : childElement1.getChildElements()){
                                System.debug('Name childElement2 : '+childElement2.getName());
                                if(childElement2.getName()=='ReadMultiple_Result'){
                                    for(Dom.XmlNode childElement3 : childElement2.getChildElements()){
                                        System.debug('Name childElement3 : '+childElement3.getName());
                                        if(childElement3.getName()=='Integration_Item_Card'){
                                            Product2 Prod = new Product2();
                                            String noKey;
                                            Decimal noValue = 0.0;
                                            for(Dom.XmlNode childElement4 : childElement3.getChildElements()){                                                
                                                if(childElement4.getName()=='No'){
                                                    Prod.No__c = childElement4.getText();
                                                    Prod.ProductCode = childElement4.getText();
                                                    noKey = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Description'){
                                                    Prod.Name = childElement4.getText();
                                                    Prod.Description = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Blocked'){
                                                    if(childElement4.getText()=='false'){
                                                       Prod.Blocked__c = false ;
                                                       Prod.IsActive = true;
                                                    }
                                                     if(childElement4.getText()=='true'){
                                                       Prod.Blocked__c = true; 
                                                       Prod.IsActive = false;
                                                    }
                                                }
                                                if(childElement4.getName()=='Type'){
                                                    Prod.Type__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Base_Unit_of_Measure'){
                                                    Prod.Base_Unit_of_Measure__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Item_Category_Code'){
                                                    Prod.Item_Category_Code__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Automatic_Ext_Texts'){
                                                    if(childElement4.getText()=='false'){
                                                       Prod.Automatic_Ext_Texts__c =false; 
                                                    }
                                                    if(childElement4.getText()=='false'){
                                                       Prod.Automatic_Ext_Texts__c =false; 
                                                    }
                                                }
                                                if(childElement4.getName()=='Smollan_Vendor'){
                                                    Prod.Smollan_Vendor__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Search_Description'){
                                                    Prod.Search_Description__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Inventory'){
                                                    Prod.Inventory__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Base_Unit_of_Measure'){
                                                    Prod.Unit_of_Measure_Code__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Unit_Cost'){
                                                    noValue = Decimal.valueOf(childElement4.getText());
                                                }
                                            }
                                            item.add(Prod);
                                            priceMap.put(noKey, noValue);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return new ProductItem(item, priceMap);
    }
}