global class CourseDetailsSchedule implements Schedulable {
    global void execute(SchedulableContext sc){
        CourseDetailsBatch courseDetails = new CourseDetailsBatch();
        Database.executeBatch(courseDetails);
    }	
}