public class RelatedContact {
	
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecord(){        
        List<Account> accountList = [Select Id,Name,AccountNumber,Type,Industry,Rating,(select id,Full_Name__c,Email from Contacts)
                                     FROM Account];
        return accountList;
    }
}