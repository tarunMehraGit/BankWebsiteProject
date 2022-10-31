@isTest
public class ContactControllerTest {
	
    @isTest
    public static void getContact(){
        ContactController contactController = new ContactController();
        List<Contact> contactList = contactController.contactList;
        Integer size = contactList.size();
    	System.assert(size == 1, 'Size ' + size);
    }
    @isTest 
    public static void getData(){
       	ContactController contactController = new ContactController();
        try{
        	contactController.saveRecord();
        }
        catch(DMLException e){
           	ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.error, e.getMessage());
            ApexPages.addMessage(msg);
        }
    }
    public static testMethod void getCancel(){
        ContactController contactController = new ContactController();
        contactController.cancelButton();
    }
    public static testMethod void addRow(){
        ContactController contactController = new ContactController();
        contactController.addRow(); 
    }
    public static testMethod void addNewRow(){
        ContactController contactController = new ContactController();
        contactController.addNewRow(); 
    }
}