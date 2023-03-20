/*
 * Author: Denson K. Zunga
 * Description: Mock class for class 'MeridianItemCard'
 * Date: 14 January 2021
 */
global class Mock_MeridianItemCard implements HttpCalloutMock {
    global String type;
    global Mock_MeridianItemCard(String type){
        this.type = type;
    }
	// interface method
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        
        String XMLBody, groupName;
        
        groupName = 'TestGroupName';
            
        XMLBody = '<Soap:Envelope xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/"><Soap:Body><ReadMultiple_Result xmlns="urn:microsoft-dynamics-schemas/page/integration_item_card"><ReadMultiple_Result><Integration_Item_Card><Key>24;GwAAAAJ7/0EAUgAwADAAMQ==10;76777350370;</Key><No>AR001</No><Description>Anthonij Rupert Optima Tins 750ml</Description><Blocked>false</Blocked><Type>Inventory</Type><Base_Unit_of_Measure>EACH</Base_Unit_of_Measure><Last_Date_Modified>2020-12-08</Last_Date_Modified><Item_Category_Code>PAC</Item_Category_Code><Automatic_Ext_Texts>false</Automatic_Ext_Texts><Created_From_Nonstock_Item>false</Created_From_Nonstock_Item><Smollan_Vendor>Meridian_GWL</Smollan_Vendor><Search_Description>ANTHONIJ RUPERT OPTIMA TINS 750ML</Search_Description><Inventory>17</Inventory><Qty_on_Purch_Order>3</Qty_on_Purch_Order><Qty_on_Prod_Order>0</Qty_on_Prod_Order><Qty_on_Component_Lines>0</Qty_on_Component_Lines><Qty_on_Sales_Order>0</Qty_on_Sales_Order><Qty_on_Service_Order>0</Qty_on_Service_Order><Qty_on_Job_Order>0</Qty_on_Job_Order><Qty_on_Assembly_Order>0</Qty_on_Assembly_Order><Qty_on_Asm_Component>0</Qty_on_Asm_Component><StockoutWarningDefaultYes>Default</StockoutWarningDefaultYes><PreventNegInventoryDefaultYes>Default</PreventNegInventoryDefaultYes><Net_Weight>0</Net_Weight><Gross_Weight>0</Gross_Weight><Unit_Volume>0</Unit_Volume><Costing_Method>FIFO</Costing_Method><Standard_Cost>0</Standard_Cost><Unit_Cost>0.00904</Unit_Cost><Indirect_Cost_Percent>0</Indirect_Cost_Percent><Last_Direct_Cost>0.01</Last_Direct_Cost><Net_Invoiced_Qty>-298.00001</Net_Invoiced_Qty><Cost_is_Adjusted>true</Cost_is_Adjusted><Cost_is_Posted_to_G_L>true</Cost_is_Posted_to_G_L><SpecialPurchPricesAndDiscountsTxt>View Existing Prices and Discounts...</SpecialPurchPricesAndDiscountsTxt><Gen_Prod_Posting_Group>MW</Gen_Prod_Posting_Group><VAT_Prod_Posting_Group>VAT15</VAT_Prod_Posting_Group><Inventory_Posting_Group>CONSSTOCK</Inventory_Posting_Group><Unit_Price>0</Unit_Price><CalcUnitPriceExclVAT>0</CalcUnitPriceExclVAT><Price_Includes_VAT>false</Price_Includes_VAT><Price_Profit_Calculation>No_Relationship</Price_Profit_Calculation><Profit_Percent>0</Profit_Percent><SpecialPricesAndDiscountsTxt>View Existing Prices and Discounts...</SpecialPricesAndDiscountsTxt><Allow_Invoice_Disc>true</Allow_Invoice_Disc><Item_Disc_Group>AR</Item_Disc_Group><Inventory_Value_Zero>false</Inventory_Value_Zero><Sales_Unit_of_Measure>EACH</Sales_Unit_of_Measure><Sales_Blocked>false</Sales_Blocked><Default_Variant>NV</Default_Variant><Replenishment_System>Purchase</Replenishment_System><Vendor_No>LOR001</Vendor_No><Purch_Unit_of_Measure>EACH</Purch_Unit_of_Measure><Purchasing_Blocked>false</Purchasing_Blocked><Manufacturing_Policy>Make_to_Stock</Manufacturing_Policy><Rounding_Precision>1</Rounding_Precision><Flushing_Method>Manual</Flushing_Method><Overhead_Rate>0</Overhead_Rate><Scrap_Percent>0</Scrap_Percent><Lot_Size>0</Lot_Size><Assembly_Policy>Assemble_to_Stock</Assembly_Policy><Assembly_BOM>false</Assembly_BOM><Reordering_Policy>_blank_</Reordering_Policy><Reserve>Always</Reserve><Order_Tracking_Policy>None</Order_Tracking_Policy><Stockkeeping_Unit_Exists>true</Stockkeeping_Unit_Exists><Dampener_Quantity>0</Dampener_Quantity><Critical>false</Critical><Safety_Stock_Quantity>0</Safety_Stock_Quantity><Include_Inventory>false</Include_Inventory><Reorder_Point>0</Reorder_Point><Reorder_Quantity>0</Reorder_Quantity><Maximum_Inventory>0</Maximum_Inventory><Overflow_Level>0</Overflow_Level><Minimum_Order_Quantity>0</Minimum_Order_Quantity><Maximum_Order_Quantity>0</Maximum_Order_Quantity><Order_Multiple>0</Order_Multiple><Phys_Invt_Counting_Period_Code>MONTHLY</Phys_Invt_Counting_Period_Code><Last_Phys_Invt_Date>0001-01-01</Last_Phys_Invt_Date><Last_Counting_Period_Update>0001-01-01</Last_Counting_Period_Update><Next_Counting_Start_Date>2020-12-01</Next_Counting_Start_Date><Next_Counting_End_Date>2020-12-31</Next_Counting_End_Date><Identifier_Code>6009803752332</Identifier_Code><Use_Cross_Docking>true</Use_Cross_Docking></Integration_Item_Card></ReadMultiple_Result></ReadMultiple_Result></Soap:Body></Soap:Envelope>';
        
        response.setHeader('Content-Type', 'application/json');
        if(type == 'PASS'){
            response.setBody(XMLBody);
            response.setStatusCode(200);
        }
        else{
            response.setBody('');
            response.setStatusCode(400);
        }
        return response; 
    }
}