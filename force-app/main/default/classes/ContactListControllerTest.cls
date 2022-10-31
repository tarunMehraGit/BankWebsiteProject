@isTest
public class ContactListControllerTest {
	
    @isTest
    public static void getContact(){
       // ContactListController.ContactWrapperClass contactController = new ContactListController.ContactWrapperClass();
       	 List<Contact> contactList = new List<Contact>();
        contactList.add(new Contact(FirstName = 'Tarun', LastName='Mehra', Email = 't@gmail.com', Phone = '695452222' ));
        if(contactList.size() > 0){
            insert contactList;
        }
        //List<Contact> contactList = contactController.insertContactList;
        //List<Contact> contactList1 = contactController.updateContactList;
        //List<Contact> contactList2 = contactController.deleteList;
        //System.assert(contactList.size() == 0); 
    }
    
    public static testMethod void saveRecord(){
     	ContactListController contactController = new ContactListController();
     	Test.startTest();
        /*for(contactController ;){
            
        }*/
        
        contactController.saveRecord();
        Test.stopTest();
    }
    public  static testMethod void addRecord(){
        ContactListController contactController = new ContactListController();
        
    }
}