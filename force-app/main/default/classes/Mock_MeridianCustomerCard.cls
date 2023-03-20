/**=================================================================================================================================
* Created By: Denson Zunga & Tawanda Madavo
* Created Date: 14/01/2021
* Description: Class to handle mock responses for customer card tests
===================================================================================================================================**/

global class Mock_MeridianCustomerCard implements HttpCalloutMock{

    global String responseType;
    global Mock_MeridianCustomerCard(String responseType){
        this.responseType = responseType;
    }
    // interface method
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        String jsonSuccessSample = '{"@odata.context":"https://nav.groupmeridian.co.za:1648/BCODATA/ODataV4/$metadata#Company(\'Cool%20Wines\')/Integration_Customer_Card","@odata.count": 68,"value":[{"@odata.etag":"WJzQ0O3B1dHZweGF4cHlOeHFkRnJmVmFDR1N4Y3h1V0VCeUxkYkxvOFJsaTB2Mmc9MTswMDsn","No":"BOH401","Name":"Bohemia Art Gallery and Wine Bar","Name_2":"","Search_Name":"BOHEMIA ART GALLERY AND WINE BAR","IC_Partner_Code":"","Balance_LCY":0,"Balance_Due_LCY":0,"Credit_Limit_LCY":1,"CreditLimitFCY_GEN_LINC":0,"CrInsuranceLimitFCY_GEN_LINC":0,"Blocked":" ","GPS_Latitude":"-33.959400","GPS_Longitude":"25.611320","Liquor_License_No":"ECP26757/90454/OO","Liquor_License_Expiry_Date":"2022-12-31","Privacy_Blocked":false,"Salesperson_Code":"59","Salesperson_Name":"04 PE Inland","Responsibility_Center":"PE","Service_Zone_Code":"","TotalSales2":19857.02,"CustSalesLCY_CustProfit_AdjmtCostLCY":14471.97,"AdjCustProfit":5385.05,"AdjProfitPct":27.1,"Last_Date_Modified":"2022-04-04","Created_Date_Time":"0001-01-01T00:00:00Z","Company_Reg_ID_No":"","Legal_Entity":"Prepayment","Disable_Search_by_Name":false,"RecordIsRestricted":false,"RelatedBusEntityCode_GEN_LINC":"","Address":"","Address_2":"Stanley Street 20","Address_3":"Richmond Hill","Country_Region_Code":"ZA","County":"EASTERN CAPE","City":"RICHMOND HILL","Post_Code":"6001","ShowMap":"Show on Map","Phone_No":"","MobilePhoneNo_GEN_LINC":"","MobilePhoneNo":"","E_Mail":"michelle.ruth.jacobs@gmail.com","Fax_No":"","Home_Page":"","Language_Code":"","Primary_Contact_No":"61256","ContactName":"Michelle Jacobs","Bill_to_Customer_No":"BOH401","VAT_Registration_No":"","RegistrationNo_GEN_LINC":"","EORI_Number":"","GLN":"","Account_ID":"","Use_GLN_in_Electronic_Document":false,"Copy_Sell_to_Addr_to_Qte_From":"Company","Tax_Liable":false,"Tax_Area_Code":"","Invoice_Copies":1,"Gen_Bus_Posting_Group":"LOCAL","VAT_Bus_Posting_Group":"VAT14","Customer_Price_Group":"P01","Customer_Posting_Group":"C01B","Currency_Code":"","SameCurrencyMandatory_GEN_LINC":"Default","Price_Calculation_Method":" ","PreventZeroSalesPricesDefaultYes":"Default","Customer_Disc_Group":"01B","Allow_Line_Disc":true,"Prices_Including_VAT":false,"Prepayment_Percent":0,"Credit_Controller":"6","Partner_Type":" ","Payment_Terms_Code":"NCTPPAY","Payment_Method_Code":"","Reminder_Terms_Code":"","Fin_Charge_Terms_Code":"","Cash_Flow_Payment_Terms_Code":"","Print_Statements":false,"Last_Statement_No":2,"Block_Payment_Tolerance":false,"Preferred_Bank_Account_Code":"","FinanceProvider_GEN_LINC":"","Application_Method":"Manual","Invoice_Disc_Code":"BOH401","Ship_to_Code":"BOH401","Location_Code":"CTN-WHSE","Combine_Shipments":false,"Reserve":"Optional","Shipping_Advice":"Partial","Shipment_Method_Code":"HANDOVER","Shipping_Agent_Code":"","Shipping_Agent_Service_Code":"","Shipping_Time":"","Delivery_Time":"1D","Use_Sales_Cut_Off_Time":false,"Base_Calendar_Code":"CALENDAR","Customized_Calendar":"No","Lead_Time":"1D","Route":"COECONCV07","Direct_to_Consumer":false,"Delivery_Instructions":"","Default_Ship_to_Address":"BOH401","Exclude_from_Handling_Fee":false,"Exclude_from_Minimum_Order_Fee":false,"Use_Ship_to_Dimension":false,"Store_Code":"","Area_Description":"04 PE ON CON","MWM_Grading":"A","CLM_Rep_Area":"04 PE TELESALES","CLM_Grading":"B","Segment":"S1","Cluster":"04-RICHMOND HILL","CLM_Channel":"","CLM_Segment":"","CLM_Cluster":"","Consumption":"ON","Group_Account":"","Document_Sending_Profile":"CUSTOMER","CAM_Rep_Area":"","CAM_Grading":"","MWM_Rep_Influence":"REP100","ExpectedCustMoneyOwed":0,"TotalMoneyOwed":0,"CalcCreditLimitLCYExpendedPct":0,"Balance_Due":0,"Payments_LCY":22835.57,"CustomerMgt_AvgDaysToPay_No":-0.3333333333333333,"DaysPaidPastDueDate":9,"AmountOnPostedInvoices":19857.02,"AmountOnCrMemo":0,"AmountOnOutstandingInvoices":0,"AmountOnOutstandingCrMemos":0,"CustInvDiscAmountLCY":0,"Global_Dimension_1_Filter":"","Global_Dimension_2_Filter":"","Currency_Filter":""}]}';
        
        response.setHeader('Content-Type', 'application/json');
        if(responseType == 'Pass'){
            response.setBody(jsonSuccessSample);
            response.setStatusCode(200);
        }
        else if(responseType == 'Fail - Malformed Body'){
            response.setBody('{"@odata.context":"https://nav.groupmeridian.co.za:1648/BCODATA/ODataV4/$metadata#Company(\'Cool%20Wines\')/Integration_Customer_Card","@odata.count": 68,"value":[{"@odata.etag":"W/\"JzQ0O3B1dHZweGF4cHlOeHFkRnJmVmFDR1N4Y3h1V0VCeUxkYkxvOFJsaTB2Mmc9MTswMDsn\""}]}');
            response.setStatusCode(200);
        }
        else if(responseType == 'Fail - Internal Error'){
            response.setStatusCode(500);
        }
        return response; 
    }    
}