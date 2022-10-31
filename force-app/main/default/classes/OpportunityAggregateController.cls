public class OpportunityAggregateController {
    //public List<AggregateResult> opportunityAggregateList{get;set;}
    public List<Account> accountList{get;set;}
    public OpportunityAggregateController(){     
     	accountList = [select name, (select id, name from Opportunities)from Account];
 		       
 }
}