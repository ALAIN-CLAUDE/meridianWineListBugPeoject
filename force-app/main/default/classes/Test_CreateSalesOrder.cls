/*
* Author: Denson K. Zunga
* Decription: Test class for class 'CreateSalesOrder'
* Date: 12 January 2021
*/

@isTest
public class Test_CreateSalesOrder {
    @isTest static void CreateSalesOrder(){
        
        Date sysDate = system.today();
        
        Test.setMock(HttpCalloutMock.class, new Mock_CreateSalesOrder());  
        
         //Insert Account
        Account MyAcc =new Account();
        MyAcc.Name = 'Rand Water';
        MyAcc.Phone = '0715679297';
        MyAcc.Type = 'Business';
        MyAcc.Billing_Street__c = '120 Holkam Road';
        INSERT MyAcc;
        
        //Insert Contact
        Contact MyContact = new Contact();
        MyContact.FirstName = 'Mike';
        MyContact.LastName = 'Sccot';
        MyContact.Email = 'Innocent.Ngwenya93@gmail.com';
        MyContact.Phone = '0759875555';
        MyContact.AccountId = MyAcc.Id;
        INSERT MyContact;
        
        //Insert Product
        Product2 MyProduct = new Product2();
        MyProduct.Name = 'Product 3D';
        MyProduct.ProductCode = 'LTP-Pty';
        MyProduct.Family = 'Resources';
        MyProduct.IsActive = true;
                
        INSERT MyProduct;

        // get standard price book ID.
        Id standardPBId = Test.getStandardPricebookId();
        
        // insert a test/custom pricebook.
        Pricebook2 customPB = new Pricebook2(Name = 'Test Pricebook', 
                                             IsActive = true);
        insert customPB;
                
        //Insert Order
        Order MyOrder = new Order();
        MyOrder.Name = 'Valpre';
        MyOrder.BillingStreet = '993 Midrand';
        MyOrder.BillingCity = 'Kempton Park';
        MyOrder.BillingCountry = 'South Africa';
        MyOrder.BillingPostalCode = '1632';
        MyOrder.Description = 'Testing';
        MyOrder.AccountId = MyAcc.Id;
        MyOrder.EffectiveDate = system.today();
        MyOrder.Status = 'Draft'; 
        MyOrder.Pricebook2Id = standardPBId;
        //MyOrder.Due_Date__c = sysDate + 3;
        MyOrder.Requested_Delivery_Date__c = system.today()+2;
        INSERT MyOrder;
        
         // create a price book entry for the standard price book.
        PricebookEntry standardPBE = new PricebookEntry(Pricebook2Id = standardPBId, 
                                                        Product2Id = MyProduct.Id,
                                                        IsActive = true,
                                                        UnitPrice = 154.00);
        insert standardPBE;
        
        // create a price book entry for the custom price book.
        PricebookEntry customPBE = new PricebookEntry(Pricebook2Id = customPB.Id, 
                                                      Product2Id = MyProduct.Id, 
                                                      isActive = true, 
                                                      UnitPrice = 155.00);
        insert customPBE;       
        
        System.debug('getStandardPricebookId: ' + standardPBE.Pricebook2Id);

        try{
            System.debug('ERROR A: Now at line #111');
            Test.startTest();
            INSERT standardPBE;
            Test.stopTest();
            System.debug('ERROR A: Now at line #222');
        }
        catch(Exception ex){
            System.debug('ERROR B: ' + ex.getMessage() + ' at line #' + ex.getLineNumber() +  ' >>>' + ex.getCause());
        }
        
        //Insert OrderItems
        OrderItem MyOrderItems = new OrderItem();
        MyOrderItems.Quantity = 5;
        MyOrderItems.UnitPrice = 5000;
        MyOrderItems.Description = 'Testing Item';
        MyOrderItems.OrderId = MyOrder.Id;
        MyOrderItems.Product2Id = MyProduct.Id;
        MyOrderItems.PricebookEntryId = standardPBE.Id;
       
        system.debug('PRICE BOOK ENTRY 1: ' + standardPBE.Pricebook2Id);
        //system.debug('PRICE BOOK ENTRY 2: ' + pbe.Id);
        system.debug('PRICE BOOK ENTRY 3: ' + standardPBE.Id);
        INSERT MyOrderItems;
        
        List <Order> orderRecords = new List <Order> ();
        orderRecords.add(MyOrder);
        
      
        CreateSalesOrder.invokeMethod(orderRecords);
        test.stopTest();
    }
}