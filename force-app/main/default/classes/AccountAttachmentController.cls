public class AccountAttachmentController {
    public List<Account> accountList {get;set;}
    public AccountAttachmentController(){
        accountList = [select id, name, phone, email__c, (select id, Contenttype, Name from Attachments) from Account];
    }
}