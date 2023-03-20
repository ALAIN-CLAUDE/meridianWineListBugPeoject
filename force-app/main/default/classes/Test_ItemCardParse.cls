@isTest
public class Test_ItemCardParse {
  @isTest
  static void testItemParse(){
    test.startTest();
    List<Product2> item = new List<Product2>();
      
    Dom.Document doc = new Dom.Document();
     
    String XMLBody = '<Soap:Envelope     xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/">     <Soap:Body>         <ReadMultiple_Result             xmlns="urn:microsoft-dynamics-schemas/page/integration_posted_sales_invoice">             <ReadMultiple_Result>                 <Integration_Item_Card>                                            <No> 22</No>                         <Description> 22 </Description>                         <Blocked> false </Blocked>                         <Type>x1</Type>                         <Base_Unit_of_Measure>x2 </Base_Unit_of_Measure>                         <Item_Category_Code>x3 </Item_Category_Code>                         <Automatic_Ext_Texts>x4 </Automatic_Ext_Texts>                         <Smollan_Vendor>x5 </Smollan_Vendor>                         <Search_Description>x6 </Search_Description>                                               <Unit_of_Measure_Code>x8 </Unit_of_Measure_Code>                                     </Integration_Item_Card>             </ReadMultiple_Result>         </ReadMultiple_Result>     </Soap:Body> </Soap:Envelope>';
    
    doc.load(XMLBody);
      
    item = ItemCardParse.itemInfo(doc);
    test.stopTest();
  }

}