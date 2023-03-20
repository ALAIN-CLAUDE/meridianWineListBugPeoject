/**=================================================================================================================================
 * Created By: Denson Zunga & Tawanda Madavo
 * Created Date: 14/01/2021
 * Description: Class to handle sales order parsing
 ===================================================================================================================================**/
public class SalesOrdersParse {
  //Class for all data to be returned from this class
  public class CustomResponseData{
    public List<Order> orders;
    public List<CustomLineItem> lineItems;
    public List<Product2> products;

    public CustomResponseData(List<Order> orders, List<CustomLineItem> lineItems, List<Product2> products){
      this.orders = orders;
      this.lineItems = lineItems;
      this.products = products;
    }
  }
  //Custom Order Data to be created after upserts
  public class CustomLineItem{
    public String No;
    public String Order_No;
    public Integer Quantity;
    public Decimal ListPrice;
    public String SalesUnitOfMeasure;

    public CustomLineItem(){
    }

    public CustomLineItem(String No, String Order_No, Integer Quantity, Decimal ListPrice, String SalesUnitOfMeasure){
      this.No = No;
      this.Order_No = Order_No;
      this.Quantity = Quantity;
      this.ListPrice = ListPrice;
      this.SalesUnitOfMeasure = SalesUnitOfMeasure;
    }
  }
  public static CustomResponseData customerPriceListInfo(dom.Document doc) {
    String defaultAccountId;
    List<Order> orderInfo = new List<Order>();
    List<String> productUniqueCodes = new List<String>();
    List<CustomLineItem> lineItems = new List<CustomLineItem>();
    Map<String, Account> accountMap = new Map<String, Account>();

    for (Account obj : [SELECT Id, No__c FROM Account WHERE No__c != NULL]) {
      accountMap.put(obj.No__c, obj);
    }

    List<Account> placeholderAccount = [
      SELECT Id, Name
      FROM Account
      WHERE Name = 'Placeholder Transaction Account'
    ];

    //Create a placeholder account if it does not exist
    //Account is used if we cannot find corresponding account in SF
    if (placeholderAccount.isEmpty()) {
      Account a = new Account();
      a.Name = 'Placeholder Transaction Account';
      a.Billing_Street__c = 'Placeholder Billing Street';
      insert a;
      defaultAccountId = a.Id;
    } else {
      for (Account a : placeholderAccount) {
        defaultAccountId = a.Id;
      }
    }

    Dom.XmlNode rootElement = doc.getRootElement();
    for (Dom.XmlNode childElement : rootElement.getChildElements()) {
      if (!String.isBlank(rootElement.getName())) {
        //System.debug('Name: '+childElement.getName());
        if (childElement.getName() == 'Body') {
          for (Dom.XmlNode childElement1 : childElement.getChildElements()) {
            //System.debug('Name childElement1 : '+childElement1.getName());
            if (childElement1.getName() == 'ReadMultiple_Result') {
              for (
                Dom.XmlNode childElement2 : childElement1.getChildElements()
              ) {
                //System.debug('Name childElement2 : '+childElement2.getName());
                if (childElement2.getName() == 'ReadMultiple_Result') {
                  for (
                    Dom.XmlNode childElement3 : childElement2.getChildElements()
                  ) {
                    //System.debug('Name childElement3 : '+childElement3.getName());
                    if (childElement3.getName() == 'Integration_Sales_Order') {
                      Order itemInfo = new Order();
                      itemInfo.AccountId = defaultAccountId;

                      for (
                        Dom.XmlNode childElement4 : childElement3.getChildElements()
                      ) {
                        if (childElement4.getName() == 'No') {
                          itemInfo.No__c = childElement4.getText();
                          itemInfo.Sales_Order_No__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Sell_to_Customer_No') {
                          Account ItemNo = accountMap.get(childElement4.getText());

                          if (ItemNo != null) {
                            itemInfo.AccountId = ItemNo.Id;
                          } else {
                            itemInfo.AccountId = defaultAccountId;
                          }
                        }

                        if (childElement4.getName() == 'Sell_to_Contact_No') {
                          itemInfo.Sell_to_Contact_No__c = Decimal.valueOf(
                            childElement4.getText()
                          );
                        }

                        if (
                          childElement4.getName() == 'Sell_to_Customer_Name'
                        ) {
                          itemInfo.Sell_to_Customer_Name__c = childElement4.getText();
                        }

                        if (
                          childElement4.getName() == 'No_of_Archived_Versions'
                        ) {
                          itemInfo.No_of_Archived_Versions__c = Decimal.valueOf(
                            childElement4.getText()
                          );
                        }

                        if (childElement4.getName() == 'Posting_Date') {
                          if (childElement4.getText() != '0001-01-01') {
                            itemInfo.Posting_Date__c = childElement4.getText(); //Date.valueOf(childElement4.getText());
                          }
                        }

                        if (childElement4.getName() == 'Order_Date') {
                          if (childElement4.getText() != '0001-01-01') {
                            itemInfo.EffectiveDate = Date.valueOf(
                              childElement4.getText()
                            );
                          }
                        }

                        if (childElement4.getName() == 'Document_Date') {
                          if (childElement4.getText() != '0001-01-01') {
                            itemInfo.Document_Date__c = childElement4.getText(); //Date.valueOf(childElement4.getText());
                          }
                        }

                        if (
                          childElement4.getName() == 'Requested_Delivery_Date'
                        ) {
                          if (
                            childElement4.getText() != '0001-01-01' &&
                            Date.valueOf(childElement4.getText()) != null
                          ) {
                            itemInfo.Requested_Delivery_Date__c = Date.valueOf(
                              childElement4.getText()
                            );
                          } else {
                            itemInfo.Requested_Delivery_Date__c = Date.today();
                          }
                        }

                        if (
                          childElement4.getName() == 'Promised_Delivery_Date'
                        ) {
                          if (childElement4.getText() != '0001-01-01') {
                            itemInfo.Promised_Delivery_Date__c = childElement4.getText(); //Date.valueOf(childElement4.getText());
                          }
                        }

                        if (childElement4.getName() == 'External_Document_No') {
                          itemInfo.External_Document_No__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Salesperson_Code') {
                          itemInfo.Salesperson_Code__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Job_Queue_Status') {
                          itemInfo.Job_Queue_Status__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Created_By') {
                          itemInfo.Created_By__c = childElement4.getText();
                        }
                        if (childElement4.getName() == 'Status') {
                          itemInfo.Status__c = childElement4.getText();
                        }
                        if (childElement4.getName() == 'Bill_to_Customer_No') {
                          itemInfo.Bill_to_Customer_No__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Bill_to_Name') {
                          itemInfo.Bill_to_Name__c = childElement4.getText();
                        }
                        if (childElement4.getName() == 'Due_Date') {
                          if (childElement4.getText() != '0001-01-01') {
                            itemInfo.Due_Date__c = childElement4.getText(); //Date.valueOf(childElement4.getText());
                          }
                        }

                        if (
                          childElement4.getName() == 'Payment_Discount_Percent'
                        ) {
                          itemInfo.Payment_Discount_Percent__c = Decimal.valueOf(
                            childElement4.getText()
                          );
                        }

                        if (childElement4.getName() == 'Prices_Including_VAT') {
                          if (childElement4.getText() == 'true') {
                            itemInfo.Prices_Including_VAT__c = true;
                          }
                          if (childElement4.getText() == 'false') {
                            itemInfo.Prices_Including_VAT__c = false;
                          }
                        }
                        if (
                          childElement4.getName() == 'VAT_Bus_Posting_Group'
                        ) {
                          itemInfo.VAT_Bus_Posting_Group__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Amount') {
                          itemInfo.Amount__c = Decimal.valueOf(
                            childElement4.getText()
                          );
                        }

                        if (childElement4.getName() == 'Amount_Including_VAT') {
                          itemInfo.Amount_Including_VAT__c = Decimal.valueOf(
                            childElement4.getText()
                          );
                        }

                        if (childElement4.getName() == 'Ship_to_Code') {
                          itemInfo.Ship_to_Code__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Ship_to_Name') {
                          itemInfo.Ship_to_Name__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Route') {
                          itemInfo.Route__c = childElement4.getText();
                        }
                        if (childElement4.getName() == 'Shipment_Method_Code') {
                          itemInfo.Shipment_Method_Code__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'Late_Order_Shipping') {
                          if (childElement4.getText() == 'true') {
                            itemInfo.Late_Order_Shipping__c = true;
                          }

                          if (childElement4.getText() == 'false') {
                            itemInfo.Late_Order_Shipping__c = false;
                          }
                        }
                        if (childElement4.getName() == 'Shipment_Date') {
                          if (childElement4.getText() != '0001-01-01') {
                            itemInfo.Shipment_Date__c = childElement4.getText(); //Date.valueOf(childElement4.getText());
                          }
                        }

                        if (childElement4.getName() == 'Shipping_Advice') {
                          itemInfo.Shipping_Advice__c = childElement4.getText();
                        }

                        if (childElement4.getName() == 'EU_3_Party_Trade') {
                          if (childElement4.getText() == 'false') {
                            itemInfo.EU_3_Party_Trade__c = false;
                          }

                          if (childElement4.getText() == 'true') {
                            itemInfo.EU_3_Party_Trade__c = true;
                          }
                        }

                        if (childElement4.getName() == 'Prepayment_Percent') {
                          itemInfo.Prepayment_Percent__c = Decimal.valueOf(
                            childElement4.getText()
                          );
                        }
                        if (childElement4.getName() == 'Compress_Prepayment') {
                          if (childElement4.getText() == 'true') {
                            itemInfo.Compress_Prepayment__c = true;
                          }

                          if (childElement4.getText() == 'false') {
                            itemInfo.Compress_Prepayment__c = false;
                          }
                        }
                        if (childElement4.getName() == 'Prepayment_Due_Date') {
                          if (childElement4.getText() != '0001-01-01') {
                            itemInfo.Prepayment_Due_Date__c = childElement4.getText(); //Date.valueOf(childElement4.getText());
                          }
                        }
                        if (
                          childElement4.getName() ==
                          'Prepmt_Payment_Discount_Percent'
                        ) {
                          itemInfo.Prepmt_Payment_Discount_Percent__c = Decimal.valueOf(
                            childElement4.getText()
                          );
                        }

                        itemInfo.Status = 'Draft';
                        itemInfo.Nav_Status__c = 'Posted';
                        itemInfo.Nav_Message__c = 'Imported From NAV Via Integration';
                        itemInfo.Imported_From_Nav__c = true;

                        //Get Line Items on order
                        if (childElement4.getName() == 'SalesLines') {
                          for (
                            Dom.XmlNode childElement5 : childElement4.getChildElements()
                          ) {
                            if (
                              childElement5.getName() ==
                              'Sales_Order_Subform_Integratio'
                            ) {
                              CustomLineItem lineItem = new CustomLineItem();
                              for (
                                Dom.XmlNode childElement6 : childElement5.getChildElements()
                              ) {
                                if (childElement6.getName() == 'No') {
                                  productUniqueCodes.add(childElement6.getText());
                                  lineItem.No = childElement6.getText();
                                }
                                if(childElement6.getName() == 'Unit_of_Measure_Code'){
                                  lineItem.SalesUnitOfMeasure = childElement6.getText();
                                }
                                if(childElement6.getName() == 'Quantity'){
                                  lineItem.Quantity = Integer.valueOf(childElement6.getText());
                                }
                                if(childElement6.getName() == 'Unit_Price'){
                                  lineItem.ListPrice = Decimal.valueOf(childElement6.getText());
                                }
                                  lineItem.Order_No = itemInfo.No__c;
                              }
                                lineItems.add(lineItem);
                            }
                          }
                        }
                      }
                      orderInfo.add(itemInfo);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    List<Product2> relevantProducts = [Select Id, No__c from Product2 Where No__c IN: productUniqueCodes];
    //return orderInfo;
    return new CustomResponseData(orderInfo, lineItems, relevantProducts);
  }
}