public class Contact_Controller{
    public List<Contact> contactList{get;set;}
    public List<Contact> addContactList{get;set;}
    public List<Contact> newContactList{get;set;}
    public Contact contact{get;set;}
    public Contact_Controller(){
        contactList = new List<Contact>();
        newContactList = new List<Contact>(); 
        addContactList = new List<Contact>();
        contact = new Contact();
        contactList = [SELECT Id, AccountId, FirstName, LastName, Email FROM Contact];
          for(integer row=0;row<1;row++){
            addContactList.add(new Contact());
         }
    }
    public PageReference saveButton(){
        try{
            update contactList;
        }
        catch(Exception e){
           ApexPages.Message errorMessage =  new ApexPages.Message(ApexPages.Severity.ERROR,'Required fields are must.'+e);
           ApexPages.addMessage(errorMessage);
        }
        PageReference savePage = new PageReference('/003/o'); 
        savePage.setRedirect(true);
        return savePage;
    }
    public void addNewRow(){
        addContactList.add(new Contact());
    }
    public PageReference saveRecord(){
        insert addContactList;
        PageReference savePage = new PageReference('/003/o'); 
        savePage.setRedirect(true);
        return savePage;
    }
    public PageReference cancelButton(){
        PageReference cancelPage = new PageReference('/001/o');
        cancelPage.setRedirect(true);
        return cancelPage;
    }
    public void addRow(){
        newContactList.add(new Contact());
    }
}