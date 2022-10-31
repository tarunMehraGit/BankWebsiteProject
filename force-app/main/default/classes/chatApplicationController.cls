public class chatApplicationController {
	
    @AuraEnabled (cacheable=true)
    public static List<ChatApplication__c> getMessageDetails(String send){
        List<ChatApplication__c> chatList = new List<ChatApplication__c>(); 
        String query = 'SELECT Id, Sender__c, Receiver__c, Message__c,UserName__c FROM ChatApplication__c';
        if(String.isNotBlank(send)){
           query += ' WHERE Sender__c LIKE \'%' + send + '%\' ' ;
        }
        chatList = database.query(query);
        return chatList;
    }
    
    @AuraEnabled (cacheable=true)
    public static Contact getContactDetails(String recordId){
        System.debug('recordId'+recordId);
        return [SELECT Id, Name FROM Contact WHERE Id =: recordId];
    }
    
}