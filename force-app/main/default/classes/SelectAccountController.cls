public class SelectAccountController {

    public SelectAccountController(){

    }

    @AuraEnabled 
    public static List<Contact> getContactList(Id recordId){
        return [SELECT Id, Name,Phone ,Email FROM Contact WHERE AccountId =: recordId];
    }
}