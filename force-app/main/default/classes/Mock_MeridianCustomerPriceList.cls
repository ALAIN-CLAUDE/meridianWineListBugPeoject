/*
 * Author: Denson K. Zinga
 * Description: Mock test class for 'Test_MeridianCustomerPriceList'
 * Date: 13 January 2021
 */

global class Mock_MeridianCustomerPriceList implements HttpCalloutMock{
    // interface method
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        String XMLBody;
        
        XMLBody =('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cus="urn:microsoft-dynamics-schemas/page/customer_price_list">'
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
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(XMLBody);
        response.setStatusCode(200);
        return response; 
    }
}