public class CreateAccountController {
	
    @auraEnabled
    public static String createAccountRecord(Account record){
     	System.debug('Record : '+ record);
        try{
            if(record.Id != NUll){
                INSERT record;
            } 
        }
        catch(Exception e){
            System.debug('Exception : '+e.getMessage());
        }
        return 'success';
    }
    
}