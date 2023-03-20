/*
 * Author: Denson K. Zunga
 * Description: 
 * Date: 17 January 2021
 */

@isTest
public class Test_CreateCustomer {
    
    public HTTPResponse respond(HTTPRequest req) {
        String XMLBody;
        Integer TestNo = 1;
        XMLBody =('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:int="urn:microsoft-dynamics-schemas/page/integration_customer_card">'
                  +'<soapenv:Header/>'
                  +'<soapenv:Body>'
                  +'<int:Create>'
                  +'<int:Integration_Customer_Card>'
                  +'<!--Optional:-->'
                  +'<int:Key></int:Key>'
                  +'<!--Optional:-->'
                  +'<int:No>'+TestNo+'</int:No>'
                  +'<!--Optional:-->'
                  +'<int:Name>Innocent</int:Name>'
                  +'<!--Optional:-->'
                  
                  +'<int:Credit_Limit_LCY>10000</int:Credit_Limit_LCY>'
                  +'<!--Optional:-->'
                  +'<!--Optional:-->'
                  +'<int:Blocked>All</int:Blocked>'
                  +'<!--Optional:-->'
                  
                  +'<int:Liquor_License_No>123456</int:Liquor_License_No>'
                  +'<!--Optional:-->'
                  +'<int:Liquor_License_Expiry_Date>2020-12-31</int:Liquor_License_Expiry_Date>'
                  +'<!--Optional:-->'
                  
                  +'<!--Optional:-->'
                  +'<int:Salesperson_Code>105</int:Salesperson_Code>'
                  +'<!--Optional:-->'
                  +'<int:Salesperson_Name></int:Salesperson_Name>'
                  +'<!--Optional:-->'
                  +'<int:Responsibility_Center>CAPE</int:Responsibility_Center>'
                  
                  +'<int:Company_Reg_ID_No>2020/12345/07</int:Company_Reg_ID_No>'
                  
                  +'<int:Address>PO Box 122</int:Address>'
                  +'<!--Optional:-->'
                  +'<int:Address_2></int:Address_2>'
                  +'<!--Optional:-->'
                  +'<int:Address_3></int:Address_3>'
                  +'<!--Optional:-->'
                  +'<int:Country_Region_Code></int:Country_Region_Code>'
                  +'<!--Optional:-->'
                  +'<int:County>ZA</int:County>'
                  +'<!--Optional:-->'
                  +'<int:City>La Motte</int:City>'
                  +'<!--Optional:-->'
                  +'<int:Post_Code>7691</int:Post_Code>'
                  +'<!--Optional:-->'
                  
                  +'<int:ContactName>Jacques Botha</int:ContactName>'
                  +'<!--Optional:-->'
                  +'<int:Phone_No>0825778943</int:Phone_No>'
                  +'<!--Optional:-->'
                  +'<int:MobilePhoneNo_GEN_LINC></int:MobilePhoneNo_GEN_LINC>'
                  +'<!--Optional:-->'
                  +'<int:E_Mail>jacques@groupmeridian.co.za</int:E_Mail>'
                  +'<!--Optional:-->'
                  +'<int:Fax_No></int:Fax_No>'
                  +'<!--Optional:-->'
                  +'<int:Home_Page></int:Home_Page>'
                  +'<!--Optional:-->'
                  +'<int:Language_Code></int:Language_Code>'
                  +'<!--Optional:-->'
                  +'<int:Bill_to_Customer_No>TEST001</int:Bill_to_Customer_No>'
                  +'<!--Optional:-->'
                  +'<int:VAT_Registration_No>478903231</int:VAT_Registration_No>'
                  +'<!--Optional:-->'
                  +'<int:RegistrationNo_GEN_LINC>1243456</int:RegistrationNo_GEN_LINC>'
                  
                  +'<int:Account_ID>100001</int:Account_ID>'
                  
                  +'<int:Invoice_Copies>1</int:Invoice_Copies>'
                  +'<!--Optional:-->'
                  +'<int:Gen_Bus_Posting_Group>LOCAL</int:Gen_Bus_Posting_Group>'
                  +'<!--Optional:-->'
                  +'<int:VAT_Bus_Posting_Group>VAT14</int:VAT_Bus_Posting_Group>'
                  +'<!--Optional:-->'
                  +'<int:Customer_Price_Group>P01</int:Customer_Price_Group>'
                  +'<!--Optional:-->'
                  +'<int:Customer_Posting_Group>C13</int:Customer_Posting_Group>'
                  +'<!--Optional:-->'
                  
                  +'<!--Optional:-->'
                  +'<int:Customer_Disc_Group>13</int:Customer_Disc_Group>'
                  
                  +'<int:Credit_Controller>6</int:Credit_Controller>'
                  
                  +'<int:Payment_Terms_Code>30DS</int:Payment_Terms_Code>'
                  +'<!--Optional:-->'
                  +'<int:Payment_Method_Code>EFT</int:Payment_Method_Code>'
                  
                  +'<int:Invoice_Disc_Code>TEST001</int:Invoice_Disc_Code>'
                  
                  +'<int:Location_Code>CTN-WHSE</int:Location_Code>'
                  
                  +'<int:Shipment_Method_Code>OWN</int:Shipment_Method_Code>'
                  
                  +'<int:Delivery_Time>0D</int:Delivery_Time>'
                  +'<!--Optional:-->'
                  +'<int:Use_Sales_Cut_Off_Time>false</int:Use_Sales_Cut_Off_Time>'
                  +'<!--Optional:-->'
                  +'<int:Base_Calendar_Code>CALENDAR</int:Base_Calendar_Code>'
                  
                  +'<int:Lead_Time>1D</int:Lead_Time>'
                  +'<!--Optional:-->'
                  +'<int:Route>CCWCONC000</int:Route>'
                  +'<!--Optional:-->'
                  +'<int:Direct_to_Consumer>false</int:Direct_to_Consumer>'
                  
                  +'<!--Optional:-->'
                  +'<int:Exclude_from_Handling_Fee>false</int:Exclude_from_Handling_Fee>'
                  +'<!--Optional:-->'
                  +'<int:Exclude_from_Minimum_Order_Fee>true</int:Exclude_from_Minimum_Order_Fee>'
                  +'<!--Optional:-->'
                  +'<int:Use_Ship_to_Dimension>false</int:Use_Ship_to_Dimension>'
                  +'<!--Optional:-->'
                  
                  +'<!--Optional:-->'
                  +'<int:Area_Description>02 CTN OTHER</int:Area_Description>'
                  +'<!--Optional:-->'
                  +'<int:MWM_Grading>NONE</int:MWM_Grading>'
                  +'<!--Optional:-->'
                  +'<int:CLM_Rep_Area>02 CTN STAFF ACC</int:CLM_Rep_Area>'
                  +'<!--Optional:-->'
                  +'<int:CLM_Grading>NONE</int:CLM_Grading>'
                  
                  +'<int:MWM_Rep_Influence>REP100</int:MWM_Rep_Influence>'
                  +'<!--Optional:-->'
                  
                  +'</int:Integration_Customer_Card>'
                  +'</int:Create>'
                  +'</soapenv:Body>'
                  +'</soapenv:Envelope>'
                 );
        
        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type', 'text/json');
        res.setBody(XMLBody);
        res.setStatusCode(200);
        return res;
        
    }
    
    @isTest
    static void testCreateCustomer(){
        Account acc = new Account(Name = 'Nedbank', Billing_Street__c = '120 Holkam Road');
        insert acc;
        Test.setMock(HttpCalloutMock.class, new Mock_CreateCustomer());
        Test.startTest();
        CreateCustomer.callRequestMethod(acc.Id);
        Test.stopTest();
    }
}