/**=================================================================================================================================
* Created By: Denson Zunga & Tawanda Madavo
* Created Date: 14/01/2021
* Description: Class to handle sales order callout tests
===================================================================================================================================**/

@isTest
public class Test_MeridianSalesOrders {
    @isTest 
    static void testSalesOrdersRequest() {
        Account a = new Account();
        a.Name = 'Placeholder Transaction Account';
        a.Billing_Street__c = 'Placeholder Billing Street';
        insert a;

        Product2 prod = new Product2();
        prod.Name = 'La Motte Sauvignon Blanc 2021';
        prod.Description = 'La Motte Sauvignon Blanc 2021';
        prod.ProductCode = 'LMSAB';
        prod.Unit_of_Measure_Code__c = 'C06X750';
        prod.No__c = 'LMSAB';
        Insert prod;

        Pricebook2 natPB = new Pricebook2();
        natPB.Name = 'National Price List P01';
        Insert natPB;

        Test.setMock(HttpCalloutMock.class, new Mock_MeridianSalesOrders('Pass')); 
        MeridianSalesOrders.makeSalesOrdersRequest();
    }

    @isTest
    static void testFailSalesOrdersRequest(){        
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianSalesOrders('Fail - No Body')); 
        MeridianSalesOrders.makeSalesOrdersRequest();     
    }

    @isTest
    static void testSalesOrdersRequestInternalError(){        
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianSalesOrders('Fail - Internal Error')); 
        MeridianSalesOrders.makeSalesOrdersRequest();     
    }

    @isTest
    static void testWebLogCallOverload(){        
        Util_NavEnvironment.logWebCall(
            'Get Sales Orders',
            'Outbound',
            'Request Body',
            'Error Body',
            false,
            'Order Number',
            'Reference'
        );
    }
}