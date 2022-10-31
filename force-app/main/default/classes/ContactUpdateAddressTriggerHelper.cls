public class ContactUpdateAddressTriggerHelper {
    
    public static void updateAddresCount(List<Address__c> addressList){
        Account accountRecord = new Account();
        Set<Id> contactIds = new Set<Id>();
        for(Address__c address : addressList){
            contactIds.add(address.Contact__c);
        }
        
        Map<Id,Contact> contactMap = new Map<Id,Contact>([SELECT Id, Address_Count__c, AccountId,(SELECT id,Name, CreatedDate, isActive__c
                                                                                                  FROM Addresses__r WHERE isActive__c =: true)
                                                          FROM Contact WHERE Id IN : contactIds]);
        
        for(Contact contactRecord : contactMap.values()){
            for(Address__c addressRecord : contactRecord.Addresses__r){
                contactRecord.Address_Count__c = contactRecord.Addresses__r.size();
                accountRecord.Id = contactRecord.AccountId;
                accountRecord.Most_Recent_Address__c = addressRecord.Name;
                contactMap.put(contactRecord.Id, contactRecord);
            }
        }
        UPDATE accountRecord;
        
        if(contactMap.size() > 0){
            UPDATE contactMap.values();
        }   
    }
    
}