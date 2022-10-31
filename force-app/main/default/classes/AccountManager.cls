@RestResource(urlMapping='/Accounts/*/Contacts')
global with sharing class AccountManager {
	@HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        System.debug('URl : '+request);
        String accountId = request.requestURI.substringBetween('Accounts/','/Contacts');
        System.debug('Id : '+accountId);
        Account result = [SELECT Id ,Email__c, Name,(SELECT Id,Name FROM Contacts) FROM Account WHERE Id =: accountId];
        return result;
    }
}

/*@RestResource (urlMapping = '/Account/ /contacts')
global with sharing class AccountManager
{
    @HttpGet
    global static Account getAccount ()
    {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        //Account acct =  [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :accountId];
        Account acct = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        return acct;
    }
}*/