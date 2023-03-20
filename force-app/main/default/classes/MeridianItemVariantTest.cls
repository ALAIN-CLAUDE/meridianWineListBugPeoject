@isTest
private class MeridianItemVariantTest {
    @isTest static void testCallout(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MeridianItemVariantMock());
        MeridianItemVariant.makeItemVariantRequest();
        Test.stopTest();
        // code for all the required test cases
        // ..
        // ..
    }
}