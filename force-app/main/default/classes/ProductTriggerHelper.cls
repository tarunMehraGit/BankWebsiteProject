public class ProductTriggerHelper {
	
    public static void createChildRecord(List<Product2> productList){
        
        Id productBikeRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Bike').getRecordTypeId();
        Id productCarRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Car').getRecordTypeId();
        Id productScooterRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Scooter').getRecordTypeId();
        
        List<Required_Parts__c> requiredPartsList = new List<Required_Parts__c>();
        Map<String,List<Motors__mdt>> motorsMap = new Map<String,List<Motors__mdt>>();
        
        for(Motors__mdt mdt : [SELECT Id, MasterLabel, Motor_Types__c, Cost__c FROM Motors__mdt]){
            if(motorsMap.containsKey(mdt.Motor_Types__c)) {
                motorsMap.get(mdt.Motor_Types__c).add(mdt);
            } else {
                motorsMap.put(mdt.Motor_Types__c, new List<Motors__mdt>{mdt});
            } 
        }        
        
        for(Product2 product : productList){
            if(product.RecordTypeId == productBikeRecordTypeId) {
                for(Motors__mdt mdt : motorsMap.get('Bike')) {
                    requiredPartsList.add(new Required_Parts__c(Name = mdt.MasterLabel, Cost__c = mdt.Cost__c, Product__c = product.Id));
                }
            }
            else if(product.RecordTypeId == productCarRecordTypeId) {
                for(Motors__mdt mdt : motorsMap.get('Car')) {
                    requiredPartsList.add(new Required_Parts__c(Name = mdt.MasterLabel, Cost__c = mdt.Cost__c, Product__c = product.Id));
                }
            }
            else{
                for(Motors__mdt mdt : motorsMap.get('Scooter')) {
                    requiredPartsList.add(new Required_Parts__c(Name = mdt.MasterLabel, Cost__c = mdt.Cost__c, Product__c = product.Id));
                }
            }
            
        }
        if(requiredPartsList.size() > 0){
            INSERT requiredPartsList;
        }  
    }
    
    public static void fetchPrice(List<Product2> productList){
        List<Product2> newProductList = new List<Product2>();
        for(Product2 product : [SELECT Id, Name, Total_Price__c FROM Product2]){
            for(Required_Parts__c req : [Select Id,Name,Cost__c FROM Required_Parts__c]){
               product.Total_Price__c += req.Cost__c;
               newProductList.add(product); 
            }
         	//product.Total_Price__c += product
        }
        System.debug('newProductList : '+ newProductList);
        if(newProductList.size() > 0){
            INSERT newProductList; 
        }
        
    }
}