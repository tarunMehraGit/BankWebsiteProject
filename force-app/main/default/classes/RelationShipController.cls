public class RelationShipController {
    public List<Contact> contactList {get;set;}
    public List<Account> accountList {get;set;}
    public RelationShipController(){
        //child To Parent
        contactList = [select id, name, phone, email,
                       Account.id, Account.Name, Account.Email__c
                       from Contact limit 5];
        //Parent to Child
        accountList = [select id, name, phone, email__c,
                       (select id, name, phone from contacts)
                       from account];
    }
}