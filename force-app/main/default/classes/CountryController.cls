Public class CountryController {
    public String countryValue{get;set;}
    public String stateValue{get;set;}
    public String cityValue{get;set;}
    public Decimal pin{get;set;}
    public List<String> countryNameList{get;set;}
    public List<Country__c> countryList{get;set;}
    List<SelectOption> countryOption;
    public List<SelectOption> stateOption; 
    public List<SelectOption> cityOption;
    public Map<String,Map<String,List<String>>> countryMap{get;set;}
    public Map<String,Decimal>  pinCodeMap{get;set;}
    
    Public CountryController(){
        countryNameList = new List<String>();
        countryList = [SELECT Name,State_Name__c,City_Name__c,Pincode__c FROM Country__c];
    	countryMap = new Map<String,Map<String,List<String>>>();
        pinCodeMap = new Map<String,Decimal>();
        for(Country__c country : countryList){
            pinCodeMap.put(country.city_name__c,country.Pincode__c);
            Map<String,List<String>> stateMap;
            List<String> cityList;
            if(countryMap.containsKey(country.Name.toUpperCase())){
                //System.debug('State'+countryMap);
                stateMap = countryMap.get(country.Name.toUpperCase());
                if(stateMap.containsKey(country.state_Name__c.toUpperCase())){
                    cityList = stateMap.get(country.state_Name__c.toUpperCase());
                }  
                else{
                    cityList = new List<String>();
                }    
            }
            else{
                stateMap = new Map<String,List<String>>();
                cityList = new List<String>();
            }
            cityList.add(country.city_Name__c);
            stateMap.put(country.state_Name__c.toUpperCase(),cityList);
            countryMap.put(country.Name.toUpperCase(),stateMap);
        	
            
        	
        }
         //countryNameList.addAll(countryMap.keyset());
             //System.debug('$$ '+countryNameList);
    }
    public List<SelectOption> getCountry(){
        countryOption = new List<SelectOption>();
        for(String countryName : countryMap.keySet()){
            countryOption.add(new SelectOption(countryName,countryName));
        }
        return countryOption;
    }
    public void showState(){
        stateValue = '';
        if(String.isBlank(countryValue)){
            stateOption.clear();
            cityOption.clear();
             pin = NULL;
        }else{
            stateOption = new List<SelectOption>();
            for(String stateName : countryMap.get(countryValue).keySet()){
                stateOption.add(new SelectOption(stateName,stateName));
            }
        }
    }
    public List<SelectOption> getStateOptionList(){
        return stateOption;  
    }
    public void showCity(){
        cityValue = '';
        if(String.isBlank(stateValue)){
            cityOption.clear();
            pin = NULL;
        }else{
            cityOption = new List<SelectOption>();
            for(String cityName : countryMap.get(countryValue).get(stateValue)){
                cityOption.add(new SelectOption(cityName,cityName));
            }
        }
    }
    public List<SelectOption> getCityOptionList(){
       return cityOption;
    }
    /*public void allValue(){
       countrySet.add(countryMap.get);
    }*/
    public void showPincode(){
        pin = pinCodeMap.get(cityValue);
        /*pin = '';
        for(Country__c countryObj : countryList){
            if(countryObj.City_Name__c == cityValue){
               pin = countryObj.Pincode__c+''; 
            }
        }*/
    }
}