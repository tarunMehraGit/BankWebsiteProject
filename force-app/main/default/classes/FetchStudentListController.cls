public with sharing class FetchStudentListController {
    public FetchStudentListController() {

    }
    @AuraEnabled (cacheable=true)
    public static List<Student__c> getStudentList(){
      return [SELECT Id, First_Name__c, Last_Name__c, Phone__c, Email__c FROM Student__c];
    }
    @AuraEnabled 
    public static Student__c editStudentRecord(Id recordId){
      return [SELECT Id, First_Name__c, Last_Name__c, Phone__c, Email__c  FROM Student__c where Id =: recordId];
    }
    @AuraEnabled
    public static void saveRecord(Student__c student, Id studentClone){
      if(studentClone != Null){
        student.Id = Null;
        insert student;
      }else{
        upsert student;
      }
    }
    @AuraEnabled
    public static void deleteRecord(Id deleteId){
      Delete [SELECT Id, First_Name__c, Last_Name__c, Phone__c, Email__c  FROM Student__c where Id =: deleteId];
    }
    @AuraEnabled
    public static  Student__c cloneRecord(Id cloneId){
      return  [SELECT Id, First_Name__c, Last_Name__c, Phone__c, Email__c  FROM Student__c where Id =: cloneId];
    }
}