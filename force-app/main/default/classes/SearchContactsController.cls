/*
Name		 :  SearchContactsController
Date		 :  17 May, 2021
Author		 :  Tarun Mehra
Description  :  This apex class is use for display records of contact object.You can search record 
				of contact object using this apex class and you also can select the size of records
				how many display at a time like	{5,10,15,20..All}... 	
*/

public class SearchContactsController {
    public List<Contact> contactList {get; set;} 
    public List<Contact> allContactList {get; set;}
    public String  searchValue {get; set;}
    public Integer pageSize {get; set;} 
    public Integer start {get; set;}
    public Integer endIndex {get; set;} 
    public SearchContactsController(){
        pageSize = 5;
        start = 0; 
        contactList = new List<Contact>();
        doSearch(); 
    }
    
    // Method for Search contacts
    public void doSearch(){
        pageSize = 5;
        //start = 0;
        String query = 'SELECT Id, Name, Email, Phone, Account.Name, Type__c FROM Contact';
        if(String.isNotBlank(searchValue)){
            query += ' WHERE Name LIKE \'%' + searchValue + '%\' or Email LIKE \'%' + searchValue + '%\' ';
        }
        contactList = database.query(query);
        selectList();
    }
    
    // Method for select PageSize on UI     
    public List<SelectOption> getOptions(){
        List<SelectOption> listoptions = new List<SelectOption>();
        listoptions.add(new SelectOption('0', 'All'));
        listoptions.add(new SelectOption('5', '5'));
        listoptions.add(new SelectOption('10', '10'));
        listoptions.add(new SelectOption('15', '15'));
        listoptions.add(new SelectOption('20', '20'));
        return listoptions;
    }
    
    // Method for add List And Select PageSize
    public void selectList(){
        Integer num = 0;
        allContactList = new List<Contact>();
        if(pageSize == 0){
            start = 0;
            allContactList.addAll(contactList);
            endIndex = contactList.size(); 
        }else{
            start = 0;
            pageSize = pageSize > contactList.size() ? contactList.size() : pageSize;
            for(num = 0 ; num < pageSize; num++){
                allContactList.add(contactList[num]); 
            }
            endIndex = num;
        }
    }
    
    // Method for First Button
    public void first(){
        allContactList = new List<Contact>(); 
        start = 0;
        endIndex = pageSize > contactList.size() ? contactList.size() : pageSize;
        for(Integer i = 0; i < endIndex ; i++){
            allContactList.add(contactList[i]);
        }
    }
    
    // Method for Previous Button
    public void previous(){
        Integer i = 0; 
        allContactList = new List<Contact>();
        endIndex = start;  
        start = (start - pageSize) < 0 ? 0 : (start - pageSize);
            for(i = start ; i < endIndex ; i++){
                allContactList.add(contactList[i]);
            }
    }
    
    // Method for Next Button
    public void next(){
        Integer num;
        allContactList = new List<Contact>();
        start = endIndex; 
        endIndex = (pageSize + endIndex) > contactList.size() ? contactList.size() : (pageSize + endIndex);
            for(num = start ; num < endIndex ; num++){
                allContactList.add(contactList[num]);
            }
        endIndex = num; 
    }
    
    // Method for Last Button
    public void last(){ 
        integer i;
        allContactList = new List<Contact>();
        Integer reminder = math.mod(contactList.size(), pageSize);
        start = reminder == 0 ? contactList.size() - pageSize : contactList.size() - reminder; 
        endIndex = contactList.size(); 
        for(i = start; i < contactList.size() ; i++){ 
            allContactList.add(contactList[i]);
        }
    }
}