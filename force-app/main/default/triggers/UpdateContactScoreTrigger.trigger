trigger UpdateContactScoreTrigger on Contact (after insert , after update, after delete, after undelete) {
    
     /*if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate) {
            UpdateContactScoreTriggerHelper.updateContactToAccountScore(Trigger.new);			    
        }
         
         if(Trigger.isDelete){
              UpdateContactScoreTriggerHelper.deleteContactToAccountScore(Trigger.Old);
         }
         
         if(Trigger.isUndelete){
         	  UpdateContactScoreTriggerHelper.unDeleteContactToAccountScore(Trigger.new);
         }
     }*/
}