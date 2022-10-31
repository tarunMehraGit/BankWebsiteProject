public class InlineAccountController {
    public List<ContactWrapperClass> contactWrapperList{get;set;}
    public List<ContactWrapperClass> newcontactWrapperList{get;set;}
    public List<Contact> contactList{get;set;}
    public Integer firstIndex{get;set;} 
    public Integer secondIndex{get;set;}
    public Boolean showHeader{get;set;}
    public Boolean showCopyHeader{get;set;}
    public Id accountId;
    public InlineAccountController(ApexPages.StandardController controller){
   		accountId = controller.getId(); 
   		contactList = new List<Contact>();
       	contactWrapperList = new List<ContactWrapperClass>();
        newcontactWrapperList = new List<ContactWrapperClass>();
        for(Contact con : [SELECT id, name from Contact where AccountId =: NULL]){
            ContactWrapperClass contactWrapperObj = new ContactWrapperClass();
            contactWrapperObj.contact = con;
            contactWrapperList.add(contactWrapperObj);
        }
    }
    public void showContactHeader(){
         for(ContactWrapperClass wrapperObj : contactWrapperList){
            if(showHeader){
                wrapperObj.isChecked=true;
               	ContactWrapperClass contactWrapperObj2 = new ContactWrapperClass();
                showCopyHeader = true;
                contactWrapperObj2.copyChecked = true; 
                contactWrapperObj2.contact = wrapperObj.contact;
                newcontactWrapperList.add(contactWrapperObj2);   
            }
		}  
        contactWrapperList = new List<ContactWrapperClass>();
        showHeader=false;
    }
    public void showCopyHeaderRecord(){
        for(ContactWrapperClass wrapperObj : newcontactWrapperList){
            if(showCopyHeader == false){
            	ContactWrapperClass contactWrapperObj2 = new ContactWrapperClass();
                contactWrapperObj2.contact = wrapperObj.contact;
                contactWrapperList.add(contactWrapperObj2);
            }
        }
        newcontactWrapperList.clear();	
    }
    public void showContact(){   
        ContactWrapperClass contactWrapperObj1 = new ContactWrapperClass();
        contactWrapperObj1.contact = contactWrapperList.get(firstIndex-1).contact;
        contactWrapperObj1.copyChecked = true; 
        showCopyHeader=true;
        newcontactWrapperList.add(contactWrapperObj1);
        contactWrapperList.remove(firstIndex-1);
     }
    public void showCopyRecord(){
        ContactWrapperClass contactWrapperObj = new ContactWrapperClass();
        contactWrapperObj.contact = newcontactWrapperList.get(secondIndex-1).contact;
        contactWrapperList.add(contactWrapperObj);
        newcontactWrapperList.remove(secondIndex-1);
    }
    public void save(){
        for(ContactWrapperClass newObj : newcontactWrapperList){
            newObj.Contact.AccountId = accountId;
            contactList.add(newObj.contact);
        }    
        if(contactList.size() > 0){
            update contactList;
        }
    }
    public class ContactWrapperClass{
        public Contact contact{get;set;}
        public Boolean isChecked{get;set;}
        public Boolean copyChecked{get;set;}
    }
}