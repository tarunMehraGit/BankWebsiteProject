global class CreateAccountBatch implements Database.Batchable<sObject>, Database.Stateful {
     List<Account> accountList = new List<Account>();
    global Database.QueryLocator start(Database.BatchableContext BC){
        return 	Database.getQueryLocator([SELECT Id From Account]);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> dataList){
       
        for(Integer i=0;i<5;i++){
  			Account account = new Account(Name = 'Account' + (i+1), Email__c = 'test'+i+'@salesforce.com'  , Phone = '805463121' + (i+1));   
            accountList.add(account);
        }  
        //System.debug('Data ' + accountList);
        insert accountList;
        //System.debug('Data Insert ' + accountList);
    }

    global void finish(Database.BatchableContext BC){
		Database.executeBatch(new CreateContactBatch(accountList));      
    }
}