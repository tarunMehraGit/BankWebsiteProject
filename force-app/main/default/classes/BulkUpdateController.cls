public class BulkUpdateController {
    public List<Contact> contactList{get;set;}
    public Contact contact{get;set;}
    public BulkUpdateController(){
        contactList = new List<Contact>();
        contact = new Contact();
        contactList = [SELECT Id, AccountId, FirstName, LastName, Email FROM Contact];
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
    public PageReference cancelButton(){
        PageReference cancelPage = new PageReference('/001/o');
        cancelPage.setRedirect(true);
        return cancelPage;
    }
}