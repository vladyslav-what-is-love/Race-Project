public class WeatherResult {
    @AuraEnabled(Cacheable=true)
    public static void getWeather(Id recordId){
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://avenga-school.herokuapp.com/weather');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('trackName', 'recordId');
        String str = null;
        
        Http http = new Http();
     
        HttpResponse resp = http.send(req);
            //System.debug(resp.toString());
            //System.debug('STATUS'+resp.getStatus());
            //System.debug('STATUS_CODE'+resp.getStatusCode());
        
       
        if(resp.getStatusCode()==200){
            str = resp.getBody();
           
        }
        System.debug(str);
    }
    /*public static string LWCRestMethod(){
		HttpRequest httpRequest = new HttpRequest();
		httpRequest.setEndpoint('https://avenga-school.herokuapp.com/retrieve-data');
        httpRequest.setHeader('projectName', 'Totalizator');
        httpRequest.setHeader('Content-Type', 'application/json');
		httpRequest.setMethod('GET');
		String strResponse = null;
		try{
			Http http = new Http();
			HttpResponse httpResponse = http.send(httpRequest);
			if (httpResponse.getStatusCode() == 200){
				strResponse = httpResponse.getBody();
			} else{
				throw new CalloutException(httpResponse.getBody());
			}

		} catch (Exception ex){
			throw ex;
		}
		if (!String.isBlank(strResponse)){
			return strResponse;
		} else{
			return null;
		}
	}*/
}
