trigger ProductTrigger on Product2 (before insert, after insert, before update, after update) {

    ProductTriggerHelper productObject = new ProductTriggerHelper();
    
    if(Trigger.isAfter && Trigger.isInsert){     
          ProductTriggerHelper.createChildRecord(Trigger.New);
     }
    if(Trigger.isAfter && Trigger.isUpdate){
    	
        ProductTriggerHelper.fetchPrice(Trigger.new);
    }
    
}