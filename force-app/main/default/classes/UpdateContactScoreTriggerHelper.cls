public class UpdateContactScoreTriggerHelper {
    
    public static void updateContactToAccountScore(List<Contact> contactList){
        Set<Id> contactIds = new Set<Id>();
        for(Contact contactRecord : contactList){
            contactIds.add(contactRecord.AccountId);												    
        }
        
    	List<Account> accountList = new List<Account>();
        For(AggregateResult aggregateRecord : [Select AccountId accId, SUM(Score_1__c) totalScoreCountOne,
                                                SUM(Score_2__c) totalScoreCountTwo
                                                From Contact where AccountId IN : contactIds Group By AccountId]){
            Account accountRecord = new Account();
            accountRecord.Score_1__c = Double.valueOf(aggregateRecord.get('totalScoreCountOne'));
            accountRecord.Score_2__c = Double.valueOf(aggregateRecord.get('totalScoreCountTwo'));                                        	 	   
           // acc.Id = aggregateRecord.Id;
            accountRecord.id = String.valueOf(aggregateRecord.get('accId'));   
            accountList.add(accountRecord);    
        }   
        if(!accountList.isEmpty()){
            UPDATE accountList;
        }     
    }  
    
    public static void deleteContactToAccountScore(List<Contact> contactDeleteList){
        System.debug('deleteContactToAccountScore');
    	Set<Id> contactIds = new Set<Id>();
        for(Contact contactRecord : contactDeleteList){
            contactIds.add(contactRecord.AccountId);												    
        }
        
    	List<Account> accountList = new List<Account>();
        for(AggregateResult aggregateRecord : [Select AccountId accId ,SUM(Score_1__c) totalScoreCountOne,
                                                SUM(Score_2__c) totalScoreCountTwo, COUNT(Id) totalCount
                                                From Contact where AccountId IN : contactIds Group By AccountId]){
            Account accountRecord = new Account();
             System.debug('Contact totalCount : '+aggregateRecord.get('totalCount'));
            if(Integer.valueOf(aggregateRecord.get('totalCount')) > 0){
                System.debug('If......');
            	accountRecord.Score_1__c = Double.valueOf(aggregateRecord.get('totalScoreCountOne'));
            	accountRecord.Score_2__c = Double.valueOf(aggregateRecord.get('totalScoreCountTwo'));                                        	 	   
            } else if(Integer.valueOf(aggregateRecord.get('totalCount')) == 0){
                accountRecord.Score_1__c = 0;
            	accountRecord.Score_2__c = 0; 
                System.debug('Else......');
            }                                     
           // acc.Id = aggregateRecord.Id;
            accountRecord.id = String.valueOf(aggregateRecord.get('accId'));   
            accountList.add(accountRecord);    
        }   
        if(!accountList.isEmpty()){
            UPDATE accountList;
        }  	    
    }
    
    public static void unDeleteContactToAccountScore(List<Contact> contactUnDeleteList){
    	System.debug('unDeleteContactToAccountScore........');
        List<id> deletedContactId = new List<Id>();
        for(Contact contactRecord : contactUnDeleteList){
            deletedContactId.add(contactRecord.Id);
        }
        List<Contact> unDeleteContactContList = [SELECT id 
                                                  FROM Contact 
                                                  WHERE AccountId IN:deletedContactId 
                                                  ALL ROWS];
        if(unDeleteContactContList.size()>0){
         	undelete unDeleteContactContList;   
        }
        updateContactToAccountScore(contactUnDeleteList);      
    } 
}