@RestResource(urlMapping='/v1/BookManagement/')
global class BookManagement {
	
    @httpPost
    global static Book__c doCreateBookRecord(BookClass bookObject){
        Book__c book = bookObject.Book;
        try{
            Insert book;
        }catch(Exception e){
            System.debug('Exception : '+e);
        }
        return book;
    }
    
    global class BookClass{
        Book__c Book {get;set;}
    }
}