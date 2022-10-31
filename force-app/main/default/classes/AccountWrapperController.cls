Public class AccountWrapperController {
    public List<Account> accountList{get;set;}   
    public List<AccountWrapperClass> accountWrapperList{get;set;}
    public Boolean isAllChecked{get;set;}
    public AccountWrapperController(){
        //accountList = [SELECT id,Name,Email__c,phone FROM Account];
        accountList =new List<Account>();
        accountWrapperList = new List<AccountWrapperClass>();
        for(Account acc :[SELECT id,Name,Email__c,phone FROM Account]){
            AccountWrapperClass accountObj = new AccountWrapperClass();
            accountObj.account = acc;  
            accountWrapperList.add(accountObj);
        }
    }
    public class AccountWrapperClass{
        public Boolean isChecked{get;set;}
        public Account account{get;set;}
    }
    public void SelectedAccount(){
     	accountList =new List<Account>();
        for(AccountWrapperClass accountWrapperObj : accountWrapperList){
            if(accountWrapperObj.isChecked){
                accountList.add(accountWrapperObj.account);
            }
        }
    }
    public void allChecked(){
        for(AccountWrapperClass accountWrapper : accountWrapperList){
            if(isAllChecked){
                accountWrapper.isChecked = true;
            }else{
                  accountWrapper.isChecked = false;
            }   
        }
    }
    public void unchecked(){
        for(AccountWrapperClass accountWrapper : accountWrapperList){
            if(accountWrapper.isChecked == false){
                isAllchecked = false;
                break;
            }
            isAllchecked = true;
        }
    }
}