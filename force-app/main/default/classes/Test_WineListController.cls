@isTest
public class Test_WineListController {
    static testMethod void WineListController(){
        
        Account acc = new Account();
        acc.Name = 'Testing';
        insert acc;
        
        RetailStore rs = new RetailStore();
        rs.Name = 'TestStore';
        rs.AccountId = acc.Id;
        insert rs;
        
        Assortment winelist = new Assortment();
        winelist.Active__c = true;
        winelist.Name = 'testWine';
        winelist.Status__c = 'Current';
        winelist.Retail_Store__c = rs.Id;
        winelist.Start_Date__c = system.today();
        insert winelist;
        
        string json ='[{"AssortmentId":"0aO1x0000004CqvEAE","Id":"0bl1x0000004CqgAAE","Active__c":true,"Bottle_Price__c":1500,"Glass_Price__c":100,"Listing__c":"By Glass and Bottle","Product_Name__c":"LA MOTTE BRUT","ProductId":"01t7R000007nLOtQAM"}]';
        
        string updateWL = WineListController.updateWineList(winelist);
        string createNWL = WineListController.createNewWinelist(winelist);
        string updateWLIs = WineListController.updateWineListItems(json);
        
        
        
    }
    
}