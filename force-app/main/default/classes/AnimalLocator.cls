public class AnimalLocator {
	
    public static String getAnimalNameById(Integer id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);	
        request.setMethod('GET');
        String strRes = '';
        
        HttpResponse response = http.send(request);
         System.debug('****Response status: '+ response.getStatusCode());
        System.debug('****Response : '+ response.getBody());
        Map<String , Object> animal = new Map<String , Object>();
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            //System.debug('Body : '+results);
            animal = (Map<String, Object>) results.get('animal');
            //System.debug('Animal : '+animal);
            strRes =  string.valueof(animal.get('name'));
        }
        return strRes;
            //(String)animal.get('name');
    }
}