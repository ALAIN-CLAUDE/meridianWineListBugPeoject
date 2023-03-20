/*
 * Author: Denson K. Zunga
 * Description:  Test class for 'ItemVariantParse'
 * Date: 19 January 2021
 */

@isTest
public class Test_ItemVariantParse {
  @isTest
  static void testItemParse(){
    test.startTest();
    List<Item_Variant__c> itemVariant = new List<Item_Variant__c>();
      
    Dom.Document doc = new Dom.Document();
     
    String XMLBody = '<Soap:Envelope     xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/">     <Soap:Body>         <ReadMultiple_Result>             xmlns="urn:microsoft-dynamics-schemas/page/integration_posted_sales_invoice">             <ReadMultiple_Result>                 <Item_Variant>                                            <Key> 22</Key>                         <Code> mycode </Code>                         <Description> 22 </Description>                         <Blocked> false </Blocked>                        <Item_No> 1</Item_No>                         <Type>x1</Type>                                                 <Description_2>x3 </Description_2>                         <Exclude_from_Consignment>false </Exclude_from_Consignment>                         <Strategy>x5 </Strategy>                         <Commisionable>x6 </Commisionable>                                              <Unit_of_Measure_Code>x8 </Unit_of_Measure_Code>                                     </Item_Variant>             </ReadMultiple_Result>         </ReadMultiple_Result>     </Soap:Body> </Soap:Envelope>';
    
    doc.load(XMLBody);
      
    itemVariant = ItemVariantParse.itemVariantInfo(doc);
    test.stopTest();
  }
}