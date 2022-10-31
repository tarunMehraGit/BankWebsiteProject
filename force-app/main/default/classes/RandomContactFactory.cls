public class RandomContactFactory {
	
    public static List<Contact> generateRandomContacts(Integer noOfContactGenerated , String fName){
         List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < noOfContactGenerated ; i++){
            Contact contact = new Contact(FirstName = fName + ' ' + i , LastName = 'Contact '+i);
            contactList.add(contact);
            System.debug('Contact First Name : ' + contact);
        }
        
        return contactList;
    } 
}