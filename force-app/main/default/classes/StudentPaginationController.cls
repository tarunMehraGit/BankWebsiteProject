public class StudentPaginationController {
    public List<Student__c> studentList{get;set;}
    public List<Student__c> newStudentList{get;set;}
    public Integer index = 0;
    public Integer pageSize{get;set;}
    public Integer totalRecords;
    public Boolean showButton{get;set;}
    public StudentPaginationController(){
        pageSize=5;
        studentList = new List<Student__c>();
        newStudentList = new List<Student__c>(); 
        totalRecords = [Select count() From Student__c];
    }
    public List<Student__c> getStudentListPag(){
        studentList = Database.query('SELECT Id, First_Name__c, Last_Name__c, Phone__c, Email__c from Student__c LIMIT :pageSize OFFSET :index');
    	newStudentList.addAll(studentList);	
        return studentList;
    }
    public List<SelectOption> getOptions(){
       List<SelectOption> listoptions = new List<SelectOption>();
        listoptions.add(new SelectOption('0','All'));
        listoptions.add(new SelectOption('5','5'));
        listoptions.add(new SelectOption('10','10'));
        listoptions.add(new SelectOption('15','15'));
        listoptions.add(new SelectOption('25','25'));
        return listoptions;
    }
   /* public void selectList(){
        Integer num = 0; 
        newStudentList = new List<Student__c>();
        if(pageSize == 0){
            pageSize = totalRecords;
        }else{
            integer num1 = pageSize > studentList.size() ? studentList.size() : pageSize ; 
            for(;num<num1;num++){
                newStudentList.add(studentList[num]);
            }
        }
    }*/ 
    public void firstPage(){
      	index = 0;
        showButton = false;
    }
    public void nextPage(){
   		index += pageSize;
    }
    public void previousPage(){
        index -= pageSize;
    }
    public void lastPage(){
        index = totalRecords - math.mod(totalRecords,pageSize); 
    }
}