/*
 * Author: Denson K. Zunga
 * Description: Test class for the 'MeridianCustomerPriceList' class
 * Date: 14 January 2021
 */

@isTest
public class Test_MeridianCustomerPriceList {
    @isTest 
    static void testPriceListCallout() {
       
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new Mock_MeridianCustomerPriceList()); 
        
        Test.startTest();
        MeridianCustomerPriceList.makePriceListRequest();
        Test.stopTest();
        
        String XMLBody =('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cus="urn:microsoft-dynamics-schemas/page/customer_price_list">'
                  +'<soapenv:Header/>'
                  +'<soapenv:Body>'
                  +'<cus:ReadMultiple>'
                  +'<!--1 or more repetitions:-->'
                  +'<cus:filter>'
                  +'<cus:Field>Customer_No</cus:Field>'
                  +'<cus:Criteria>*</cus:Criteria>'
                  +'</cus:filter>'
                  +'<!--Optional:-->'
                  +'<cus:bookmarkKey></cus:bookmarkKey>'
                  +'<cus:setSize>200</cus:setSize>'
                  +'</cus:ReadMultiple>'
                  +'</soapenv:Body>'
                  +'</soapenv:Envelope>'
                 );
        
      /*String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = XMLBody;
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode()); */
    }
}