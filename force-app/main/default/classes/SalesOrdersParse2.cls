public class SalesOrdersParse2 {
public static String salesOrderResp(dom.Document doc){
        String salesOrderNo;
        
        Dom.XmlNode rootElement = doc.getRootElement();
        
        for(Dom.XmlNode childElement : rootElement.getChildElements()){
            if(!String.isBlank(rootElement.getName())){
                if(childElement.getName()=='Body'){
                    for(Dom.XmlNode childElement1 : childElement.getChildElements()){
                        //System.debug('Name childElement1 : '+childElement1.getName());
                        if(childElement1.getName()=='Create_Result'){
                            for(Dom.XmlNode childElement2 : childElement1.getChildElements()){
                                //System.debug('Name childElement2 : '+childElement2.getName());
                                if(childElement2.getName()=='Integration_Sales_Order'){
                                    for(Dom.XmlNode childElement3 : childElement2.getChildElements()){
                                        //System.debug('Name childElement3 : '+childElement3.getText());
                                        if(childElement3.getName()=='No'){
                                            salesOrderNo = childElement3.getText();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return salesOrderNo;
    }
    
    public static String salesOrderErrorResp(dom.Document doc){
        String error;
        
        Dom.XmlNode rootElement = doc.getRootElement();
        
        for(Dom.XmlNode childElement : rootElement.getChildElements()){
            //System.debug('Name childElement : '+childElement.getName());
            if(!String.isBlank(rootElement.getName())){
                if(childElement.getName()=='Body'){
                    for(Dom.XmlNode childElement1 : childElement.getChildElements()){
                        //System.debug('Name childElement1 : '+childElement1.getName());
                        if(childElement1.getName()=='Fault'){
                            for(Dom.XmlNode childElement2 : childElement1.getChildElements()){
                                //System.debug('Name childElement2 : '+childElement2.getName());
                                if(childElement2.getName()=='detail'){
                                    for(Dom.XmlNode childElement3 : childElement2.getChildElements()){
                                        //System.debug('Name childElement3 : '+childElement3.getName());
                                        if(childElement3.getName()=='string'){
                                            error = childElement3.getText();
                                        }
                                    } 
                                }
                            }
                        }
                    }
                } 
            }
        }
        
        Return error;
    }
}