public class GoogleTranslateHelper { 
    
    @auraEnabled
    public static Object googleTranslateCallout(String word,String target){
        List<Object> responseList = new List<Object>();
        HTTPResponse resp = null;
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        
        req.setMethod('GET');
        req.setEndPoint('https://google-translate1.p.rapidapi.com/language/translate/v2');
        req.setHeader('X-RapidAPI-Host', 'google-translate1.p.rapidapi.com');
        req.setHeader('X-Rapidapi-Key', '926e88851emsh68e7b01a1ac54d7p1ccb00jsn0eac69d490db');
        String body = 'q=' + word + '&target='+ target;
        req.setBody(body);
        resp = http.send(req);
        System.debug('Response : '+resp.getBody());
        if(resp.getStatusCode() == 200){
            Map<String, Object> responseMap = (Map<String, Object>) System.JSON.deserializeUntyped(resp.getBody());
            if(responseMap.containsKey('data')){
                Map<String, Object> dataMap = (Map<String, Object>) responseMap.get('data');
                if(dataMap.size() > 0){
                    responseList = (List<Object>) dataMap.get('translations');
                }  
            }
        }
        System.debug('responseList : '+ responseList);
        return responseList.get(0);   
    }
}