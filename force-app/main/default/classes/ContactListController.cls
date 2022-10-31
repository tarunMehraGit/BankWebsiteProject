Public class ContactListController {
    public List<Contact> insertContactList;
    public List<Contact> updateContactList;
    public List<Contact> deleteList;
    public Integer Index{get;set;}
    public Integer getIndex{get;set;}
    public List<ContactWrapperClass> contactWrapperList{get;set;}
   
    public ContactListController(){
        deleteList = new List<Contact>();
        contactWrapperList = new List<ContactWrapperClass>();
        for(Contact con :  [SELECT Id, FirstName, LastName, Email, Phone FROM Contact]){	
           ContactWrapperClass contactObj = new  ContactWrapperClass();
           contactObj.contact = con;
           contactWrapperList.add(contactObj); 
        }		
    }
    public void saveRecord(){   
        insertContactList = new List<Contact>();
        updateContactList = new List<Contact>();
        for(ContactWrapperClass con : contactWrapperList){
            if(con.isChecked){
                if(con.contact.Id != NULL){
                    updateContactList.add(con.contact);
                }else{
                    insertContactList.add(con.contact);
                }
            }
        }
        try{
            if(insertContactList.size() > 0){
                insert insertContactList;
            }
            if(updateContactList.size() > 0){
                update updateContactList;
            }
            if(deleteList.size() > 0){
                Delete deleteList;
                deleteList.clear();
            }
        }
        catch(DmlException e){
            ApexPages.Message errorMessage =  new ApexPages.Message(ApexPages.Severity.ERROR,'Required fields are must...');
            ApexPages.addMessage(errorMessage);
        }
    }
    public void addRecord(){
        ContactWrapperClass obj = new ContactWrapperClass();
        obj.contact = new Contact();
        contactWrapperList.add(getIndex, obj);
        obj.isChecked = true;
    }
    public void deleteButton(){
        ContactWrapperClass  conObj = contactWrapperList.remove(Index-1);
        if(conObj.contact.id != NULL){
            deleteList.add(conObj.contact);
        }
    }
    public class ContactWrapperClass{
        public Boolean isChecked{get;set;}
        public Contact contact{get;set;}
    }  
}