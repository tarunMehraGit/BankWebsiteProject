public class SendEmailController {
    public String toAddress{get;set;}
    public String ccAddress{get;set;}
    public String bccAddress{get;set;}
    public String subject{get;set;}
    public Boolean isChecked{get;set;}
    public String body{get;set;}
    public SendEmailController(){
        
    }
    public pageReference sendEmail(){
    	Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(new List<String> {toAddress});
        try{
            if(!String.isBlank(ccAddress) || (!String.isBlank(bccAddress))){
                message.setCcAddresses(new List<String> {ccAddress});
                message.setBccAddresses(new List<String> {bccAddress});
            }
            message.setSubject(subject);
            if(isChecked){
                message.setHtmlBody(body);
            }else{
                message.setPlainTextBody(body);
            }
            Messaging.SendEmailResult[] result = Messaging.sendEmail(new List<Messaging.Email> {message});
            if(result[0].Success){
                System.Debug('Email Send SuccessFully');
            }else{
                System.Debug('Error : '+result[0].errors[0].message);
            }
        }catch(Exception e){
           ApexPages.Message errorMessage =  new ApexPages.Message(ApexPages.Severity.WARNING,'Input Email Address');
           ApexPages.addMessage(errorMessage);
       }
       pageReference pg = new pageReference('/apex/send_email');
       pg.setRedirect(true);
       return pg;
    }
}