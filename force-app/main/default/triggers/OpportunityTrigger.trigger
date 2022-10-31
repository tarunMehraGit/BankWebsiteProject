trigger OpportunityTrigger on Opportunity (before insert,before update) {
    
    List<Opportunity> opportunityList = new List<Opportunity>();
    
    if(Trigger.isUpdate && Trigger.isInsert){
        for(Opportunity opp : Trigger.new){
            if(opp.StageName == 'Closed Won'){
                opportunityList.add(new Opportunity(Amount = 50));		
            	//opp.Amount = 50;
            }
        }
        
        if(opportunityList.size() > 0){
            upsert opportunityList;
        }
    }
    
}