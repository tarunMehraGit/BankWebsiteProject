trigger ProjectTaskTrigger on Project_Task__c (before update , after update) {
    String projectTaskId{get;set;}
    Set<Id> projectTaskIds = new Set<Id>();
    for(Project_Task__c projectTask : Trigger.new){
        projectTaskIds.add(projectTask.Id);
    }
    
    Map<id , Project_Task__c> projectTaskMap = new Map<id , Project_Task__c>();
    for(Project_Task__c projectTask : Trigger.new){
        projectTaskMap.put(projectTask.project__c,projectTask);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Project__c> projectList = [SELECT Id , Name , Status__c From Project__c where id =: projectTaskMap.keySet()];
        for(Project__c project : projectList){
            Project_Task__c projectTask = projectTaskMap.get(project.id);
            if(projectTask.Completed__c){
                if(projectTask.Type__c == 'New Task'){
                    project.status__c = 'New';
                }
                else if(projectTask.Type__c == 'Planning Phase'){
                    project.status__c = 'Planning';
                }
                else if(projectTask.Type__c == 'Construction Work'){
                    project.status__c = 'Construction';
                }
                else if(projectTask.Type__c == 'Completion Step'){
                    project.status__c = 'Deployment';
                }
                else if(projectTask.Type__c == 'Contract End'){
                    project.status__c = 'Signoff';
                }   
            } 
        }
        if(projectList.size() > 0){
            UPDATE  projectList;
        }	
    }
    
    if(Trigger.isBefore){
        List<Project_Task__c> projectTaskList = Trigger.new;   
        for(Project_Task__c projectTask : projectTaskList){
            if(projectTask.Completed__c && projectTask.Completion_Date__c == Null){
                projectTask.Completion_Date__c.addError('Completion Date is Empty');	
            }
            else if(!projectTask.Completed__c && projectTask.Completion_Date__c != Null){
                projectTask.Previous_Task__c.addError('Complete Your Task When Completion Date is filled');
            }
            else if(projectTask.Completed__c && projectTask.Previous_Task__c == Null){	
                projectTask.Previous_Task__c.addError('Please Complete Your Previous Task');
            }
            /*else if(!projectTask.Completed__c && projectTask.Previous_Task__c != Null){
                projectTask.Completion_Date__c.addError('Complete Your Completion Date when Task is Filled');
            }*/
        }
        
        List<Project_Task__c> allProjectTaskList = [SELECT Id , Name, (SELECT id , Name , ParentId , ContentType 
                                                                       From Attachments where parentId =: projectTaskIds),
                                                    					Completed__c  
                                                    					From Project_Task__c where Id =: projectTaskIds];
        
        for(Project_Task__c projectTask : allProjectTaskList){
            if(projectTask.Completed__c && projectTask.Attachments.size() == 0) {
                Trigger.newMap.get(projectTask.Id).Completed__c.addError('Please Complete Attachment');
            }
        }
    }
    
    if(Trigger.isAfter){
        EmailTemplate emailTemplate = [SELECT Id,Subject,Description,HtmlValue,DeveloperName,Body
                                       FROM EmailTemplate where Name =: 'projectTaskEmailTemp'];
        Map<Id,Project__c> projectMap = new Map<Id,Project__c>([SELECT Id, Status__c,Project_Owner__c , Project_Owner__r.Full_Name__c,
                                                                Project_Owner__r.Email from Project__c]);
        for(Project_Task__c projectTask : Trigger.new){
            Project__c project = projectMap.get(projectTask.Project__c);
            if(projectTask.Completed__c && projectTask.Type__c == 'Contract End') {
                Messaging.singleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
               
                singleEmailMessage.setTargetObjectId(project.Project_Owner__c);
                singleEmailMessage.setTemplateID(emailTemplate.Id); 
                singleEmailMessage.toAddresses = new String[] {project.Project_Owner__r.Email};
                List<Messaging.Email> emails = new List<Messaging.Email>{singleEmailMessage};    
                Messaging.SendEmailResult[] result = Messaging.sendEmail(emails);
                
                if(result[0].success){
                    System.debug('Email send successfully');
                } else {
                    System.debug('Error : '+result[0].errors[0].message);
                }
            }     
        }
    }
}