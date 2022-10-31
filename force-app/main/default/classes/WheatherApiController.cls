public class WheatherApiController {
	   
    @auraEnabled
    public static String createWheaterApiRequest(String cityNameAndPinCode){
        HttpRequest request = new HttpRequest();
        HttpResponse response = new  HttpResponse();
        Http http = new Http();
        
        String url = 'http://api.openweathermap.org/data/2.5/weather?q='+cityNameAndPinCode+'&units=metric&APPID=0863d9e2e02bd73b7fa83b83a9ca57e4';
        request.setEndpoint(url);
        request.setMethod('GET');
        
        response = http.send(request);
        
        System.debug('Wheather response : '+JSON.serialize(response.getBody()));
        System.debug('Wheather response : '+JSON.serialize(response.getStatusCode()));
        
        return response.getBody(); 
        
    }
}