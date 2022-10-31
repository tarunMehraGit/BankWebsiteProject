@isTest
public class StudentControllerTest {
	
    @isTest
    public static void getStudent(){
        StudentController studentController = new StudentController();
        List<Student__c> studentList = studentController.studentList;
        List<Student__c> newStudentList = studentController.newStudentList;
        List<Student__c> addStudentList = studentController.addStudentList;
        System.assert(studentList.size() == 0);
    }
    public static testMethod void addStudent(){
        student__c student = new Student__c(First_Name__c = 'Bhavit', Last_Name__c = 'Kumar', Email__c = 'bhavit@gmail.com');
        Test.startTest();
        insert student;
        Test.stopTest();
    }
    public static testMethod void saveRecord(){
        StudentController studentController = new StudentController();
        //Student__c student = new Student__c();
        //studentController.newStudentList.add(student);
         try{
        	studentController.saveRecord();
        }
        catch(DMLException e){
           	ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.error, e.getMessage());
            ApexPages.addMessage(msg);
        }
    }
    
    @isTest
    public static void searchStudent(){
        StudentController studentController = new StudentController();
        studentController.searchName = 'Tarun';
        studentController.searchButton();
        studentController.searchEmail='tarun@gmail.com';
        studentController.searchButton();
        studentController.searchPhone = '4563121010';
        studentController.searchButton();   
    }
    
    @isTest
    public static void newRecord(){
         StudentController studentController = new StudentController();
        studentController.newRecord();
    }
    
    @isTest
    public static void addNewRow(){
        StudentController studentController = new StudentController();
        studentController.addNewRow();
    }
    
    @isTest 
    public static void cancelRecord(){
        StudentController studentController = new StudentController();
        studentController.cancelButton();
    }
}