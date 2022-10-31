public class displayAllAccounts {

    public static List<Account> getAccountList(){
        return [SELECT Name, Phone, Rating, Email__c FROM Account];
    }

}