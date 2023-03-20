/**=================================================================================================================================
* Created By: Denson Zunga & Tawanda Madavo
* Created Date: 14/01/2021
* Description: Class to handle tests for customer card callout
===================================================================================================================================**/

@isTest
public class Test_MeridianCustomerCard {

    @isTest 
    static void testCustomerCardRequest(){        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianCustomerCard('Pass')); 
        System.schedule('MeridianCustomerCard', '0 0 * * * ?', new MeridianCustomerCard());    
        Test.stopTest();
    }

    @isTest
    static void testFailCustomerCardRequestNoBody(){   
        Test.startTest();     
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianCustomerCard('Fail - Malformed Body')); 
        System.schedule('MeridianCustomerCard', '0 0 * * * ?', new MeridianCustomerCard());      
        Test.stopTest();
    }

    @isTest
    static void testFailCustomerCardRequestInternalError(){      
        Test.startTest();  
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianCustomerCard('Fail - Internal Error')); 
        System.schedule('MeridianCustomerCard', '0 0 * * * ?', new MeridianCustomerCard());       
        Test.stopTest();
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

    @isTest
    static void testGetEnvironmentUrl(){        
        Util_NavEnvironment.getNavBaseUrl();
    }

    @isTest
    static void testSendMail(){        
        Util_NavEnvironment.sendMail(new List<String> {'test@test.com'}, new List<String>(), 'test', 'test');
    }
}