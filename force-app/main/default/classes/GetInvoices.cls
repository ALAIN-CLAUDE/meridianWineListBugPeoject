/**=================================================================================================================================
* Created By: Denson Zunga & Tawanda Madavo
* Created Date: 14/01/2021
* Description: Class to handle get invoice callouts
===================================================================================================================================**/
public class GetInvoices implements Schedulable {
  public static HttpRequest httpRequest = new HttpRequest();
  public static HttpResponse httpResponse = new HttpResponse();

  public void execute(SchedulableContext ctx) {
    List<Order> orderInvoice = [
      SELECT Id, OrderNumber, Sales_Order_No__c, Invoice_Created__c
      FROM Order
      WHERE Sales_Order_No__c != NULL AND Invoice_Created__c = FALSE
      LIMIT 45
    ];

    for (Order orderInfo : orderInvoice) {
      getInvoiceRequest(orderInfo.Sales_Order_No__c, orderInfo.Id);
    }
  }

 // @future(callout=true)
  public static void getInvoiceRequest(String orderNumber, String orderId) {
    try {
      Map<String, String> headers = new Map<String, String>();
      headers.put('Content-Type', 'text/xml;charset=UTF-8');
      headers.put('Accept-Encoding', 'gzip,deflate');
      headers.put(
        'SOAPAction',
        '"urn:microsoft-dynamics-schemas/page/integration_posted_sales_invoice:ReadMultiple"'
      );
      httpResponse = Util_NavEnvironment.makeWebCallout(
        'POST',
        Util_NavEnvironment.getNavBaseUrl() +
        '/WS/Cool%20Wines/Page/Integration_Posted_Sales_Invoice',
        getSoapEnvelope(orderNumber),
        headers,
        120000
      );
      if (
        httpResponse.getStatusCode() == 200 || httpResponse.getStatusCode() == 201 || httpResponse.getStatusCode() == 204
      ) {
        if (httpResponse.getBody() != null && httpResponse.getBody() != '') {
          dom.Document resDoc = httpResponse.getBodyDocument();
          ParseXML.parseXMLBody(resDoc.toXmlString());
          System.debug(resDoc.toXmlString());
        }
      } else {
        Util_NavEnvironment.logWebCall(
          'Get Invoices',
          'Outbound',
          getSoapEnvelope(orderNumber),
          httpResponse.getBody(),
          false,
          orderId
        );
      }
    } catch (Exception e) {
      Util_NavEnvironment.logWebCall(
        'Get Invoices',
        'Outbound',
        getSoapEnvelope(orderNumber),
        e.getMessage(),
        false,
        orderId
      );
    }
  }

  public static String getSoapEnvelope(String orderNumber) {
    String XMLBody;
    XMLBody = ('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:int="urn:microsoft-dynamics-schemas/page/integration_posted_sales_invoice">' +
    '<soapenv:Header/>' +
    '<soapenv:Body>' +
    '<int:ReadMultiple>' +
    '<!--1 or more repetitions:-->' +
    '<int:filter>' +
    '<int:Field>Order_No</int:Field>' +
    '<int:Criteria>' +
    orderNumber +
    '</int:Criteria>' +
    '</int:filter>' +
    '</int:ReadMultiple>' +
    '</soapenv:Body>' +
    '</soapenv:Envelope>');
    return XMLBody;
  }
}