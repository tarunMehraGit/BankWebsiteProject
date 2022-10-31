@isTest
public class AccountWrapperControllerTest {
	
    @isTest
    public static void createData(){
        List<Account> accountList = new List<Account>();
        test.startTest();
        AccountWrapperController.AccountWrapperClass accountWrapper = new AccountWrapperController.AccountWrapperClass();
      	accountList.add(accountWrapper.account);
        test.stopTest();  	
    }
    
    @isTest
    public static void testMethod1(){
        List<Account> accountList = new List<Account>();
        test.startTest();
        AccountWrapperController wrap = new AccountWrapperController();
        AccountWrapperController.AccountWrapperClass accountWrapper = new AccountWrapperController.AccountWrapperClass();
        wrap.SelectedAccount();
        accountWrapper.isChecked = true;
        accountList.add(accountWrapper.account);
        test.stopTest(); 
    }
    
    @isTest 
    public static void testMethod2(){
    	test.startTest();
        AccountWrapperController wrap = new AccountWrapperController();
        AccountWrapperController.AccountWrapperClass accountWrapper = new AccountWrapperController.AccountWrapperClass(); 
        wrap.isAllChecked = true;
 		wrap.allChecked();
        accountWrapper.isChecked = true;
        test.stopTest();
    }
    
    @isTest
    public static void testMethod3(){
        test.startTest();
        AccountWrapperController wrap = new AccountWrapperController();
        AccountWrapperController.AccountWrapperClass accountWrapper = new AccountWrapperController.AccountWrapperClass(); 
        wrap.unchecked();
        wrap.isAllChecked = false;
        accountWrapper.isChecked = false;
        test.stopTest();
    }

}