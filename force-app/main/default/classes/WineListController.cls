public class WineListController {
    @AuraEnabled
    public static String updateWineList(Assortment obj) {
       update obj;
       return 'Old Winelist Updated';
    }
    @AuraEnabled
    public static String createNewWinelist(Assortment obj) {
       update obj;
       return obj.Id;
    }
    @AuraEnabled
    public static String updateWineListItems(String records) {
        try{
            List<AssortmentProduct> save2NewWinelist = (List<AssortmentProduct>) JSON.deserialize(records, List<AssortmentProduct>.class);
            AssortmentProduct productItem = new AssortmentProduct();
               
            update save2NewWinelist;
            for(AssortmentProduct ap: save2NewWinelist){                
                if (ap.Active__c == false){
                   delete ap;   
                }       
             }
         return 'success'; 
        }
        catch(Exception e){
            return e.getMessage();
        }      
    }
}