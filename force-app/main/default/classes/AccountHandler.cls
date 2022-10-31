public class AccountHandler {
	
    public static Account insertNewAccount(String name){
        Account a = new Account();
        a.Name = name;
        a.Email__c = 'test.trail@gmail.com';
        
        try{
            insert a;
        }
        catch(Exception e){
            return null;
        }
        {
        	return a;
        }
    }
}