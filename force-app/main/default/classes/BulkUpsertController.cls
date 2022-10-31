public class BulkUpsertController {
    public List<Contact> contactList{get;set;}
    public List<Contact> deleteList;
    //public Contact contact{get;set;} 
    public BulkUpsertController(){
    	contactList = [SELECT Id, FirstName, LastName, AccountId, Email FROM Contact];
        deleteList = new List<Contact>();
    }
    public void addNewRow(){
        contactList.add(new contact());
    } 
    public void deleteRecord(){
        Contact contact = contactList.remove(contactList.size()-1);
        if(contact.Id != NULL){
            deleteList.add(contact);
        }  
    }
    public PageReference saveButton(){
        PageReference savePage = new PageReference('/003/o');
        try{
            upsert contactList;
            if(deleteList.size() > 0){
                delete deleteList;	 
            }
        }
        Catch(DmlException e){
            ApexPages.Message errorMessage =  new ApexPages.Message(ApexPages.Severity.ERROR,'Required fields are must.'+e);
            ApexPages.addMessage(errorMessage);
        }
        savePage.setRedirect(true);
        return savePage;
    }
    public PageReference cancelButton(){
        PageReference cancelPage = new PageReference('/003/o');
        cancelPage.setRedirect(true);
        return cancelPage;
    }
}