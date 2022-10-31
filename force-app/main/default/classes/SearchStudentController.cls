public class SearchStudentController {
    public List<Student__c> studentList{get;set;}
    public Student__c student{get;set;}
    public String searchName{get;set;}
    public String searchCourse;
    public Date searchDate;
    public String query;
    public SearchStudentController(){
        student = new Student__c();
        studentList = new List<Student__c>();
        studentList = [SELECT Id, First_Name__c, full_Name__c,Last_Name__c,Gender__c,Email__c, Course__c, DOB__c FROM Student__c];
    }
    public PageReference doSearch(){
        query = 'SELECT Id, First_Name__c, Last_Name__c,full_Name__c,Gender__c,Email__c, Course__c, DOB__c FROM Student__c where id != NULL ';
        if(String.isNotBlank(searchName)){
            //query += ' and (First_Name__c like \'%'+searchName+'%\' or Last_Name__c like \'%'+searchName+'%\') '	;
            query += 'and Full_Name__c like \'%'+searchName+'%\' ';
        }
        if(student.course__c != null){
            searchCourse = student.course__c; 
            query += ' and course__c =: searchCourse';  
        }
        if(student.DOB__c != NULL){
            searchDate = student.DOB__c;
            query += ' and DOB__c =: searchDate';
        }
        studentList = database.query(query);
        return NULL;
    }
}