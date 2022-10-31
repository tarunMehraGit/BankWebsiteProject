public class MergeContactController {
    public List<Account> accountList{get;set;}
    public List<contactWrapperClass> contactWrapperList{get;set;}
    public List<Contact> contactRelatedList{get;set;}
    public List<SelectOption> contactOption;
    public String accountId{get;set;}
    public Account account{get;set;}
    public Boolean isMerge{get;set;}
    public List<Contact> contactList;
    
    public MergeContactController(){
		//contactList = [select name, phone, email from contact];	 
       
        contactWrapperList = new List<contactWrapperClass>();
        for(Contact conObj : [select name, phone, contact.AccountId, email from contact]){
          	contactWrapperClass conWrapperObj = new contactWrapperClass();
            conWrapperObj.contact = conObj;
            if(conObj.AccountId == Null){ 
            	contactWrapperList.add(conWrapperObj);
            }
        }
    }
    public List<SelectOption> getAccountOptionList(){
        contactOption = new List <SelectOption>();
        for(Account accountName : [select Id, name from account]){
            contactOption.add(new SelectOption(accountName.Id, accountName.name));
        }
        return contactOption;
    }
    public void mergeButton(){
        contactList = new List<Contact>();
        for(contactWrapperClass conObj : contactWrapperList){
            if(conObj.isChecked){
                conObj.contact.AccountId = accountId; 
                contactList.add(conObj.contact);
            } 
            if(contactList.size() > 0){
                update contactList;
            }
        }
    }
    public void showList(){
        if(accountId != Null){
            isMerge = true;
            account = [select id, name, phone, city__c, email__c from account where id =: accountId];
            contactRelatedList = [select id, name, email, phone from Contact where accountId =: accountId];
        }
        else{
            isMerge = false;
        }
    }
  
    public class contactWrapperClass{
        public boolean isChecked{get;set;}
        public Contact contact{get;set;}
    }
}