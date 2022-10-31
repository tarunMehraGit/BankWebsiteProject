public class SharingBankObject {
	
    public static void shareBankRecord(){
        
        List<Account> accountList = [SELECT Id FROM Account WHERE NAME = 'Testing Picklist 1'];
        
        AccountShare accShare = new AccountShare();
        accShare.AccountId = accountList[0].Id;
        accShare.UserOrGroupId = '0055g00000C7rGZAAZ';
        accShare.AccountAccessLevel = 'Read';
        accShare.OpportunityAccessLevel = 'Read';
        INSERT accShare;
        
        System.debug('Shared Account Record : '+accShare);
        /*List<Account> bankList = [SELECT Id FROM Bank__c WHERE Name = 'BARODA BANK' LIMIT 1];
        
        Bank__Share bankShare = new Bank__Share();
        bankShare.ParentId = bankList[0].Id;
        bankShare.UserOrGroupId = '0055g00000DJujQAAT';
        bankShare.AccessLevel = 'Read';
        INSERT bankShare;*/
    }
   
}