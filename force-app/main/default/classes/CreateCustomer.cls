public class CreateCustomer {
    public static HttpRequest httpRequest = new HttpRequest();
    public static HttpResponse httpResponse = new HttpResponse();
    public static List <Account> accRecords;
    
    @InvocableMethod
    public static void invokeMethod(List <Account> accRecords){
        //System.debug('Order Record: '+accRecords);
        System.debug('INSIDE CreateCustomer.invokeMethod with Account = ' + accRecords);
        callRequestMethod(accRecords.get(0).Id);
        
    }
    
    @future(callout=true)
    Public Static void callRequestMethod(String accId){
        System.debug('INSIDE CreateCustomer.callRequestMethod with accId = ' + accId);
        List <Account> AccList = [SELECT Id, IsDeleted, Name, MasterRecordId, LastName, FirstName, Salutation, MiddleName, Suffix, Type, RecordTypeId, BillingStreet, ParentId, BillingCity, 
                                  BillingState, BillingPostalCode, BillingCountry, BillingLongitude, BillingLatitude, BillingGeocodeAccuracy, BillingAddress, ShippingStreet, ShippingState, 
                                  ShippingCity, ShippingPostalCode, ShippingCountry, ShippingLatitude, ShippingLongitude, ShippingGeocodeAccuracy, ShippingAddress, Phone, AccountNumber, Fax, 
                                  Website, Sic, PhotoUrl, NumberOfEmployees, AnnualRevenue, Ownership, TickerSymbol, Description, Rating, OwnerId, Site, CreatedDate, LastModifiedDate, CreatedById, 
                                  LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, PersonContactId, IsPersonAccount, PersonMailingStreet, Jigsaw, AccountSource, 
                                  JigsawCompanyId, SicDesc, OperatingHoursId, Completed_Application_Form__c, CK1_Founding_Statement__c, Bank_Confirmation_Letter__c, Deed_of_Surety_Signed__c, 
                                  Liquor_License__c, Members_Directors_Trustees_Resolution__c, Memorandum_of_Incorporation__c, Nominated_Delivery_Day__c, Onwer_ID__c, Store_Letter_Incl_VAT__c, 
                                  Trust_Deed__c, Terms_and_Conditions_Signed__c, VAT_Registration_Certificate__c, RSM__c, VAT_Bus_Posting_Group__c, account_picklist1__c, Region__c, Account_Status__c, 
                                  Adj_Cust_Profit__c, Adj_Profit_Pct__c, Aged_Acc_Receivable_Chart_Aged_Acc_Recei__c, Allow_Line_Disc__c, Alt_Account_Name__c, Application_Method__c, Balance_Due_LCY__c, 
                                  Balance_LCY__c, Balance_Due__c, Base_Calender__c, Bill_to_Customer_No__c, BillingStreet__c, Billing_Street__c, Block_Payment_Tolerance__c, Blocked__c, 
                                  Calc_Credit_Limit_LCY_Expended_Pct__c, CAM_Rep_Area__c, Company_Reg_ID_No__c, Combine_Shipments__c, Copy_Sell_to_Addr_to_Qte_From__c, Contact_Name__c, 
                                  Credit_Controller__c, Credit_Limit_FCY__c, Credit_Insurance_Limit_FCY__c, Credit_Limit_LCY__c, Cust_Inv_Disc_Amount_LCY__c, Cust_Sales_LCY_Cust_Profit_Adjmt_Cost_LC__c,
                                  Customer_Mgt_Avg_Days_To_Pay_No__c, Customized_Calendar__c, Days_Paid_Past_Due_Date__c, Default_Ship_to_Address__c, Delivery_Instruction__c, Delivery_Time__c, 
                                  Direct_to_Consumer__c, Direct_to_Customer__c, Disable_Search_by_Name__c, Email__c, ExpectedCustMoneyOwed__c, GPS_Latitude__c, GPS_Longitude__c, Gen_Bus_PostingGroup__c, 
                                  Get_Amount_On_Cr_Memo__c, Get_Amount_On_Outstanding_Cr_Memos__c, Get_Amount_On_Outstanding_Invoices__c, Get_Amount_On_Posted_Invoices__c, Invoice_Copies__c, Key__c, 
                                  Invoice_Disc_Code__c, Last_Statement_No__c, Last_Date_Modified__c, Liquor_Licence_No__c, Liquor_Licence_Expiry_Date__c, Outstanding_Orders_LCY__c, No__c, Partner_Type__c, 
                                  Payment_Terms_Code__c, Payments_LCY__c, Phone_No__c, Prices_Including_VAT__c, Price_And_Line_Disc__c, Prepayment_Percent__c, Print_Statements__c, Privacy_Blocked__c, 
                                  Registration_No__c, Reserve__c, Salesperson_Name__c, Responsibility_Center__c, Search_Name__c, Shipping_Advice__c, Store_Code__c, Shipping_Time__c, Total_Sales_2__c, 
                                  Total_Money_Owed__c, Use_Ship_to_Dimension__c, Sales_Consultant__c, BlockedReadOnly__c, Customer_Price_Group__c, Exclude_from_Minimum_Order_Fee__c, CLM_Rep_Area__c, 
                                  Shipment_Method_Code__c, Route__c, Segment__c, Lead_Time__c, MWM_Rep_Influence__c, Rep_Area__c, Cluster__c, Salesperson_Code__c, Group_Account__c, National_Group__c, 
                                  Location_Code__c, Consumption__c, MWM_Grading__c, Currency_Code__c, Warehouse__c, Area_Description__c, CLM_Grading__c, Exclude_from_Handling_Fee__c, 
                                  Customer_Disc_Group__c, VAT_Registration_No__c, Totals__c, Use_Sales_Cut_Off_Time__c, Customer_Posting_Group__c, Legal_Entity__c, Fax_No__pc, Nav_Message__c,
                                  Nav_Status__c, Bill_To_Customer_Number__c  FROM Account
                                  WHERE Id =:accId
                                 ];
        
        System.debug('AccList: '+AccList);
        
        createCustomerRequest(AccList.get(0));
    }
    
    Public Static void createCustomerRequest(Account acc){
        System.debug('INSIDE CreateCustomer.createCustomerRequest with No = ' + acc.No__c);
        String requestBody = getSoapEnvelope(acc);
        Http http = new Http();
        httpRequest.setBody(requestBody);
        httpRequest.setEndpoint(Util_NavEnvironment.getNavBaseUrl() + '/WS/Cool%20Wines/Page/Integration_Customer_Card');
        httpRequest.setMethod('POST');
        httpRequest.setTimeout(40000);
        httpRequest.setHeader('Content-Type','text/xml;charset=UTF-8');
        httpRequest.setHeader('Accept-Encoding','gzip,deflate');
        httpRequest.setHeader('SOAPAction','"urn:microsoft-dynamics-schemas/page/integration_customer_card:Create"');
        
        System.debug('Request: '+httpRequest);
        
        httpResponse = http.send(httpRequest);
        System.debug('Response Status Code**:' + httpResponse.getStatusCode());
        System.debug('Response Status***:' + httpResponse.getStatus());
        System.debug('Response Body****:' + httpResponse.getBody());
        
        dom.Document resDoc = httpResponse.getBodyDocument();
        System.debug('debug: '+resDoc.toXmlString());
        
        if(httpResponse.getStatusCode() == 200 || httpResponse.getStatusCode() == 201){
            acc.Nav_Status__c = 'Posted';
            acc.Nav_Message__c = 'Posted Successfully';
            Util_NavEnvironment.logWebCall('Create Customer', 'Outbound', requestBody, httpResponse.getBody(), true, acc.Id);
            
            
            //---------------------------- Send Shipping Details ---------------------------------//
            HttpRequest httpRequestShipping = new HttpRequest();
            HttpResponse httpResponseShipping = new HttpResponse();
            
            String shippingBody = getShippingAddressSoapEnvelope(acc);
            httpRequestShipping.setBody(shippingBody);
            httpRequestShipping.setEndpoint(Util_NavEnvironment.getNavBaseUrl() + '/WS/Cool%20Wines/Page/Integration_Ship_to_Address');
            httpRequestShipping.setMethod('POST');
            httpRequestShipping.setTimeout(40000);
            httpRequestShipping.setHeader('Content-Type','text/xml;charset=UTF-8');
            httpRequestShipping.setHeader('Accept-Encoding','gzip,deflate');
            httpRequestShipping.setHeader('SOAPAction','"urn:microsoft-dynamics-schemas/page/integration_ship_to_address:Create"');
            
            System.debug('Request: '+httpRequestShipping);
            
            if(acc.ShippingAddress != null){
                httpResponseShipping = http.send(httpRequestShipping);
                System.debug('Response Status Code**:' + httpResponseShipping.getStatusCode());
                System.debug('Response Status***:' + httpResponseShipping.getStatus());
                System.debug('Response Body****:' + httpResponseShipping.getBody());
            
                dom.Document resDocShipping = httpResponseShipping.getBodyDocument();
                System.debug('debug: '+resDocShipping.toXmlString());
                Update acc;
                if(httpResponseShipping.getStatusCode() == 200 || httpResponseShipping.getStatusCode() == 201){
                    Util_NavEnvironment.logWebCall('Create Customer Shipping Address', 'Outbound', shippingBody, httpResponseShipping.getBody(), true, acc.Id);
                }
                else{
                    Util_NavEnvironment.logWebCall('Create Customer Shipping Address', 'Outbound', shippingBody, httpResponseShipping.getBody(), false, acc.Id);
                }
            }
            }
            else{
                //Read error
                String errorMessage = '';
                        for (Dom.XmlNode fluxNode: resDoc.getRootElement().getChildElements()) {
                for (Dom.XmlNode fluxChildNode: fluxNode.getChildElements()) {
                    errorMessage = fluxChildNode.getChildElement('faultstring', null).getText();
                }
            }
                acc.Nav_Status__c = 'Failed';
                acc.Nav_Message__c = errorMessage;
                Update acc;
                Util_NavEnvironment.logWebCall('Create Customer', 'Outbound', requestBody, httpResponse.getBody(), false, acc.Id);
            }  
    }
    
    public static String getShippingAddressSoapEnvelope(Account acc){
        String XMLBody;
        DateTime xDate = (acc.Liquor_Licence_Expiry_Date__c == null) ? null : DateTime.newInstance(acc.Liquor_Licence_Expiry_Date__c, time.newInstance(0, 0, 0, 0));
        String liquorexpdate = (acc.Liquor_Licence_Expiry_Date__c == null) ? null : String.valueOf(xDate).substring(0,10);
        
        XMLBody = ('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:int="urn:microsoft-dynamics-schemas/page/integration_ship_to_address">'
                  +'<soapenv:Header/>'
                  +'<soapenv:Body>'
                  +'<int:Create>'
                  +'<int:Integration_Ship_to_Address>'
                +'<!--Optional:-->'
                +'<int:Code>'+acc.No__c+'</int:Code>'
                +'<!--Optional:-->'
                +'<int:Name>'+acc.Name+'</int:Name>'
                +'<!--Optional:-->'
                +'<int:Address>'+acc.ShippingStreet+'</int:Address>'
                +'<!--Optional:-->'
                +'<int:Address_2>'+acc.ShippingCity+'</int:Address_2>'
                +'<!--Optional:-->'
                +'<int:Address_3>'+acc.ShippingState+'</int:Address_3>'
                +'<!--Optional:-->'
                +'<int:County>'+acc.ShippingCountry+'</int:County>'
                +'<!--Optional:-->'
                +'<int:Post_Code>'+acc.ShippingPostalCode+'</int:Post_Code>'
                +'<!--Optional:-->'
                +'<int:City>'+acc.ShippingCity+'</int:City>'
                +'<!--Optional:-->'
                +'<int:Phone_No>'+acc.Phone+'</int:Phone_No>'
                +'<!--Optional:-->'
                +'<int:E_Mail>'+acc.Email__c+'</int:E_Mail>'
                +'<!--Optional:-->'
                +'<int:Customer_No>'+acc.No__c+'</int:Customer_No>'
                +'<int:Contact>'+acc.Contact_Name__c+'</int:Contact>'
                +'<int:Liquor_License_Expiry_Date>'+liquorexpdate+'</int:Liquor_License_Expiry_Date>'
                +'<int:Liquor_License_No>'+acc.Liquor_Licence_No__c+'</int:Liquor_License_No>'
                +'<int:Delivery_Time>'+acc.Delivery_Time__c+'</int:Delivery_Time>'
                +'<int:Route>'+acc.Route__c+'</int:Route>'
                +'<int:Shipment_Method_Code>'+acc.Shipment_Method_Code__c+'</int:Shipment_Method_Code>'
                +'<int:Location_Code>'+acc.Location_Code__c+'</int:Location_Code>'
                +'<int:GPS_Latitude>'+acc.ShippingLatitude+'</int:GPS_Latitude>'
                +'<int:GPS_Longitude>'+acc.ShippingLongitude+'</int:GPS_Longitude>'


                  +'</int:Integration_Ship_to_Address>'
                  +'</int:Create>'
                  +'</soapenv:Body>'
                  +'</soapenv:Envelope>'
                 );
        
        system.debug('XML Body'+XMLBody);
        return XMLBody.replace('null', '');        
    }
    
    public static String getSoapEnvelope(Account acc){
        String XMLBody;
        DateTime xDate = (acc.Liquor_Licence_Expiry_Date__c == null) ? null : DateTime.newInstance(acc.Liquor_Licence_Expiry_Date__c, time.newInstance(0, 0, 0, 0));
        String liquorexpdate = (acc.Liquor_Licence_Expiry_Date__c == null) ? null : String.valueOf(xDate).substring(0,10);
        
        XMLBody =('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:int="urn:microsoft-dynamics-schemas/page/integration_customer_card">'
                  +'<soapenv:Header/>'
                  +'<soapenv:Body>'
                  +'<int:Create>'
                  +'<int:Integration_Customer_Card>'
                  +'<!--Optional:-->'
                  +'<int:Key></int:Key>'
                  +'<!--Optional:-->'
                  +'<int:No>'+acc.No__c+'</int:No>'
                  +'<!--Optional:-->'
                  +'<int:Name>'+acc.Name+'</int:Name>'
                  +'<!--Optional:-->'
                  
                  +'<int:Credit_Limit_LCY>'+acc.Credit_Limit_LCY__c+'</int:Credit_Limit_LCY>'
                  +'<!--Optional:-->'
                  +'<!--Optional:-->'
                  +'<int:Blocked>All</int:Blocked>'
                  +'<!--Optional:-->'
                  
                  +'<int:Liquor_License_No>'+acc.Liquor_Licence_No__c+'</int:Liquor_License_No>'
                  +'<!--Optional:-->'
                  +'<int:Liquor_License_Expiry_Date>'+liquorexpdate+'</int:Liquor_License_Expiry_Date>'
                  +'<!--Optional:-->'
                  
                  +'<!--Optional:-->'
                  +'<int:Salesperson_Code>'+acc.Salesperson_Code__c+'</int:Salesperson_Code>'
                  +'<!--Optional:-->'
                  +'<int:Salesperson_Name></int:Salesperson_Name>'
                  +'<!--Optional:-->'
                  +'<int:Responsibility_Center>'+acc.Responsibility_Center__c+'</int:Responsibility_Center>'
                  
                  +'<int:Company_Reg_ID_No>'+acc.Company_Reg_ID_No__c+'</int:Company_Reg_ID_No>'
                  
                  +'<int:Address>'+acc.BillingStreet+'</int:Address>'
                  +'<!--Optional:-->'
                  +'<int:Address_2>'+acc.BillingStreet+'</int:Address_2>'
                  +'<!--Optional:-->'
                  +'<int:Address_3></int:Address_3>'
                  +'<!--Optional:-->'
                  +'<int:Country_Region_Code></int:Country_Region_Code>'
                  +'<!--Optional:-->'
                  +'<int:County>'+acc.BillingCountry+'</int:County>'
                  +'<!--Optional:-->'
                  +'<int:City>'+acc.BillingCity+'</int:City>'
                  +'<!--Optional:-->'
                  +'<int:Post_Code>'+acc.BillingPostalCode+'</int:Post_Code>'
                  +'<!--Optional:-->'
                  
                  +'<!--Optional:-->'
                  +'<int:Cluster>'+acc.Cluster__c+'</int:Cluster>'
                  +'<!--Optional:-->'
                  +'<int:Segment>'+acc.Segment__c+'</int:Segment>'
                  +'<!--Optional:-->'
                  +'<int:Consumption>'+acc.Consumption__c+'</int:Consumption>'
                  +'<!--Optional:-->'
                  
                  +'<int:Group_Account>'+acc.National_Group__c+'</int:Group_Account>'
                  
                  +'<int:ContactName>'+acc.Contact_Name__c+'</int:ContactName>'
                  +'<!--Optional:-->'
                  +'<int:Phone_No>'+acc.Phone+'</int:Phone_No>'
                  +'<!--Optional:-->'
                  +'<int:MobilePhoneNo_GEN_LINC>'+acc.Phone_No__c+'</int:MobilePhoneNo_GEN_LINC>'
                  +'<!--Optional:-->'
                  +'<int:E_Mail>'+acc.Email__c+'</int:E_Mail>'
                  +'<!--Optional:-->'
                  +'<int:Fax_No>'+acc.Fax+'</int:Fax_No>'
                  +'<!--Optional:-->'
                  +'<int:Home_Page></int:Home_Page>'
                  +'<!--Optional:-->'
                  +'<int:Language_Code></int:Language_Code>'
                  +'<!--Optional:-->'
                  +'<int:Bill_to_Customer_No>'+acc.Bill_To_Customer_Number__c+'</int:Bill_to_Customer_No>'
                  +'<!--Optional:-->'
                  +'<int:VAT_Registration_No>'+acc.VAT_Registration_No__c+'</int:VAT_Registration_No>'
                  +'<!--Optional:-->'
                  +'<int:RegistrationNo_GEN_LINC></int:RegistrationNo_GEN_LINC>'
                  
                  +'<int:Account_ID>100001</int:Account_ID>'
                  
                  +'<int:Invoice_Copies>1</int:Invoice_Copies>'
                  +'<!--Optional:-->'
                  +'<int:Gen_Bus_Posting_Group>'+acc.Gen_Bus_PostingGroup__c+'</int:Gen_Bus_Posting_Group>'
                  +'<!--Optional:-->'
                  +'<int:VAT_Bus_Posting_Group>'+acc.VAT_Bus_Posting_Group__c+'</int:VAT_Bus_Posting_Group>'
                  +'<!--Optional:-->'
                  +'<int:Customer_Price_Group>'+acc.Customer_Price_Group__c+'</int:Customer_Price_Group>'
                  +'<!--Optional:-->'
                  +'<int:Customer_Posting_Group>'+acc.Customer_Posting_Group__c+'</int:Customer_Posting_Group>'
                  +'<!--Optional:-->'
                  
                  +'<!--Optional:-->'
                  +'<int:Customer_Disc_Group>'+acc.Customer_Disc_Group__c+'</int:Customer_Disc_Group>'
                  
                  +'<int:Credit_Controller>'+acc.Credit_Controller__c+'</int:Credit_Controller>'
                  
                  +'<int:Payment_Terms_Code>'+acc.Payment_Terms_Code__c+'</int:Payment_Terms_Code>'
                  +'<!--Optional:-->'
                  +'<int:Payment_Method_Code></int:Payment_Method_Code>'
                  
                  +'<int:Invoice_Disc_Code></int:Invoice_Disc_Code>'
                  
                  +'<int:Ship_to_Code>'+acc.No__c+'</int:Ship_to_Code>'
                  
                  +'<int:Location_Code>'+acc.Location_Code__c+'</int:Location_Code>'
                  
                  +'<int:Shipment_Method_Code>'+acc.Shipment_Method_Code__c+'</int:Shipment_Method_Code>'
                  
                  +'<int:Delivery_Time>'+acc.Delivery_Time__c+'</int:Delivery_Time>'
                  +'<!--Optional:-->'
                  +'<int:Use_Sales_Cut_Off_Time>'+acc.Use_Sales_Cut_Off_Time__c+'</int:Use_Sales_Cut_Off_Time>'
                  +'<!--Optional:-->'
                  +'<int:Base_Calendar_Code>'+acc.Base_Calender__c+'</int:Base_Calendar_Code>'
                  
                  +'<int:Lead_Time>'+acc.Lead_Time__c+'</int:Lead_Time>'
                  +'<!--Optional:-->'
                  +'<int:Route></int:Route>'
                  +'<!--Optional:-->'
                  +'<int:Direct_to_Consumer>'+acc.Direct_to_Consumer__c+'</int:Direct_to_Consumer>'
                  
                  +'<int:Default_Ship_to_Address>'+acc.No__c+'</int:Default_Ship_to_Address>'
                  
                  +'<!--Optional:-->'
                  +'<int:Exclude_from_Handling_Fee>'+acc.Exclude_from_Handling_Fee__c+'</int:Exclude_from_Handling_Fee>'
                  +'<!--Optional:-->'
                  +'<int:Exclude_from_Minimum_Order_Fee>'+acc.Exclude_from_Minimum_Order_Fee__c+'</int:Exclude_from_Minimum_Order_Fee>'
                  +'<!--Optional:-->'
                  +'<int:Use_Ship_to_Dimension>'+acc.Use_Ship_to_Dimension__c+'</int:Use_Ship_to_Dimension>'
                  +'<!--Optional:-->'
                  
                  +'<!--Optional:-->'
                  +'<int:Area_Description>'+acc.Area_Description__c+'</int:Area_Description>'
                  +'<!--Optional:-->'
                  +'<int:MWM_Grading>'+acc.MWM_Grading__c+'</int:MWM_Grading>'
                  +'<!--Optional:-->'
                  +'<int:CLM_Rep_Area>'+acc.CLM_Rep_Area__c+'</int:CLM_Rep_Area>'
                  +'<!--Optional:-->'
                  +'<int:CLM_Grading>'+acc.CLM_Grading__c+'</int:CLM_Grading>'
                  
                  +'<int:MWM_Rep_Influence>'+acc.MWM_Rep_Influence__c+'</int:MWM_Rep_Influence>'
                  +'<!--Optional:-->'
                  
                  +'</int:Integration_Customer_Card>'
                  +'</int:Create>'
                  +'</soapenv:Body>'
                  +'</soapenv:Envelope>'
                 );
        
        system.debug('XML Body'+XMLBody);
        return XMLBody.replace('null', '');
    }
}