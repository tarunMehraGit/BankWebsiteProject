global class CreateContactBatch implements Database.Batchable<sObject> {
	List<Account> accountList = new List<Account>();
    
    global CreateContactBatch(List<Account> newaccountList){
        accountList = newaccountList;
    }
    
    global List<Account> start(Database.BatchableContext BC){
        return accountList;
    }
    
    global void execute(Database.BatchableContext BC, List<Account> acc){
		Integer i=1;
        List<Contact> contactList = new List<Contact>();
        for(Account acccountObj: acc){
            Contact contact = new Contact(FirstName = 'Batch', LastName = 'Class'+i, Email = 'contactBatch'+i+'@yahoo.com'); 
       		i++;
            contactList.add(contact);
        }
        insert contactList;
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}