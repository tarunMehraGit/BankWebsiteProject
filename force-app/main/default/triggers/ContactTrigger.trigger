trigger ContactTrigger on Contact (before insert,before update, after insert, after update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContactTriggerHelper.isBeforeInsert(Trigger.New);
        }
        if(Trigger.isUpdate){
            ContactTriggerHelper.isBeforeUpdate(Trigger.New, Trigger.oldMap);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            ContactTriggerHelper.isAfterInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            ContactTriggerHelper.isAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
    
    /*List<Contact> newcontactList = [Select id, Email from Contact]; 
    Map<string,Contact> contactMap = new Map<string,Contact>();
    
    for(Contact con : newcontactList){
        contactMap.put(con.Email, con);
    }
    if(Trigger.isBefore){
        for(Contact con: Trigger.New){
            if(contactMap.containsKey(con.Email)){
                con.email.addError('Email already exists'); 
            }
        } 
    }*/
}