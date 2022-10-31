trigger AccountAddressTrigger on Account (before insert,before update) {
    
    List<Account> accountList = [SELECT Id, BillingPostalCode, ShippingPostalCode, Match_Billing_Address__c FROM Account];
    
    if(Trigger.Isbefore){
        for(Account acct : Trigger.new){
            if(acct.Match_Billing_Address__c == true){
                acct.ShippingPostalCode = acct.BillingPostalCode;
            }	
        }
       
    }
}