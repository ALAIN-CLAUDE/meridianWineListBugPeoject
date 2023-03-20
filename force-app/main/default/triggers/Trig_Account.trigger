/*
 * Author: Denson K. Zunga
 * Description: This class synchronizes the Account data between Salesforce & NAV => on the condition that the account has a case related to it.
 * Date: 21 January 2021
 */

trigger Trig_Account on Account (before update) {
    
        
    List <Account> accCustomerToBeCreated = new List <Account>();
        
    for (Account acc : Trigger.new){
        Account oldAcc = Trigger.oldMap.get(acc.Id);
        
        if (oldAcc.Account_Status__c != 'Approved' && acc.Account_Status__c == 'Approved' && acc.No__c != null){
            accCustomerToBeCreated.add(acc);
        }
    }

    if (accCustomerToBeCreated.size() > 0)
        CreateCustomer.invokeMethod(accCustomerToBeCreated);
}