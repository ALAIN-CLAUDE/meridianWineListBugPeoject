@isTest
global class MeridianItemVariantMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request){
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('<xml><test></test></xml>'); // replace with the correct response body 
        return response;
    }

}