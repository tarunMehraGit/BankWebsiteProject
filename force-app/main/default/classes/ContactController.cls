public class ContactController {
    public List<Contact> contactList{get;set;}
    public Contact contact{get;set;}
    public ContactController(){
        contactList = new List<Contact>();
 		contact = new Contact();
        ContactList.add(new Contact());
    }
    public void addNewRow(){
        ContactList.add(new Contact());
    }
    public PageReference saveRecord(){
        PageReference savePage;
        try{
            insert ContactList;
        }
        Catch(Exception e){
            ApexPages.Message errorMessage =  new ApexPages.Message(ApexPages.Severity.ERROR,'Required fields are must.'+e);
            ApexPages.addMessage(errorMessage);
        }
        savePage = new PageReference('/003/o');
        savePage.setRedirect(true);
        return savePage;
    }
    public PageReference cancelButton(){
        PageReference cancelPage = new PageReference('/001/o');
        cancelPage.setRedirect(true);
        return cancelPage;
    }
}