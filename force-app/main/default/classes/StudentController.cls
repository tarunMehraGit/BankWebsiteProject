public class StudentController {
    public List<Student__c> studentList{get;set;}
    public List<Student__c> addStudentList{get;set;}
    public List<Student__c> newStudentList{get;set;}
    public Student__c student{get;set;}
    public String searchName{get;set;}
    public String searchEmail{get;set;}
    public String searchPhone{get;set;}
    public String query; 
   	public StudentController(){
        studentList = new List<Student__c>();
        addStudentList = new List<Student__c>();
   		newStudentList = new List<Student__c>();	
        for(integer row=0;row<3;row++){
            addStudentList.add(new Student__c());
        }
        init();  
        student = new Student__c();
    }
    public void init(){
        studentList = [SELECT Id, First_Name__c, Last_Name__c,full_name__c,Email__c, Phone__c, DOB__c, Gender__c, Course__c FROM Student__c order by first_name__c];
    }
    public void addNewRow(){
        addStudentList.add(new Student__c());
    }
    public PageReference saveRecord(){
        for(Student__c value : addStudentList){
            if(String.isNotBlank(value.First_Name__c)){
                newStudentList.add(value);
            }
        }
        insert newStudentList;
        PageReference save = new PageReference('/a01/o');  
        save.setRedirect(true);
       	return save;
    }
    public PageReference newRecord(){
        PageReference newPage = new PageReference('/apex/bulk_student');
        newPage.setRedirect(true);
        return newPage;
    }
    public PageReference cancelButton(){
        PageReference backPage = new PageReference('/a01/o');
        backPage.setRedirect(true);
        return backPage;
    }
    public PageReference searchButton(){
        query = 'SELECT Id, First_Name__c, Last_Name__c, Email__c, full_name__c,Phone__c, DOB__c, Gender__c, Course__c FROM Student__c where Id != NULL ' ;
        if(!String.isBlank(searchName)){
        	query += 'and Full_Name__c like \'%' + searchName + '%\' ';
            //' and (First_Name__c like \'%'+searchName+'%\' or Last_Name__c like \'%'+ searchName +'%\') '
        }
       	if(String.isNotBlank(searchEmail)){
            query += 'and Email__c like \'%' + searchEmail + '%\' ';
        }
        if(String.isNotBlank(searchPhone)){	
            query += 'and Phone__c like \'%' + searchPhone + '%\' ';
        }
        else {
             studentList = [SELECT Id, First_Name__c, Last_Name__c,full_name__c,Email__c, Phone__c, DOB__c, Gender__c, Course__c FROM Student__c];
        }
        studentList=database.query(query);
		return null;        
    }
}