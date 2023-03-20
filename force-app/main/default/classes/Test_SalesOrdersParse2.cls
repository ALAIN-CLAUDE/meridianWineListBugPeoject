/*
 * Author: Denson K. Zunga
 * Description:  Test class for 'CustomerCardParse'
 * Date: 19 January 2021
 */
@isTest
public class Test_SalesOrdersParse2 {
  @isTest
  static void testSalesOrdertParse(){
    test.startTest();

    Dom.Document docSalesOrder 		= new Dom.Document();
    Dom.Document docSalesOrderError = new Dom.Document();
      
      
    String XMLBody = '<Soap:Envelope     xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/">     <Soap:Body>         <ReadMultiple_Result             xmlns="urn:microsoft-dynamics-schemas/page/integration_posted_sales_invoice">             <ReadMultiple_Result>                 <Integration_Sales_Order>                                           <No> 22</No>                         <Sell_to_Customer_No> 22 </Sell_to_Customer_No>                         <Sell_to_Customer_Name>true</Sell_to_Customer_Name>                                  <Posting_Date>0001-01-01 </Posting_Date>                         <Order_Date>0001-01-01 </Order_Date>                         <Document_Date>0001-01-01 </Document_Date>                         <Requested_Delivery_Date>0001-01-01 </Requested_Delivery_Date>                         <Promised_Delivery_Date>0001-01-01 </Promised_Delivery_Date>                         <External_Document_No>0001-01-01 </External_Document_No>                         <Salesperson_Code>0001-01-01 </Salesperson_Code>                         <Job_Queue_Status>0001-01-01 </Job_Queue_Status>                         <Created_By>a1 </Created_By>                         <Bill_to_Customer_No>a2 </Bill_to_Customer_No>                         <Bill_to_Name>a2 </Bill_to_Name>                         <Due_Date>0001-01-01 </Due_Date>                         <Prices_Including_VAT>true </Prices_Including_VAT>                         <VAT_Bus_Posting_Group>a3 </VAT_Bus_Posting_Group>                         <Ship_to_Code>a4 </Ship_to_Code>                         <Ship_to_Name>a5 </Ship_to_Name>                         <Route>a6 </Route>                         <Shipment_Method_Code>a7 </Shipment_Method_Code>                         <Late_Order_Shipping>false </Late_Order_Shipping>                         <Shipment_Date>false </Shipment_Date>                         <Shipping_Advice>a5 </Shipping_Advice>                         <EU_3_Party_Trade>false </EU_3_Party_Trade>                         <Compress_Prepayment>false </Compress_Prepayment>                         <Prepayment_Due_Date>true </Prepayment_Due_Date>                 </Integration_Sales_Order>             </ReadMultiple_Result>         </ReadMultiple_Result>     </Soap:Body> </Soap:Envelope>';
    String XMLError = '<Soap:Envelope     xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/">     <Soap:Body>         <Fault             xmlns="urn:microsoft-dynamics-schemas/page/integration_posted_sales_invoice">             <detail>                 <string>                                     </string>             </detail>         </Fault>     </Soap:Body> </Soap:Envelope>';
    
    docSalesOrder.load(XMLBody);
    docSalesOrderError.load(XMLError);
      
    String salesOrderNo = SalesOrdersParse2.salesOrderResp(docSalesOrder);
    
    String errorMsg = SalesOrdersParse2.salesOrderErrorResp(docSalesOrderError);
    test.stopTest();
  }
}