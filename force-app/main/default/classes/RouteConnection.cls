@RestResource(urlMapping='/getLeadinfo/*')
global class RouteConnection {
	
    @HttpPost
    global static Lead getLead(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
    	String urlId = req.requestURI.subString(req.requestURI.lastindexof('/')+1);
        System.debug('Id : ' + urlId);
		Lead ld = [SELECT id , Name from Lead where id =: urlId];
		return ld;        
    }
}