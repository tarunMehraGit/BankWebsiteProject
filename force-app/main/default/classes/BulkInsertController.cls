public class BulkInsertController {
    public List<Student__c> studentList{get;set;}
     public List<Student__c> newstudentList{get;set;}
    public BulkInsertController(){
        studentList = new List<Student__c>();
        newstudentList = new List<Student__c>();
        for(integer row=0;row<3;row++){
            studentList.add(new Student__c());
        } 
    }
    public PageReference saveRecord(){  
        try{
            for(Student__c value : studentList){
                if(String.isNotBlank(value.First_Name__c) && String.isNotBlank(value.Course__c)){
                    newstudentList.add(value);
                }
            }
            insert newstudentList;
        }
        Catch(Exception e){
            ApexPages.Message errorMessage =  new ApexPages.Message(ApexPages.Severity.ERROR,'Required fields are must.'+e);
            ApexPages.addMessage(errorMessage);    
        }
        PageReference savePage = new PageReference('/a01/o');
        savePage.setRedirect(true);
        return savePage;
    }
    public PageReference cancelButton(){
        PageReference cancelPage = new PageReference('/001/o');
        cancelPage.setRedirect(true);
        return cancelPage;
    }
}