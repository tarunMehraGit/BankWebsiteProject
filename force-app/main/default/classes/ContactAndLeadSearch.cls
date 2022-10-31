public class ContactAndLeadSearch {
	
    public static List<List<SObject>> searchContactsAndLeads(String lastName){
        
       List<List<SObject>> searchList = [FIND : lastName IN ALL FIELDS 
                                        RETURNING Lead(Name) , Contact(FirstName,LastName)] ;
        
        return searchList;
    }
}