public class StudentEmailController {
    public List<StudentWrapperClass> studentWrapperList{get;set;}
    public Boolean headerCheck{get;set;}
    public List<String> toAddress{get;set;}
    public Boolean sendAttachment{get;set;}
    public String subject{get;set;}
    public String body{get;set;}
   	public List<Messaging.EmailFileAttachment> attachments{get;set;}
    public StudentEmailController(){
        
        studentWrapperList = new List<StudentWrapperClass>();
        for(Student__c studentObj : [SELECT Id, First_Name__c, Phone__c, Email__c FROM Student__c]){
            StudentWrapperClass stu = new StudentWrapperClass();
            stu.student = studentObj;
            studentWrapperList.add(stu);
        }
    }
    public void headerChecked(){
        toAddress = new List<String>();
        for(StudentWrapperClass obj : studentWrapperList){
            if(headerCheck){
                obj.isChecked = true;
                toAddress.add(obj.student.Email__C);
            }else{
                obj.isChecked = false;
            }
        }
    }
    public void manualChecked(){
        toAddress = new List<String>();
        for(StudentWrapperClass obj : studentWrapperList){
            if(obj.isChecked){
                 if(!String.isBlank(obj.student.Email__C)){
                 	toAddress.add(obj.student.Email__C);
                 }
            } 
        }
    }
    public pageReference sendEmail(){
        try{
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(toAddress);
            message.setSubject(subject);
            message.setSenderDisplayName('Ibirds Software PVT.LTD. Ajmer');
            message.setPlainTextBody(body);
            /*attachments = new List<Messaging.EmailFileAttachment>();
            for(Attachment file : [SELECT Name, Body, contentType FROM Attachment]){
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(file.Name);
                efa.setBody(file.Body);
                efa.setContentType(file.ContentType);
                attachments.add(efa);
            }
       		message.setFileAttachments(attachments);*/
            Messaging.SendEmailResult[] result = Messaging.sendEmail(new List<Messaging.Email> {message});
            if(result[0].Success){
                System.debug('Email Send SuccessFully');
            }else{
                System.Debug('Error : '+result[0].errors[0].message);
            }
        }catch(Exception e){
            ApexPages.Message errorMessage =  new ApexPages.Message(ApexPages.Severity.WARNING,'Input Email Address');
            ApexPages.addMessage(errorMessage);
        }
        pageReference pg = new pageReference('/apex/student_email');
        pg.setRedirect(true);
        return pg;        
    }
    public class StudentWrapperClass{
        public Student__c student{get;set;}
        public Boolean isChecked{get;set;}
    }
}