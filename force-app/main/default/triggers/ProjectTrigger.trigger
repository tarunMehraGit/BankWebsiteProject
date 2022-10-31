trigger ProjectTrigger on Project__c (before insert , before update , after insert , after update) {
    //List<Project__c> projectList = Trigger.new;
    List<Project_Task__c> projectTaskList = new List<Project_Task__c>();
    
    if(Trigger.isAfter && Trigger.isInsert){
        for(Project__c  project : Trigger.new){
            Project_Task__c projectTask = new Project_Task__c();
            projectTaskList.add(new Project_Task__c(Type__c = 'New Task', Project__c = project.id));
            projectTaskList.add(new Project_Task__c(Type__c = 'Planning Phase', Project__c = project.id));
            projectTaskList.add(new Project_Task__c(Type__c = 'Construction Work', Project__c = project.id));
            projectTaskList.add(new Project_Task__c(Type__c = 'Completion Step', Project__c = project.id));
            projectTaskList.add(new Project_Task__c(Type__c = 'Contract End', Project__c = project.id));
        }
        if(projectTaskList.size() > 0){
            insert projectTaskList;
        }
        
        for(Integer i = 1 ; i < projectTaskList.size() ; i++){
            if(projectTaskList.get(i).Type__c != 'New Task'){
                projectTaskList.get(i).Previous_Task__c = projectTaskList.get(i-1).id ;
            }
        }
        if(projectTaskList.size() > 0){
            upsert projectTaskList;
        }	
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        if(Constant.check == true){
            Constant.check = false;
            for(Project__c project : Trigger.new){
                if(project.status__c != Null){
                    Constant cons = new Constant();
                    project.status__c.addError('You can not choose this field from here');
                }
            }
        }
    }
}