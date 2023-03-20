public with sharing class WineListTableController { 
    
    @AuraEnabled
    public static List<AssortmentProduct> getRecords(){
        List<AssortmentProduct> assortmentProduct = new List<AssortmentProduct>();
        Id userInfo = UserInfo.getUserId();
        String user = String.valueOf(userInfo);
        String userId = user.removeEnd(user.substring(user.length()-3));
        
        List<Wine_List_Audit__c> audit = [SELECT Id, 
                                                 ProductId__c,
                                                 Product_Name__c,
                                                 Active__c,
                                                 Listing__c,
                                                 Bottle_Price__c,
                                                 Glass_Price__c
                                          FROM Wine_List_Audit__c WHERE User_Id__c =: userId];
        
        for(Wine_List_Audit__c item : audit) {
            AssortmentProduct assortmentObject = new AssortmentProduct();
            assortmentObject.ProductId = item.ProductId__c;
            assortmentObject.Product_Name__c = item.Product_Name__c;
            assortmentObject.Active__c = item.Active__c;
            assortmentObject.Bottle_Price__c = item.Bottle_Price__c;
            assortmentObject.Glass_Price__c = item.Glass_Price__c;
            assortmentObject.Listing__c = item.Listing__c;
            assortmentProduct.add(assortmentObject);
        }
        
        delete audit;
        return assortmentProduct;
    }
    
    @AuraEnabled
    public static void updateRecords(String jsonString){ 
        JSON2Apex json2Apex = new JSON2Apex();
        List<JSON2Apex> products = json2Apex.parse(jsonString);
        List<AssortmentProduct> records = new List<AssortmentProduct>();
        
        for(JSON2Apex product : products){
            AssortmentProduct record = new AssortmentProduct();
            for(Fields item: product.Fields){
                if(item.name == 'ProductId') {
                     record.Id = item.value;
                }else if(item.name == 'Active__c') {
                     record.Active__c = Boolean.valueOf(item.value);
                }else if(item.name == 'Listing__c') {
                     record.Listing__c = item.value;     
                }else if(item.name == 'Bottle_Price__c') {
                    if(item.value != null){
                       String bottlePrice = item.value + '.00'; 
                       record.Bottle_Price__c = Decimal.valueOf(bottlePrice);  
                    } 
                }else if(item.name == 'Glass_Price__c') {
                    if(item.value != null){
                       String glassPrice = item.value + '.00'; 
                       record.Glass_Price__c = Decimal.valueOf(glassPrice);      
                    }
                }
            } 
            records.add(record);
        }
        
        try{
            update records;  
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled        
    public static Map<String,String> getPicklistValues(String objectAPIName, String fieldAPIName){
        Map<String,String> pickListValuesMap = new Map<String,String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectAPIName);
        Schema.DescribeSObjectResult descResult = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = descResult.fields.getMap().get(fieldAPIName).getDescribe();
        Boolean isFieldNotRequired = fieldResult.isNillable();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            if(isFieldNotRequired)
                pickListValuesMap.put('--None--', '');
            if(pickListVal.isActive())
                pickListValuesMap.put(pickListVal.getLabel(), pickListVal.getValue());
        }
        return pickListValuesMap;
    }
   
    public class JSON2Apex {
	     public List<Fields> fields;	
	     public List<JSON2Apex> parse(String json) {
		      return (List<JSON2Apex>) System.JSON.deserialize(json, List<JSON2Apex>.class);
	     }
    }
    public class Fields {
		public String name;
		public String value;
    }
    
}