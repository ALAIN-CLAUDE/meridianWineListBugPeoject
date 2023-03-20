public class CustomerCardParse {
    public static List<Account> userInfo(dom.Document doc){
        
        List<Account> Customer = new List<Account>();
        
        Dom.XmlNode rootElement = doc.getRootElement();
        
        If(!String.isBlank(rootElement.getName())){
            for(Dom.XmlNode childElement : rootElement.getChildElements()){
                //System.debug('Name: '+childElement.getName());
                if(childElement.getName()=='Body'){
                    for(Dom.XmlNode childElement1 : childElement.getChildElements()){
                        //System.debug('Name childElement1 : '+childElement1.getName());
                        if(childElement1.getName()=='ReadMultiple_Result'){
                            for(Dom.XmlNode childElement2 : childElement1.getChildElements()){
                               // System.debug('Name childElement2 : '+childElement2.getName()); 
                                if(childElement2.getName()=='ReadMultiple_Result'){
                                    for(Dom.XmlNode childElement3 : childElement2.getChildElements()){
                                        //System.debug('Name childElement3 : '+childElement3.getName());
                                        if(childElement3.getName()=='Integration_Customer_Card'){
                                            Account Acc = new Account();
                                            
                                            for(Dom.XmlNode childElement4 : childElement3.getChildElements()){
                                                
                                                //System.debug('Name childElement4 : '+childElement4.getName());
                                                //System.debug('XMLNode : '+childElement4.getChildren());
                                                //System.debug('children4 : '+childElement4.getText());
                                                if(childElement4.getName()=='No'){
                                                    Acc.No__c = childElement4.getText();
                                                }
                                                
                                                if(childElement4.getName()=='Name'){
                                                   // System.debug('Name: '+childElement4.getText());
                                                    Acc.Name = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Search_Name'){
                                                    Acc.Search_Name__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Balance_LCY'){
                                                    Acc.Balance_LCY__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Balance_Due_LCY'){
                                                    Acc.Balance_Due_LCY__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Credit_Limit_LCY'){
                                                    Acc.Credit_Limit_LCY__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Credit_Limit_FCY'){
                                                    Acc.Credit_Limit_FCY__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Credit_Insurance_Limit_FCY'){
                                                    Acc.Credit_Insurance_Limit_FCY__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Blocked'){
                                                    Acc.Blocked__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='GPS_Latitude'){
                                                    Acc.GPS_Latitude__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='GPS_Longitude'){
                                                    Acc.GPS_Longitude__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Liquor_License_No'){
                                                    Acc.Liquor_Licence_No__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Liquor_License_Expiry_Date'){
                                                    if(childElement4.getText()!='0001-01-01'){
                                                       Acc.Liquor_Licence_Expiry_Date__c = Date.valueOf(childElement4.getText()); 
                                                    }
                                                    //Acc.Liquor_Licence_Expiry_Date__c = Date.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Privacy_Blocked'){
                                                    if(childElement4.getText()=='false'){
                                                        Acc.Privacy_Blocked__c =false;
                                                    }
                                                    else if(childElement4.getText()=='true'){
                                                        Acc.Privacy_Blocked__c =true;
                                                    }
                                                } 
                                                if(childElement4.getName()=='Salesperson_Code'){
                                                     
                                                    Acc.Salesperson_Code__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Salesperson_Name'){
                                                    Acc.Salesperson_Name__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='Responsibility_Center'){
                                                    Acc.Responsibility_Center__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='TotalSales2'){
                                                    Acc.Total_Sales_2__c = Double.valueOf(childElement4.getText());
                                                } 
                                                if(childElement4.getName()=='TotalSales2'){
                                                    Acc.Total_Sales_2__c = Double.valueOf(childElement4.getText());
                                                }     
                                                if(childElement4.getName()=='CustSalesLCY_CustProfit_AdjmtCostLCY'){
                                                    Acc.Cust_Sales_LCY_Cust_Profit_Adjmt_Cost_LC__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='AdjCustProfit'){
                                                    Acc.Adj_Cust_Profit__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='AdjProfitPct'){
                                                    Acc.Adj_Profit_Pct__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='AdjProfitPct'){
                                                    Acc.Adj_Profit_Pct__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Last_Date_Modified'){
                                                    Acc.Last_Date_Modified__c = Date.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Legal_Entity'){
                                                    Acc.Legal_Entity__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Disable_Search_by_Name'){
                                                    if(childElement4.getText()=='false'){
                                                       Acc.Disable_Search_by_Name__c=false; 
                                                    }
                                                    if(childElement4.getText()=='true'){
                                                       Acc.Disable_Search_by_Name__c=true; 
                                                    }
                                                }
                                                if(childElement4.getName()=='Address_2'){
                                                    //Acc.Address_2__c = childElement4.getText();
                                                }                                            
                                                if(childElement4.getName()=='Address_3'){
                                                    //Acc.Address_3__c = childElement4.getText(); ShowMap
                                                }
                                                if(childElement4.getName()=='ShowMap'){
                                                    //Acc.ShowMap__c = childElement4.getText(); 
                                                }
                                                if(childElement4.getName()=='ContactName'){
                                                    Acc.Contact_Name__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='Bill_to_Customer_No'){
                                                    //Acc.Bill_to_Customer_No__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Copy_Sell_to_Addr_to_Qte_From'){
                                                    Acc.Copy_Sell_to_Addr_to_Qte_From__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Invoice_Copies'){
                                                    Acc.Invoice_Copies__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Gen_Bus_Posting_Group'){
                                                    Acc.Gen_Bus_PostingGroup__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='VAT_Bus_Posting_Group'){
                                                    Acc.VAT_Bus_Posting_Group__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Customer_Price_Group'){
                                                     
                                                    Acc.Customer_Price_Group__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Customer_Posting_Group'){
                                                     
                                                    Acc.Customer_Posting_Group__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Customer_Disc_Group'){
                                                     
                                                    Acc.Customer_Disc_Group__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Allow_Line_Disc'){
                                                    if(childElement4.getText()=='false'){
                                                       Acc.Allow_Line_Disc__c =false; 
                                                    }
                                                    
                                                    if(childElement4.getText()=='true'){
                                                       Acc.Allow_Line_Disc__c =true; 
                                                    }
                                                }
                                                if(childElement4.getName()=='Prices_Including_VAT'){
                                                    if(childElement4.getText()=='false'){
                                                       Acc.Prices_Including_VAT__c = false; 
                                                    }
                                                    if(childElement4.getText()=='true'){
                                                       Acc.Prices_Including_VAT__c = true; 
                                                    }
                                                }
                                                if(childElement4.getName()=='Prepayment_Percent'){
                                                     
                                                    Acc.Prepayment_Percent__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Credit_Controller'){
                                                     
                                                    Acc.Credit_Controller__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Partner_Type'){
                                                     
                                                    Acc.Partner_Type__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Payment_Terms_Code'){
                                                     
                                                    Acc.Payment_Terms_Code__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Print_Statements'){
                                                    if(childElement4.getText()=='false'){
                                                        Acc.Print_Statements__c = false;
                                                    }
                                                    
                                                    if(childElement4.getText()=='true'){
                                                        Acc.Print_Statements__c = true;
                                                    }
                                                }
                                                if(childElement4.getName()=='Last_Statement_No'){
                                                     
                                                    Acc.Last_Statement_No__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Block_Payment_Tolerance'){
                                                    if(childElement4.getText()=='true'){
                                                        Acc.Block_Payment_Tolerance__c = true;
                                                    }
                                                    
                                                    if(childElement4.getText()=='false'){
                                                        Acc.Block_Payment_Tolerance__c = false;
                                                    }
                                                }
                                                if(childElement4.getName()=='Application_Method'){
                                                     
                                                    Acc.Application_Method__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Invoice_Disc_Code'){
                                                     
                                                    //Acc.Invoice_Disc_Code__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Location_Code'){
                                                     
                                                    Acc.Location_Code__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Combine_Shipments'){
                                                    if(childElement4.getText()=='true'){
                                                        Acc.Combine_Shipments__c = true;
                                                    }
                                                    
                                                    if(childElement4.getText()=='false'){
                                                        Acc.Combine_Shipments__c = false;
                                                    }
                                                }
                                                if(childElement4.getName()=='Reserve'){
                                                     
                                                    Acc.Reserve__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Shipping_Advice'){
                                                     
                                                    Acc.Shipping_Advice__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Shipment_Method_Code'){
                                                     
                                                    Acc.Shipment_Method_Code__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Delivery_Time'){
                                                     
                                                    Acc.Delivery_Time__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Use_Sales_Cut_Off_Time'){
                                                    if(childElement4.getText()=='false'){
                                                       Acc.Use_Sales_Cut_Off_Time__c = false; 
                                                    }
                                                    
                                                    if(childElement4.getText()=='true'){
                                                       Acc.Use_Sales_Cut_Off_Time__c = true; 
                                                    }
                                                }
                                                if(childElement4.getName()=='Base_Calendar_Code'){
                                                     
                                                    Acc.Base_Calender__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Customized_Calendar'){
                                                     
                                                    Acc.Customized_Calendar__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Lead_Time'){
                                                     
                                                    Acc.Lead_Time__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Route'){
                                                     
                                                    Acc.Route__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='Direct_to_Consumer'){
                                                    if(childElement4.getText()=='false'){
                                                      Acc.Direct_to_Consumer__c = false;  
                                                    }
                                                    
                                                    if(childElement4.getText()=='true'){
                                                      Acc.Direct_to_Consumer__c = true;  
                                                    }
                                                }
                                                if(childElement4.getName()=='Exclude_from_Handling_Fee'){
                                                     
                                                    Acc.Exclude_from_Handling_Fee__c = (childElement4.getText() == 'false') ? false : true;
                                                }
                                                if(childElement4.getName()=='Exclude_from_Minimum_Order_Fee'){
                                                     
                                                    Acc.Exclude_from_Minimum_Order_Fee__c = (childElement4.getText() == 'false') ? false : true;
                                                }
                                                if(childElement4.getName()=='Use_Ship_to_Dimension'){
                                                    if(childElement4.getText()=='false'){
                                                       Acc.Use_Ship_to_Dimension__c = false; 
                                                    }
                                                    
                                                    if(childElement4.getText()=='true'){
                                                       Acc.Use_Ship_to_Dimension__c = true; 
                                                    }
                                                }
                                                if(childElement4.getName()=='Store_Code'){
                                                    
                                                    Acc.Store_Code__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='Area_Description'){
                                                    
                                                    Acc.Area_Description__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='MWM_Grading'){
                                                    
                                                    Acc.MWM_Grading__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='CLM_Rep_Area'){
                                                    
                                                    Acc.CLM_Rep_Area__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='CLM_Grading'){
                                                    
                                                    Acc.CLM_Grading__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='Segment'){
                                                    
                                                    Acc.Segment__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='Cluster'){
                                                    
                                                    Acc.Cluster__c = childElement4.getText();
                                                } 
                                                if(childElement4.getName()=='Consumption'){
                                                    if(childElement4.getText()=='OFF'){
                                                       Acc.Consumption__c = childElement4.getText();
                                                        Acc.RecordTypeId = '0122X0000003LOQQA2';
                                                        
                                                    }else if(childElement4.getText()=='ON'){
                                                       Acc.Consumption__c = childElement4.getText();
                                                        Acc.RecordTypeId = '0122X0000003LOLQA2';
                                                    }
                                                    else{
                                                        Acc.Consumption__c = childElement4.getText();
                                                        Acc.RecordTypeId = '0122X0000003LOVQA2';
                                                    }
                                                    
                                                } 
                                                if(childElement4.getName()=='CAM_Rep_Area'){
                                                    
                                                    Acc.CAM_Rep_Area__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='CAM_Grading'){
                                                    
                                                    //Acc.CAM_Grading__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='MWM_Rep_Influence'){
                                                    
                                                    Acc.MWM_Rep_Influence__c = childElement4.getText();
                                                }
                                                if(childElement4.getName()=='ExpectedCustMoneyOwed'){
                                                    
                                                    Acc.ExpectedCustMoneyOwed__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='TotalMoneyOwed'){
                                                    
                                                    Acc.Total_Money_Owed__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='CalcCreditLimitLCYExpendedPct'){
                                                    
                                                    Acc.Calc_Credit_Limit_LCY_Expended_Pct__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Balance_Due'){
                                                    
                                                    Acc.Balance_Due__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Payments_LCY'){
                                                    
                                                    Acc.Payments_LCY__c = Decimal.valueOf(childElement4.getText());
                                                } 
                                                if(childElement4.getName()=='CustomerMgt_AvgDaysToPay_No'){
                                                    
                                                    Acc.Customer_Mgt_Avg_Days_To_Pay_No__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='DaysPaidPastDueDate'){
                                                    
                                                    Acc.Days_Paid_Past_Due_Date__c = Double.valueOf(childElement4.getText());
                                                }                                                
                                                if(childElement4.getName()=='GetAmountOnPostedInvoices'){
                                                    
                                                    Acc.Get_Amount_On_Posted_Invoices__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='GetAmountOnCrMemo'){
                                                    
                                                    Acc.Get_Amount_On_Cr_Memo__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='GetAmountOnOutstandingInvoices'){
                                                    
                                                    Acc.Get_Amount_On_Outstanding_Invoices__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='GetAmountOnOutstandingCrMemos'){
                                                    
                                                    Acc.Get_Amount_On_Outstanding_Cr_Memos__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='Totals'){
                                                    
                                                    Acc.Totals__c = Double.valueOf(childElement4.getText());
                                                }
                                                if(childElement4.getName()=='CustInvDiscAmountLCY'){
                                                    
                                                    Acc.Cust_Inv_Disc_Amount_LCY__c = Decimal.valueOf(childElement4.getText());
                                                }
                                                
                                                
                                            }
                                            Acc.Account_Status__c = 'Approved';
                                            Acc.Nav_Status__c = 'Posted';
                                            Acc.Nav_Message__c = 'Customer created successfully';
                                            Customer.add(Acc);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return Customer;
    }
}