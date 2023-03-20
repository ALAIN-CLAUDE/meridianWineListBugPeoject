/**=================================================================================================================================
* Created By: Denson Zunga & Tawanda Madavo
* Created Date: 14/01/2021
* Description: Test class for MeridianItemCard
===================================================================================================================================**/

@isTest
public class Test_MeridianItemCard {

    @TestSetup
    static void makeData(){
        Pricebook2 newPB = new Pricebook2();
        newPB.Name = 'National Price List P01';
        Insert newPB;
    }
    
    @isTest 
    static void testMeridianItemCard_Pass(){
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianItemCard('PASS')); 
        Product2 prod = new Product2();
        prod.Name = 'Test Product';
        prod.No__c = 'ABCTEST101';
        prod.ProductCode = 'ABCTEST101';
        Insert prod;
        
        Posting_Groups__c groupItem = new Posting_Groups__c();
        groupItem.Name = 'Test';
        Insert groupItem;

        Test.startTest();
        String CRON_EXP = '0 0 0 3 9 ? 2022';
        String jobId = System.schedule('MeridianProductsTest', CRON_EXP, new MeridianItemCard());
        Test.stopTest();
    }

    @isTest 
    static void testMeridianItemCard_Fail(){
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianItemCard('FAIL')); 
        Posting_Groups__c groupItem = new Posting_Groups__c();
        groupItem.Name = 'Test';
        Insert groupItem;

        Test.startTest();
        String CRON_EXP = '0 0 0 3 9 ? 2022';
        String jobId = System.schedule('MeridianProductsTest', CRON_EXP, new MeridianItemCard());
        Test.stopTest();
    }
}