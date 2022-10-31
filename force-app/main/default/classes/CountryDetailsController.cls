public class CountryDetailsController {
	
    public CountryDetailsController(){
        
    }	
    
    @AuraEnabled(cacheable=true)
    public static List<Country_Details__c> getCountryRecords(){
        
        return [SELECT Id, Name, Capital__c, Continent__c, President_Name__c, Population__c
                FROM Country_Details__c where Id != NULL];
    }
}