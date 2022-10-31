public class DailyPriceMovement {
    
    //public List<DailyPriceMovement__c> priceMovementList;
    public List<DailyPriceMoveMentWrapperClass> priceMovementList;
    public DailyPriceMovement(){
        priceMovementList = new List<DailyPriceMoveMentWrapperClass>();
        /*for(DailyPriceMovement__c d : priceMovementList){
            DailyPriceMoveMentWrapperClass priceObj = new DailyPriceMoveMentWrapperClass();
        }*/
        priceMovementList.add(new DailyPriceMoveMentWrapperClass());
    }
    
    @AuraEnabled(cacheable=true)
        public static List<DailyPriceMovement__c> getDailyPriceList(){
             List<DailyPriceMovement__c> priceList = [SELECT Id, Name, Price__c, Commudity__c, Date__c FROM
                                                      DailyPriceMovement__c];
        return priceList;
    }
    
    public class DailyPriceMoveMentWrapperClass{
        public Date Today;
        public Date Yesterday;
        public Date OneWeekAgo;
        public Date MonthStarting;
        public Date ThreeMonthsAgo;
        public DailyPriceMovement__c priceMovement;
    }
}