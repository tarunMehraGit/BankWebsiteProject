public class PanCardValidationController {
    
    public static void isBeforeInsert(List<Pan_Card__c> panCardList){
        Set<Id> employeeIds = new Set<Id>();
        for(Pan_Card__c panCardRecord : panCardList){
            employeeIds.add(panCardRecord.Employee__c);
        }
        
        List<Pan_Card__c> panCardRecordList = [SELECT Id, Name, Employee__c FROM Pan_Card__c WHERE Employee__c IN : employeeIds];
        if(panCardRecordList.size() > 0){
            for(Pan_Card__c panCard : panCardList){ 
                panCard.addError('A PAN Card already exist for the employee !...');
            } 
        }
    }
}