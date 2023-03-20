/*
 * Author: Denson K. Zunga
 * Description:  Test class for 'CustomerCardParse'
 * Date: 19 January 2021
 */

@isTest
public class Test_CustomerPriceListParse {
  @isTest
  static void testCustomerPriceListParse(){
    test.startTest();
     List<Customer_Price_List__c> customerPriceList = new List<Customer_Price_List__c>();
      
    Dom.Document doc = new Dom.Document();
     
    String XMLBody = '<Soap:Envelope     xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/">     <Soap:Body>         <ReadMultiple_Result             xmlns="urn:microsoft-dynamics-schemas/page/integration_posted_sales_invoice">             <ReadMultiple_Result>                 <Customer_Price_List>                                           <Key> 22</Key>                         <Customer_No> 22 </Customer_No>                         <Item_No> 12 </Item_No>                         <Specific_Price_Available>true</Specific_Price_Available>                         <Variant_Code>xx </Variant_Code>                         <Unit_of_Measure_Code>xx </Unit_of_Measure_Code>                         <Automatic_Ext_Texts>xx </Automatic_Ext_Texts>                         <Smollan_Vendor>xx </Smollan_Vendor>                         <Search_Description>xx </Search_Description>                         <Inventory>xx </Inventory>                 </Customer_Price_List>             </ReadMultiple_Result>         </ReadMultiple_Result>     </Soap:Body> </Soap:Envelope>';
    
    doc.load(XMLBody);
      
    customerPriceList = CustomerPriceListParse.customerPriceListInfo(doc);
    test.stopTest();
  }
}