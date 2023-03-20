public class Meridian_Customer_ODATA_Parser {
    public class Meridian_Customer_ODATA_ParserException extends Exception{}
    public static List<Account> parse(String jsonString){
        try{
            List<Account> accToUpdate = new List<Account>();
            Meridian_Customer_ODATA respData = (Meridian_Customer_ODATA) JSON.deserialize(jsonString, Meridian_Customer_ODATA.class);
            //Loop Account Data
            if(!respData.value.isEmpty()){
                for(Meridian_Customer_ODATA.Value data : respData.value){
                    accToUpdate.add(mapAccount(data));
                }
            }
            return accToUpdate;
        }
        catch(Exception e){
            throw new Meridian_Customer_ODATA_ParserException(e.getMessage());
        }
    }

    public static Account mapAccount(Meridian_Customer_ODATA.Value data){
        Account updateAcc = new Account();
        //ExtId
        updateAcc.No__c = data.No;
        updateAcc.Name = data.Name;
        updateAcc.Search_Name__c = data.Search_Name;
        updateAcc.Balance_LCY__c = data.Balance_LCY;
        updateAcc.Balance_Due_LCY__c = data.Balance_Due_LCY;
        updateAcc.Credit_Limit_LCY__c = data.Credit_Limit_LCY;
        updateAcc.Credit_Insurance_Limit_FCY__c = data.CrInsuranceLimitFCY_GEN_LINC;
        updateAcc.Blocked__c = data.Blocked;
        updateAcc.GPS_Latitude__c = data.GPS_Latitude;
        updateAcc.GPS_Longitude__c = data.GPS_Longitude;
        updateAcc.Liquor_Licence_No__c = data.Liquor_License_No;
        updateAcc.Liquor_Licence_Expiry_Date__c = (data.Liquor_License_Expiry_Date != '0001-01-01') ? Date.valueOf(data.Liquor_License_Expiry_Date) : null;
        updateAcc.Salesperson_Code__c = data.Salesperson_Code;
        updateAcc.Salesperson_Name__c = data.Salesperson_Name;
        updateAcc.Responsibility_Center__c = data.Responsibility_Center;
        updateAcc.Total_Sales_2__c = data.TotalSales2;
        updateAcc.Cust_Sales_LCY_Cust_Profit_Adjmt_Cost_LC__c = data.CustSalesLCY_CustProfit_AdjmtCostLCY;
        updateAcc.Adj_Cust_Profit__c = data.AdjCustProfit;
        updateAcc.Adj_Profit_Pct__c = data.AdjProfitPct;
        updateAcc.Last_Date_Modified__c = Date.valueOf(data.Last_Date_Modified);
        updateAcc.Legal_Entity__c = data.Legal_Entity;
        updateAcc.Contact_Name__c = data.ContactName;
        updateAcc.Copy_Sell_to_Addr_to_Qte_From__c = data.Copy_Sell_to_Addr_to_Qte_From;
        updateAcc.Invoice_Copies__c = data.Invoice_Copies;
        updateAcc.Gen_Bus_PostingGroup__c = data.Gen_Bus_Posting_Group;
        updateAcc.VAT_Bus_Posting_Group__c = data.VAT_Bus_Posting_Group;
        updateAcc.Customer_Price_Group__c = data.Customer_Price_Group;
        updateAcc.Customer_Posting_Group__c = data.Customer_Posting_Group;
        updateAcc.Customer_Disc_Group__c = data.Customer_Disc_Group;
        updateAcc.Allow_Line_Disc__c = data.Allow_Line_Disc;
        updateAcc.Prices_Including_VAT__c = data.Prices_Including_VAT;
        updateAcc.Prepayment_Percent__c = data.Prepayment_Percent;
        updateAcc.Credit_Controller__c = data.Credit_Controller;
        updateAcc.Partner_Type__c = data.Partner_Type;
        updateAcc.Payment_Terms_Code__c = data.Payment_Terms_Code;
        updateAcc.Print_Statements__c = data.Print_Statements;
        updateAcc.Last_Statement_No__c = data.Last_Statement_No;
        updateAcc.Application_Method__c = data.Application_Method;
        updateAcc.Location_Code__c = data.Location_Code;
        updateAcc.Combine_Shipments__c = data.Combine_Shipments;
        updateAcc.Reserve__c = data.Reserve;
        updateAcc.Shipping_Advice__c = data.Shipping_Advice;
        updateAcc.Shipment_Method_Code__c = data.Shipment_Method_Code;
        updateAcc.Delivery_Time__c = data.Delivery_Time;
        updateAcc.Use_Sales_Cut_Off_Time__c = data.Use_Sales_Cut_Off_Time;
        updateAcc.Base_Calender__c = data.Base_Calendar_Code;
        updateAcc.Customized_Calendar__c = data.Customized_Calendar;
        updateAcc.Lead_Time__c = data.Lead_Time;
        updateAcc.Route__c = data.Route;
        updateAcc.Direct_to_Consumer__c = data.Direct_to_Consumer;
        updateAcc.Exclude_from_Handling_Fee__c = data.Exclude_from_Handling_Fee;
        updateAcc.Use_Ship_to_Dimension__c = data.Use_Ship_to_Dimension;
        updateAcc.Store_Code__c = data.Store_Code;
        updateAcc.Area_Description__c = data.Area_Description;
        updateAcc.MWM_Grading__c = data.MWM_Grading;
        updateAcc.Segment__c = data.Segment;
        updateAcc.Cluster__c = data.Cluster;
        updateAcc.MWM_Rep_Influence__c = data.MWM_Rep_Influence;
        updateAcc.ExpectedCustMoneyOwed__c = data.ExpectedCustMoneyOwed;
        updateAcc.Total_Money_Owed__c = data.TotalMoneyOwed;
        updateAcc.Calc_Credit_Limit_LCY_Expended_Pct__c = data.CalcCreditLimitLCYExpendedPct;
        updateAcc.Balance_Due__c = data.Balance_Due;
        updateAcc.Payments_LCY__c = data.Payments_LCY;
        updateAcc.Customer_Mgt_Avg_Days_To_Pay_No__c = data.CustomerMgt_AvgDaysToPay_No;
        updateAcc.Days_Paid_Past_Due_Date__c = data.DaysPaidPastDueDate;
        updateAcc.Get_Amount_On_Posted_Invoices__c = data.AmountOnPostedInvoices;
        updateAcc.Get_Amount_On_Outstanding_Cr_Memos__c = data.AmountOnOutstandingCrMemos;
        updateAcc.Totals__c = data.TotalSales2;
        updateAcc.Cust_Inv_Disc_Amount_LCY__c = data.CustInvDiscAmountLCY;
        updateAcc.Consumption__c = data.Consumption;
        updateAcc.Account_Status__c = 'Approved';
        updateAcc.Nav_Status__c = 'Posted';
        updateAcc.National_Group__c = data.Group_Account;
        updateAcc.Nav_Message__c = 'Customer created successfully';
        //Determine Record Type
        switch on data.Consumption {
            when 'OFF' {
                updateAcc.RecordTypeId = '0122X0000003LOQQA2';
            }
            when 'ON' {
                updateAcc.RecordTypeId = '0122X0000003LOLQA2';
            }
            when else {
                updateAcc.RecordTypeId = '0122X0000003LOVQA2';
            }
        }
        return updateAcc;
    }
}