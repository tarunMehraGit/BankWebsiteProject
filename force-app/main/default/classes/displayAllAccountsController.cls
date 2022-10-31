public class displayAllAccountsController {
    
    public displayAllAccountsController(){

    }

    @AuraEnabled (cacheable=true)
    public static List<Account> getAccountSearchingRecord(String searchkey){
        List<Account> accountList = new  List<Account>();
       String query = 'SELECT Id , Name , (SELECT Id FROM Contacts), Phone, Rating, Email__c FROM Account';
        if(String.isNotBlank(searchKey)){
           query += ' WHERE Name LIKE \'%' + searchKey + '%\' ' ;
        }
        accountList = database.query(query);
        return accountList;
    }

    @AuraEnabled 
    public static void editRecord(Account accountRecord){
        UPDATE accountRecord;
    }

    @AuraEnabled
    public static void deleteRecord(Id delId){
        Delete [SELECT Id, Name, Phone, Rating, Email__c FROM Account WHERE Id =: delId];
    }

    @AuraEnabled
    public static Account fatchRecord(Id id){
        return [SELECT Id, Name, Phone , Rating, Email__c FROM Account WHERE Id =: id];
    }  
}