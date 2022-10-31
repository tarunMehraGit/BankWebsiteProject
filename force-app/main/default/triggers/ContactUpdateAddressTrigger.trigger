trigger ContactUpdateAddressTrigger on Address__c (after insert, after update, after delete) {
    /*if(Trigger.isAfter && Trigger.isInsert){
        List<Address__c> conList = trigger.new;
        for(Address__c con: conList){
            con.Name  = 'Test';
        }
        update conList;
    }*/
    
    if(Trigger.isAfter){
        if(Trigger.IsInsert || Trigger.IsUpdate){
            ContactUpdateAddressTriggerHelper.updateAddresCount(Trigger.New);
        }
       
       
        if(Trigger.isdelete){
            ContactUpdateAddressTriggerHelper.updateAddresCount(Trigger.Old);
        }
    }
}