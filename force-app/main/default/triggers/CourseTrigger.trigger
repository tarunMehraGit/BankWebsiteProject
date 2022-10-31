trigger CourseTrigger on Course__c (before insert,before update) {
	List<Course__c> courseList = Trigger.new;
    for(Course__c course : courseList){
        if(course.Fees__c == null){
            course.Fees__c.addError('Please Enter Fees');
        }
    }
}