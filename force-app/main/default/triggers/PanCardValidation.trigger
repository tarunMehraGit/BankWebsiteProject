trigger PanCardValidation on Pan_Card__c (before insert, Before Update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            PanCardValidationController.isBeforeInsert(Trigger.new);
        }
    }
}