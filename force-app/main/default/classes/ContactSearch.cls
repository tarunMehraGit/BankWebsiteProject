public class ContactSearch {
	
    public static List<Contact> searchForContacts(String lastName , String postalCode){
        List<Contact> contactList = [Select id, Name FROM Contact
                                    WHERE LastName =: lastName AND MailingPostalCode =: postalCode];
        return contactList;
    }
    
    @auraEnabled
    public static List<Contact> getContactRecords(){
        List<Contact> contactList = new List<Contact>();
        try{
            contactList = [SELECT Id, FirstName, LastName, Email, Phone, Account.Name FROM Contact];
        }Catch(Exception ex){
            System.debug('Exception : '+ex);
        }
        return contactList;
    }
    
    /*@auraEnabled
    public static String updateContacts(String data,String contactId){
        try{
            System.debug('@@ data '+data);
            System.debug('@@ contactId '+contactId);
            Contact contactRecord = new Contact();
            if(String.isNotBlank(data)){
                Map<String, Object> contactDataMap = (Map<String,Object>) JSON.deserializeUntyped(data);
                contactRecord.Id = contactId; //String.valueOf(contactDataMap.get('id'));
                contactRecord.LastName = String.valueOf(contactDataMap.get('name'));
                update contactRecord;
                System.debug('contactRecord --> '+contactRecord);
            }
            return JSON.serialize(contactRecord);
        }Catch(Exception ex){
            System.debug('The following exception has occurred: ' + ex.getMessage());
            return null;
        }
    }*/
}