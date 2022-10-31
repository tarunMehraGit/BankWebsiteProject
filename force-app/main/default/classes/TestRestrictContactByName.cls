@isTest
private class TestRestrictContactByName {
	
    @isTest static void TestContactWithInvalidNameNotInserted(){
   		
        String inputLastName = 'INVALIDNAME';
        Contact newContact = new Contact(LastName= inputLastName);	    
        
		Test.startTest();
        try{
            insert newContact;
        }
        catch (DmlException dmlEx) {
        	String expectedMessage = 'The Last Name "'+ newContact.LastName+'" is not allowed for DML';
            System.assertEquals(expectedMessage, dmlEx.getDmlMessage(0));
        }
        Test.stopTest();
    }
}