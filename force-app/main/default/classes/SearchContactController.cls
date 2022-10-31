public with sharing class SearchContactController {
    
    public SearchContactController(Integer totalRecords) {
       
    }

    @AuraEnabled (cacheable=true)
    public static list<Contact> getContactSearchingList(String searchKey){
       List<Contact> contactList = new  List<Contact>();
       String query = 'SELECT Id , Name, Email, Account.Name, Phone, Type__c FROM Contact';
       if(String.isNotBlank(searchKey)){
           query += ' WHERE Name LIKE \'%' + searchKey + '%\' or Email LIKE \'%' + searchKey + '%\' ';
       }
        contactList = database.query(query);
        return contactList;
    }
}