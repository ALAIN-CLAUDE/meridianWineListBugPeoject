/*
 * Author: Denson K. Zunga
 * Description: Test class for Trig_Account
 * Date: 21 January 2021
 */

@isTest
public class Test_Trig_Account {
	@isTest
    static void testAccountWithoutCaseNo(){        
        Account acc = new Account(Name = 'D5 Acc', Account_Status__c = 'Invalid');
        
        insert acc;
        
        Test.startTest();
        acc.Account_Status__c = 'Approved';
        Database.update(acc);
        Test.stopTest();
           
    }

@isTest
    static void testAccountWithCaseNo(){        
        Account acc = new Account(Name = 'D5 Acc', Account_Status__c = 'Invalid', No__c = 'xxx');
        
        insert acc;
        
        Test.setMock(HttpCalloutMock.class, new Mock_CreateCustomer());
        Test.startTest();
        acc.Account_Status__c = 'Approved';
        Database.update(acc);
        Test.stopTest();
           
    }    
    
}