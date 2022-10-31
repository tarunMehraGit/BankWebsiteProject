/*
		Name        :  UserRecordsController
		Date        :  21 October 2021
		Auther      :  TARUN MEHRA
		Description :  This Controller is used for getting users records and task records. 
					   it have wrapper class for retruning object and fields. and also 
					   used for task creation and task deletion.  
*/
public class UserRecordsController {
    
    public UserRecordsController(){
        
    }
    
    //This method used for get user and task records. and it returs wrapperList.
    @AuraEnabled(cacheable=true)
    public static List<UserWrapperClass> getUserRecords(){
        List<UserWrapperClass> userWrapperList = new List<UserWrapperClass>();
        Map<Id, User> userMap = new Map<Id, User>([SELECT Id, Name, Email, FullPhotoUrl FROM User LIMIT 10]);
        Map<Id,List<Task>> taskMap = new Map<Id,List<Task>>();
        
        for(Task task : [SELECT id, Subject,Description,OwnerId,CreatedDate,Status FROM Task WHERE OwnerId =: userMap.keySet()]){
            if(taskMap.containsKey(task.OwnerId)){ 
                List<Task> taskKey = new List<Task>();
                taskKey = taskMap.get(task.OwnerId); 
                taskKey.add(task);
                taskMap.put(task.OwnerId,taskKey);  
                
            } else {
                List<Task> taskKey = new List<Task>();
                taskKey.add(task);
                taskMap.put(task.OwnerId,taskKey);
            }
        }
        
        for(User user : userMap.values()){
            List<Task> tasks = taskMap.containsKey(user.Id) ? taskMap.get(user.Id) : new List<Task>();
            Integer completedTaskCount = 0;
            for(Task task : tasks) {
                completedTaskCount = task.Status == 'Completed' ? completedTaskCount + 1 : completedTaskCount;
            }
            UserWrapperClass userObject = new UserWrapperClass(user, tasks, completedTaskCount);
            userWrapperList.add(userObject);
        }
        return userWrapperList;
    }
    
    //This method used for create task records.
    @AuraEnabled 
    public static void createTaskRecord(id ownerId, String taskSubject, String status){
        Task task = new Task();
        task.OwnerId = ownerId;
        task.Subject = taskSubject;
        task.Status = status;
        try{
            upsert task;
        }catch(Exception e){
            System.debug('Exception : ' + e); 
        }
    }
    
    //This method used for delete task records.
    @AuraEnabled
    public static void deleteRecord(Id delId){
        Delete [SELECT Id, Subject, Description, CreatedDate FROM Task WHERE Id =: delId];
    }
    
    //This method used for Showing Complete tasks and Update the tasks.
    @AuraEnabled
    public static void completeTask(id taskId){
        List<Task> taskList = [SELECT id,status,Subject,Description FROM Task WHERE id =: taskId];
        for(Task task : taskList){
            if(task.Status != 'Completed'){
                task.Status = 'Completed';
            }
        }
        if(taskList.size() > 0){
            UPDATE taskList;
        }
    }
    
    // Wrapper class
    public class UserWrapperClass{
        @AuraEnabled public User userObj;
        @AuraEnabled public List<Task> taskList;
        @AuraEnabled public Integer taskCount;
        @AuraEnabled public Integer completedTaskCount;
        public UserWrapperClass(User us,List<Task> tsk, Integer completedTaskCount){
            userObj = us;
            taskList = tsk;
            taskCount = tsk.size();	
            this.completedTaskCount = completedTaskCount;
        }
    }
}