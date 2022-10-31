global class CourseDetailsBatch implements Database.Batchable<sObject> {
    
	global Database.QueryLocator start(Database.BatchableContext bc) {
       return Database.getQueryLocator([Select Id, End_Date__c , status__c 
                                        FROM Course_Details__c WHERE End_Date__c <: Date.today()]);
    }
    global void execute(Database.BatchableContext bc, List<Course_Details__c> courseRecords){
        List<Course_Details__c> courseDetailsList = new List<Course_Details__c>();
        for(Course_Details__c course : courseRecords){
         	course.status__c = 'Completed';
            courseDetailsList.add(course);
        }
        if(!courseDetailsList.isEmpty()){
            UPDATE courseDetailsList;
        }
    }    
    global void finish(Database.BatchableContext bc){
    }    
}