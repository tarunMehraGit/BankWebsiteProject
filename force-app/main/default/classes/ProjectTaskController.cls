global with sharing class ProjectTaskController{
    
    global List<Project_Task__c> task{get;set;}
    global String projectTaskId{get;set;}
    
    global  ProjectTaskController(){
        
    }
    
    global List<Project_Task__c> projectTaskDetails{
        get{        
            task = new List<Project_Task__c>();
            Map<Id,Contact> contactMap = new Map<Id,Contact>([Select id, Full_Name__c From Contact]);
            List<Project_Task__c> projectTaskList = [SELECT Id, CreatedDate, CreatedBy.Name,Completed__c,
                                                     Type__c, Completion_Date__c, Project__r.Project_Owner__c
                                                     FROM Project_Task__c where Project__c =: projectTaskId];
            
            for(Project_Task__c projectTask : projectTaskList){
                task.add(projectTask);
            }     
            return  task;
        }
        set;
    }  
}