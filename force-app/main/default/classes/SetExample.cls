public class SetExample {
    public SetExample(){
        Set<String> citySet = new Set<String>();
        citySet.add('Ajmer');
 		citySet.add('Kota');
		citySet.add('Jaipur');
 		citySet.add('Nasirabad');
		citySet.add('Pali');        
        
        System.debug('Size Of Set : '+citySet.size());
        for(String city:citySet){
           System.debug('Cities : '+city); 
        }
        
        Set<String> newCitySet = new Set<String>{'Delhi'};
        Set<String> newCitySet2 = new Set<String>{'Mumbai'};
       	
        System.debug('Size : '+newCitySet.size());
        newCitySet2.addAll(newcitySet);
        newCitySet2.addAll(citySet);
        for(String newCity : newCitySet2){
            System.debug(' New Cities : '+newCity);
        }
        System.debug('New Size : '+newCitySet2.size());
       
    }
}