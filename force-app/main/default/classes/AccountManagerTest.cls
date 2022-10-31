@isTest
private class AccountManagerTest {
	
    @isTest 
    private static void testGetAccount(){
        Id RecordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri = 'https://na35.salesforce.com/services/apexrest/Accounts/'+RecordId+'/Contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
        
        System.assertEquals('Test record', thisAccount.Name);
        //System.assertEquals('test@yahoo.com', this.Account.Email__c);
    }
    
    static Id createTestRecord(){
        Account testAccount = new Account( Name = 'Test record', Email__c = 'test@yahoo.com');
        insert testAccount;
        Contact testContact = new Contact( FirstName = 'Salesforce Api' , LastName = 'Test', AccountId = testAccount.Id);
        insert testContact;
		return testAccount.Id;
    } 		
}

/*@isTest
private class AccountManagerTest
{
    @isTest static void testGetAccount ()
    {
        Id recordId = createTestRecord ();
        RestRequest request = new RestRequest ();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert (thisAccount != null);
        System.assertEquals ('Test Record', thisAccount.Name);

    }

    static Id createTestRecord ()
    {
        Account testAccount = new Account (Name = 'Test Record', Email__c = 'test@yahoo.com');
        insert testAccount;
        Contact testContact = new Contact (FirstName = 'Salesforce Api' , LastName = 'Test',AccountId = testAccount.Id);
        return testAccount.Id;
    }

}*/