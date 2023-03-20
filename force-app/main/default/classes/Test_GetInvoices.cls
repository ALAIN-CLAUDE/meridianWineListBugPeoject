/**=================================================================================================================================
* Created By: Denson Zunga & Tawanda Madavo
* Created Date: 14/01/2021
* Description: Class to handle invoices callout tests
===================================================================================================================================**/
@isTest
public class Test_GetInvoices {
    @isTest static void GetInvoicesMethod(){ 
        Account acc = new Account();
        acc.Name = 'Test';
        acc.Billing_Street__c = '120 Holkam Road';
        Insert acc;

        Order newOrder = new Order();
        newOrder.Sales_Order_No__c = 'SO000274';
        newOrder.Invoice_Created__c = false;
        newOrder.AccountId = acc.Id;
        newOrder.EffectiveDate = Date.today();
        newOrder.Status = 'Draft';
        Insert newOrder;
        
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new Mock_GetInvoices('Pass'));
        String CRON_EXP = '0 0 0 15 3 ? *';
		String jobId = System.schedule('StartFetchInvoiceTest',  CRON_EXP, new GetInvoices());
        test.stopTest(); 
    }

    @isTest static void FailInternalErrorGetNoBody(){       
        Account acc = new Account();
        acc.Name = 'Test';
        acc.Billing_Street__c = '120 Holkam Road';
        Insert acc;

        Order newOrder = new Order();
        newOrder.Sales_Order_No__c = 'SO000274';
        newOrder.Invoice_Created__c = false;
        newOrder.AccountId = acc.Id;
        newOrder.EffectiveDate = Date.today();
        newOrder.Status = 'Draft';
        Insert newOrder;

        test.startTest();
        Test.setMock(HttpCalloutMock.class, new Mock_GetInvoices('Fail - No Body'));
        String CRON_EXP = '0 0 0 15 3 ? *';
		String jobId = System.schedule('StartFetchInvoiceTest',  CRON_EXP, new GetInvoices());
        test.stopTest(); 
    }

    @isTest static void FailInternalErrorGetInvoicesMethod(){ 
        Account acc = new Account();
        acc.Name = 'Test';
        acc.Billing_Street__c = '120 Holkam Road';
        Insert acc;

        Order newOrder = new Order();
        newOrder.Sales_Order_No__c = 'SO000274';
        newOrder.Invoice_Created__c = false;
        newOrder.AccountId = acc.Id;
        newOrder.EffectiveDate = Date.today();
        newOrder.Status = 'Draft';
        Insert newOrder;

        test.startTest();
        Test.setMock(HttpCalloutMock.class, new Mock_GetInvoices('Fail - Internal Error'));
        String CRON_EXP = '0 0 0 15 3 ? *';
		String jobId = System.schedule('StartFetchInvoiceTest',  CRON_EXP, new GetInvoices());
        test.stopTest(); 
    }
}