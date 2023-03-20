/**=================================================================================================================================
 * Created By: Denson Zunga & Tawanda Madavo
 * Created Date: 14/01/2021
 * Description: Class to handle sales order callout
 ===================================================================================================================================**/

public class MeridianSalesOrders implements Schedulable {
  public static HttpRequest httpRequest = new HttpRequest();
  public static HttpResponse httpResponse = new HttpResponse();

  public void execute(SchedulableContext ctx) {
    makeSalesOrdersRequest();
  }

  @future(callout=true)
  public static void makeSalesOrdersRequest() {
    try {
      Map<String, String> headers = new Map<String, String>();
      headers.put('Content-Type', 'text/xml;charset=UTF-8');
      headers.put('Accept-Encoding', 'gzip,deflate');
      headers.put(
        'SOAPAction',
        '"urn:microsoft-dynamics-schemas/page/integration_sales_order:ReadMultiple"'
      );
      httpResponse = Util_NavEnvironment.makeWebCallout(
        'POST',
        Util_NavEnvironment.getNavBaseUrl() +
        '/WS/Cool%20Wines/Page/Integration_Sales_Order',
        getSoapEnvelope(),
        headers,
        120000
      );

      System.debug(httpResponse.getBody());
      dom.Document resDoc = httpResponse.getBodyDocument();
      if (
        httpResponse.getStatusCode() == 200 ||
        httpResponse.getStatusCode() == 201 ||
        httpResponse.getStatusCode() == 204
      ) {
        List<Order> Orders = [
          SELECT
            Id,
            Prepmt_Pmt_Discount_Date__c,
            Prepmt_Payment_Discount_Percent__c,
            Prepayment_Due_Date__c,
            Compress_Prepayment__c,
            Prepayment_Percent__c,
            EU_3_Party_Trade__c,
            Shipping_Advice__c,
            Shipment_Date__c,
            Late_Order_Shipping__c,
            Shipment_Method_Code__c,
            Location_Code__c,
            Route__c,
            Ship_to_Name__c,
            Ship_to_Code__c,
            Amount_Including_VAT__c,
            Amount__c,
            VAT_Bus_Posting_Group__c,
            Prices_Including_VAT__c,
            Pmt_Discount_Date__c,
            Payment_Discount_Percent__c,
            Due_Date__c,
            Bill_to_Name__c,
            Bill_to_Contact_No__c,
            Bill_to_Customer_No__c,
            Job_Queue_Status__c,
            Responsibility_Center__c,
            Salesperson_Code__c,
            External_Document_No__c,
            Promised_Delivery_Date__c,
            Requested_Delivery_Date__c,
            Order_Date__c,
            Document_Date__c,
            Posting_Date__c,
            No_of_Archived_Versions__c,
            Sell_to_Customer_Name__c,
            Sell_to_Contact_No__c,
            Sell_to_Customer_No__c,
            No__c,
            OrderNumber,
            Status,
            Key__c
          FROM Order
          ORDER BY LastModifiedDate DESC
          LIMIT 50000
        ];

        SalesOrdersParse.CustomResponseData orderData = SalesOrdersParse.customerPriceListInfo(
          resDoc
        );
        Orders = orderData.orders;
        if (!Orders.isEmpty()) {
          Map<String, List<OrderItem>> orderItemMap = new Map<String, List<OrderItem>>();
          Map<String, Id> productIdentifierMap = new Map<String, Id>();
          List<PricebookEntry> pbEntryList = new List<PricebookEntry>();
          List<Pricebook2> nationalPricebook = [
            SELECT id
            FROM Pricebook2
            WHERE Name = 'National Price List P01'
          ];
          List<Pricebook2> stPricebook = [
            SELECT id
            FROM Pricebook2
            WHERE isStandard = TRUE
          ];
          //Map Products to their product codes
          for (Product2 prod : orderData.products) {
            productIdentifierMap.put(prod.No__c, prod.Id);
          }
          //Remove any orders with line items that have products that dont exist in SF yet
          Set<String> orderRemovalNos = new Set<String>();
          for (SalesOrdersParse.CustomLineItem lineItem : orderData.lineItems) {
            if (!productIdentifierMap.keySet().contains(lineItem.No)) {
              orderRemovalNos.add(lineItem.Order_No);
            }
          }

          List<PricebookEntry> pbEntries = [
            SELECT Id, Product2Id, UnitPrice
            FROM PricebookEntry
            WHERE
              Product2Id IN :productIdentifierMap.values()
              AND Pricebook2Id = :nationalPricebook[0].Id
          ];
          List<String> orderNavIds = new List<String>();
          //Store Ids in order for error logging
          List<String> orderIds = new List<String>();
          for (Order order : Orders) {
            orderIds.add(order.Id);
            orderNavIds.add(order.No__c);
            order.Pricebook2Id = nationalPricebook[0].Id;
          }
          //Get orders that already exist
          //Loop over incoming list and only process new order records, no updates to existing records
          //Also remove any orders that have products that don't exist in SF yet
          List<String> existingNoIds = new List<String>();
          List<Order> existingOrders = [
            SELECT Id, No__c
            FROM Order
            WHERE No__c = :orderNavIds
          ];
          for (Order odr : existingOrders) {
            existingNoIds.add(odr.No__c);
          }
          List<Integer> removeList = new List<Integer>();
          for (Integer x = 0; x < Orders.size(); x++) {
            if (existingNoIds.contains(String.valueOf(Orders[x].No__c))) {
              removeList.add(x);
            } else if (
              orderRemovalNos.contains(String.valueOf(Orders[x].No__c))
            ) {
              removeList.add(x);
            }

            //At end of loop, remove all recorded records
            if (x == (Orders.size() - 1)) {
              //Start from the end to avoid out of bounds
              List<Integer> descRemoveList = descBubbleSort(removeList);
              System.debug(descRemoveList);
              for (Integer a : descRemoveList) {
                Orders.remove(a);
              }
            }
          }
          //Upsert By Field
          Schema.SObjectField SObjectKey = Order.Fields.No__c;
          Database.UpsertResult[] dbResultList = Database.upsert(
            Orders,
            SObjectKey,
            false
          );
          System.debug(orderData.lineItems);
          for (Integer i = 0; i < dbResultList.size(); i++) {
            Database.UpsertResult result = dbResultList[i];
            if (result.isSuccess()) {
              //Only create order items when an order has been created, not on update
              if (result.isCreated()) {
                // Operation was successful, so get the ID of the record that was processed
                List<OrderItem> orderItems = new List<OrderItem>();
                for (
                  SalesOrdersParse.CustomLineItem lineItem : orderData.lineItems
                ) {
                  if (lineItem.Order_No == Orders[i].No__c) {
                    OrderItem item = new OrderItem();
                    item.OrderId = result.getId();
                    item.Quantity = lineItem.Quantity;
                    item.Sales_Unit_Of_Measure__c = lineItem.SalesUnitOfMeasure;
                    item.Product2Id = productIdentifierMap.get(lineItem.No);
                    for (Integer x = 0; x < pbEntries.size(); x++) {
                      PricebookEntry entr = pbEntries[x];
                      if (
                        entr.Product2Id == productIdentifierMap.get(lineItem.No)
                      ) {
                        item.PricebookEntryId = entr.Id;
                        item.ListPrice = entr.UnitPrice;
                        item.UnitPrice = entr.UnitPrice;
                      }
                    }
                    //if no matches found
                    if (item.PricebookEntryId == null) {
                      List<PricebookEntry> standardPrice = [
                        SELECT Id, Product2Id
                        FROM PricebookEntry
                        WHERE
                          Pricebook2Id = :(Test.isRunningTest())
                            ? Test.getStandardPricebookId()
                            : stPricebook[0].Id
                          AND Product2Id = :productIdentifierMap.get(
                            lineItem.No
                          )
                      ];
                      if (standardPrice.isEmpty()) {
                        PricebookEntry stpbeYD = new PricebookEntry();
                        stpbeYD.Pricebook2Id = (Test.isRunningTest())
                          ? Test.getStandardPricebookId()
                          : stPricebook[0].Id;
                        stpbeYD.Product2Id = productIdentifierMap.get(
                          lineItem.No
                        );
                        //pbeYD.UseStandardPrice = true;
                        stpbeYD.UnitPrice = lineItem.ListPrice;
                        insert stpbeYD;
                      }
                      PricebookEntry pbeYD = new PricebookEntry();
                      pbeYD.Pricebook2Id = nationalPricebook[0].Id;
                      pbeYD.Product2Id = productIdentifierMap.get(lineItem.No);
                      //pbeYD.UseStandardPrice = true;
                      pbeYD.UnitPrice = lineItem.ListPrice;
                      insert pbeYD;

                      //Then assign
                      item.PricebookEntryId = pbeYD.Id;
                      item.ListPrice = pbeYD.UnitPrice;
                      item.UnitPrice = pbeYD.UnitPrice;
                    }
                    if (item.Product2Id == null) {
                      System.debug(item);
                    }
                    orderItems.add(item);
                  }
                }
                orderItemMap.put(String.valueOf(result.getId()), orderItems);
              }
            } else {
              // Operation failed, so get all errors
              for (Database.Error err : result.getErrors()) {
                System.debug(err.getMessage());
                Util_NavEnvironment.logWebCall(
                  'Get Sales Orders',
                  'Outbound',
                  getSoapEnvelope(),
                  err.getMessage(),
                  false,
                  orderIds[i],
                  Orders[i].No__c
                );
              }
            }
          }
          //Insert line items
          //insert orderItems;
          insertOrderItems(orderItemMap);
        }
      } else {
        Util_NavEnvironment.logWebCall(
          'Get Sales Orders',
          'Outbound',
          getSoapEnvelope(),
          httpResponse.getBody(),
          false,
          ''
        );
      }
    } catch (Exception e) {
      System.debug(e.getMessage());
      System.debug(e.getStackTraceString());
      Util_NavEnvironment.logWebCall(
        'Get Sales Orders',
        'Outbound',
        getSoapEnvelope(),
        e.getMessage(),
        false,
        ''
      );
    }
  }

  public static void insertOrderItems(Map<String, List<OrderItem>> orders) {
    List<String> orderDeletionList = new List<String>();
    for (String key : orders.keySet()) {
      List<OrderItem> items = orders.get(key);
      //Send to DB
      List<Database.SaveResult> dbResultList = Database.insert(items, false);

      //Save Result
      // Iterate through each returned result
      for (Integer i = 0; i < dbResultList.size(); i++) {
        Database.SaveResult result = dbResultList[i];
        if (result.isSuccess()) {
        } else {
          // Operation failed, so get all errors
          for (Database.Error err : result.getErrors()) {
            orderDeletionList.add(items[0].OrderId);
          }
        }
      }
    }
    delete [SELECT Id FROM Order WHERE Id IN :orderDeletionList];
  }

  public static List<Integer> descBubbleSort(List<Integer> items) {
    for (Integer i = 0; i < items.size(); i++) {
      // Last i elements are already in place
      for (Integer j = 0; j < (items.size() - i) - 1; j++) {
        if (items[j] < items[j + 1]) {
          Integer temp = items[j];
          items[j] = items[j + 1];
          items[j + 1] = temp;
        }
      }
    }
    return items;
  }

  public static String getSoapEnvelope() {
    //Get todays date and format for NAV
    String dateString = '';
    String dateFormatString = 'yyyy-MM-dd';
    Date d = Date.today();
    Datetime dt = Datetime.newInstance(d.year(), d.month(), d.day());
    if (dateString == '') {
      dateString = dt.format(dateFormatString);
    }

    String XMLBody = ('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:int="urn:microsoft-dynamics-schemas/page/integration_sales_order">' +
    '<soapenv:Header/>' +
    '<soapenv:Body>' +
    '<int:ReadMultiple>' +
    '<!--1 or more repetitions:-->' +
    '<int:filter>' +
    '<int:Field>Order_Date</int:Field>' +
    '<int:Criteria>' +
    dateString +
    '</int:Criteria>' +
    '</int:filter>' +
    '<!--Optional:-->' +
    '<int:bookmarkKey></int:bookmarkKey>' +
    '<int:setSize>15</int:setSize>' +
    '</int:ReadMultiple>' +
    '</soapenv:Body>' +
    '</soapenv:Envelope>');

    return XMLBody;
  }
}