global class ProjectTaskBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([Select Id, Name , status__c FROM Project__c]);
    }
    
    global void execute(Database.BatchableContext BC, List<Project__c> dataList){
        //List<Contact> contactList = [SELECT id, FirstName FROM Contact];
        for(Project__c project : dataList){
            if(project.status__c == 'Deployment'){
                //<c:Project_Task_Component projectId="My component's value" />	
                //Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
                //singleEmailMessage.setToAddresses();	
                //singleEmailMessage.setSubject(project.Status__c);
            }
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}