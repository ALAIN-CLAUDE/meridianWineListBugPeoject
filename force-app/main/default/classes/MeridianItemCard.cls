public class MeridianItemCard implements Schedulable {
  public static HttpRequest httpRequest = new HttpRequest();
  public static HttpResponse httpResponse = new HttpResponse();

  public void execute(SchedulableContext ctx) {
    List<Posting_Groups__c> postingGroups = [ SELECT Id, Name FROM Posting_Groups__c];
    for (Posting_Groups__c groupName : postingGroups) {
      if (groupName.Name != null) {
        makeItemCardRequest(groupName.Name);
      }
    }
  }

  @future(callout=true)
  public static void makeItemCardRequest(String groupName) {
    try {
      Map<String, String> headers = new Map<String, String>();
      headers.put('Content-Type', 'text/xml;charset=UTF-8');
      headers.put('Accept-Encoding', 'gzip,deflate');
      headers.put(
        'SOAPAction',
        '"urn:microsoft-dynamics-schemas/page/integration_item_card:ReadMultiple"'
      );
      httpResponse = Util_NavEnvironment.makeWebCallout(
        'POST',
        Util_NavEnvironment.getNavBaseUrl() +
        '/WS/Cool%20Wines/Page/Integration_Item_Card',
        getSoapEnvelope(groupName),
        headers,
        120000
      );

      if (
        httpResponse.getStatusCode() == 200 || httpResponse.getStatusCode() == 201 || httpResponse.getStatusCode() == 204
      ) {
          //System.debug(httpResponse.getBody());
        dom.Document resDoc = httpResponse.getBodyDocument();
        List<Product2> Product = [
          SELECT
            Id,
            Automatic_Ext_Texts__c,
            Base_Unit_of_Measure__c,
            Blocked__c,
            Created_From_Nonstock_Item__c,
            Description,
            Gen_Prod_Posting_Group__c,
            Gross_Weight__c,
            Inventory_Posting_Group__c,
            Inventory__c,
            Item_Category_Code__c,
            Key__c,
            Name,
            Net_Weight__c,
            No__c,
            Prevent_Neg_Inventory_Default__c,
            ProductCode,
            Qty_on_Asm_Component__c,
            Qty_on_Assembly_Order__c,
            Qty_on_Component_Lines__c,
            Qty_on_Job_Order__c,
            Qty_on_Prod_Order__c,
            Qty_on_Purch_Order__c,
            Qty_on_Sales_Order__c,
            Qty_on_Service_Order__c,
            Search_Description__c,
            Smollan_Vendor__c,
            Special_Purch_Prices_And_Discounts__c,
            Stockout_Warning_Default__c,
            Type__c,
            Unit_Volume__c,
            VAT_Prod_Posting_Group__c,
            Unit_of_Measure_Code__c
          FROM Product2
          Order By LastModifiedDate DESC
          LIMIT 50000
        ];

        Map<String, Product2> existingProdMap = new Map<String, Product2>();
        for(Product2 prod : Product){
          existingProdMap.put(prod.Id, prod);
        }

        ItemCardParse.ProductItem results = ItemCardParse.itemInfo(resDoc);
        Product = results.items;
        if (!Product.isEmpty()) {

          //upsert Product No__c;
            
            List<Pricebook2> nationalPricebook = [Select id from Pricebook2 where Name = 'National Price List P01'];
            List<Pricebook2> stPricebook = [Select id from Pricebook2 where isStandard=true];
            List<PricebookEntry> pbEntries = new List<PricebookEntry>();
            List<PricebookEntry> pbEntriesCustom = new List<PricebookEntry>();
            List<PricebookEntry> pbEntriesToUpdate = new List<PricebookEntry>();

            List<PricebookEntry> allentries = [SELECT Id, Name, Pricebook2Id, Product2Id, UnitPrice, IsActive, UseStandardPrice, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, ProductCode, IsDeleted, IsArchived FROM PricebookEntry Where Pricebook2Id =: nationalPricebook[0].Id Order By LastModifiedDate ASC LIMIT 20000];
            Map<String, PricebookEntry> entryMap = new Map<String, PricebookEntry>();
            for(PricebookEntry entry : allentries){
              if(existingProdMap.get(entry.Product2Id) != null){
                entryMap.put(existingProdMap.get(entry.Product2Id).No__c, entry);
              }
            }


            Database.UpsertResult[] upserts = Database.upsert(Product, Product2.No__c);
            for(Integer index = 0, size = upserts.size(); index < size; index++) {
                if(upserts[index].isSuccess()) {
                    if(upserts[index].isCreated()) {
                        PricebookEntry pbeYD = new PricebookEntry();
                        pbeYD.Pricebook2Id = (Test.isRunningTest()) ? Test.getStandardPricebookId() : stPricebook[0].Id;
                        pbeYD.Product2Id = Product[index].Id;
                        //pbeYD.UseStandardPrice = true;
                        pbeYD.UnitPrice = results.priceMap.get(Product[index].No__c);            
                        pbEntries.add(pbeYD);
                        
                        PricebookEntry pbeYDCustom = new PricebookEntry();
                        pbeYDCustom.Pricebook2Id = nationalPricebook[0].Id;
                        pbeYDCustom.Product2Id = Product[index].Id;
                        //pbeYD.UseStandardPrice = true;
                        pbeYDCustom.UnitPrice = results.priceMap.get(Product[index].No__c);            
                        pbEntriesCustom.add(pbeYDCustom);
                    } else {
                      PricebookEntry entryToUpdate = entryMap.get(Product[index].No__c);
                      if(entryToUpdate != null){
                        entryToUpdate.UnitPrice = results.priceMap.get(Product[index].No__c);
                        pbEntriesToUpdate.add(entryToUpdate);
                      }
                    }
                }
            }
            Insert pbEntries;
            Insert pbEntriesCustom;
            Update pbEntriesToUpdate;
        }
      } else {
        Util_NavEnvironment.logWebCall(
          'Get Item Card',
          'Outbound',
          getSoapEnvelope(groupName),
          httpResponse.getBody(),
          false,
          ''
        );
      }
    } catch (Exception e) {
      Util_NavEnvironment.logWebCall(
        'Get Item Card',
        'Outbound',
        getSoapEnvelope(groupName),
        e.getMessage(),
        false,
        ''
      );
    }
  }

  public static String getSoapEnvelope(String groupName) {
    String XMLBody;
    XMLBody = ('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:int="urn:microsoft-dynamics-schemas/page/integration_item_card">' +
    '<soapenv:Header/>' +
    '<soapenv:Body>' +
    '<int:ReadMultiple>' +
    '<!--1 or more repetitions:-->' +
    '<int:filter>' +
    '<int:Field>Gen_Prod_Posting_Group</int:Field>' +
    '<int:Criteria>' +
    groupName +
    '</int:Criteria>' +
    '</int:filter>' +
    '<int:filter>' +
    '<int:Field>Blocked</int:Field>' +
    '<int:Criteria>false</int:Criteria>' +
    '</int:filter>' +
    '<!--Optional:-->' +
    '<int:bookmarkKey></int:bookmarkKey>' +
    '<int:setSize></int:setSize>' +
    '</int:ReadMultiple>' +
    '</soapenv:Body>' +
    '</soapenv:Envelope>');

    System.debug('XML Body' + XMLBody);
    return XMLBody;
  }
}