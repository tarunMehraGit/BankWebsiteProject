@isTest
public class Test_Student_Controller {
    
    public static testMethod void createData(){
        List<Student__c> studentList = new List<Student__c>();
        StudentController student = new StudentController();
        Student__c stu = new Student__c();
        studentList.add(stu);
    }
    
    @isTest
    public static void testMethod1(){
        StudentController student = new StudentController(); 
        student.addNewRow();
    }
    
    public static testMethod void testMethod2(){
        StudentController student = new StudentController(); 
        student.saveRecord();
    }
    
    public static testMethod void testMethod3(){
		StudentController student = new StudentController();  
        student.newRecord();
    }
    
    public static testMethod void testMethod4(){
    	StudentController student = new StudentController();
        student.cancelButton();
    }
    
    public static testMethod void testMethod5(){
        StudentController student = new StudentController();
        student.searchButton();        
    }
}