public class ContactTriggerHelper {
    
    public static void isBeforeInsert(List<Contact> contactNewList){
        for(Contact contactObj : contactNewList){
            if(contactObj.Designation__c == 'Clerk'){
                if((contactObj.Salary__c <= 5000) || (contactObj.Salary__c >= 15000)){
                    contactObj.Salary__c.addError('Please Fill salary According to Designation');
                }
            }else if(contactObj.Designation__c == 'Manager'){
                if((contactObj.Salary__c <= 12000) || (contactObj.Salary__c >= 50000)){
                    contactObj.Salary__c.addError('Please Fill salary According to Designation');
                }
            }else if(contactObj.Designation__c == 'Accountant'){
                if((contactObj.Salary__c <= 10000) || (contactObj.Salary__c >= 30000)){
                    contactObj.Salary__c.addError('Please Fill salary According to Designation');
                }
            }else if(contactObj.In_Active__c != Null){
                contactObj.Active__c = true;
            }
        }
    }
    
    public static void isBeforeUpdate(List<Contact> contactNewList, Map<Id, Contact> contactOldMap){
        for(Contact contactRecord : contactNewList){
            if(contactRecord.Passed_to_Divvy__c && contactOldMap.get(contactRecord.Id).Passed_to_Divvy__c != contactRecord.Passed_to_Divvy__c){
                contactRecord.Time_Stamp_For_Passed_To_Divvy__c = DateTime.now();
            }else if(contactRecord.In_Active__c != Null && contactOldMap.get(contactRecord.Id).In_Active__c != contactRecord.In_Active__c){
                contactRecord.Active__c = true;
            }else if(contactRecord.In_Active__c == Null){
                contactRecord.Active__c = false;
            }
        }
    }
    
    public static void isAfterInsert(List<Contact> contactNewList){
        Account accountRecord = new Account();
        Opportunity opportunityRecord = new Opportunity();
        List<Account> accountList = new List<Account>();
        //Map<Id,Contact> contactMap = new Map<Id,Contact>(contactNewList);
        
        List<Opportunity> opportunityList = new List<Opportunity>(); //[SELECT Id,DeliveryInstallationStatus__c FROM Opportunity WHERE ContactId IN : contactMap.keySet()];
        
        for(Contact contactRecord : contactNewList){
            if(contactRecord.Level__c == 'Secondary'){
                accountRecord.Id = contactRecord.AccountId;
                accountRecord.CustomerPriority__c = 'High';
                opportunityRecord.Name = 'test Opportunity';
                opportunityRecord.StageName = 'Prospecting';
                opportunityRecord.CloseDate = Date.today().addDays(5);
                opportunityRecord.DeliveryInstallationStatus__c = 'Yet to begin';
                accountList.add(accountRecord);
                //opportunityList.add(opportunityRecord);
            }
        }
        if(!accountList.isEmpty()){
            UPDATE accountList;
        }
        /*if(opportunityRecord != null){
INSERT opportunityRecord;
}
System.debug('@@ Insert Opportunity : '+opportunityRecord);*/
    }
    
    public static void isAfterUpdate(List<Contact> contactNewList, Map<Id, Contact> contactOldMap){
        List<Account> accountList = new List<Account>();
        //List<>
        for(Contact contactRecord : contactNewList){
            if(contactRecord.Level__c == 'Secondary' && contactOldMap.get(contactRecord.Id).Level__c != contactRecord.Level__c){
                Account accountRecord = new Account();
                accountRecord.Id = contactRecord.AccountId;
                accountRecord.CustomerPriority__c = 'High';
                accountList.add(accountRecord);
            }
        }
        if(!accountList.isEmpty()){
            UPDATE accountList;
        }
    }
}