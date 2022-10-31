@isTest
public class ContactUpdateAddressTriggerHelperTest {
    
    @isTest
    public static void updateAdressCountTest(){
        Test.startTest();
        Account acc = new Account(
            Name = 'AccountTest',
            Email__c = 'test@gmail.com'
        );
        Insert acc;
        
        Contact con = new Contact(
            LastName='bb', 
            Address_Count__c = 1,
            AccountId = acc.Id
        );
        Insert con;
        
        Address__c address = new Address__c(
            Name = 'Test',
            isActive__c = true,
            Contact__c = con.Id
        );
        Insert address;
        
        Test.stopTest();
    }
}