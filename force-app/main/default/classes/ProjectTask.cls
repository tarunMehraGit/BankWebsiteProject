global class ProjectTask {
    global String CompletedBy{get;set;}  
    global String projectTaskId {get;set;}
    global Project_Task__c projectTask{get;set;}
    global List<Project_Task__c> projectTaskList{get;set;}
    public ProjectTask(){
        CompletedBy = 'CompletedBy';
        System.debug('%%%%%%');
    }
    /*global List<Project_Task__c> ProjectTaskDetails(){
        get
        {
        	projectTaskList = [SELECT Id, Name, CreatedDate, CreatedById, Type__c, Completion_Date__c, Completed__c, Previous_Task__c
                		   FROM Project_Task__c where Id =: projectTaskId];
       		System.debug('Id : ' + projectTaskId);
        	return projectTaskList;
        }
        set;
      
    }*/
     global List<Project_Task__c> ProjectTaskDetails{
       
         get {
              System.debug('Raaaav..');
          projectTaskList = [SELECT Id, Name, CreatedDate, CreatedById, Type__c, Completion_Date__c, Completed__c, Previous_Task__c
                		   FROM Project_Task__c where Id =: projectTaskId];
          return projectTaskList;
        }
       set;
    }
}