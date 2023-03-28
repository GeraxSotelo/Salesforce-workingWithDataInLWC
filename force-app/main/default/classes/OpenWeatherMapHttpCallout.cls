public class OpenWeatherMapHttpCallout {
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getWeatherData(String zipCode) {
        final String COUNTRY_CODE = 'US';
        final String API_KEY = 'f16003cd089a546d06f14f17dda6df15';
        final String ENDPOINT = 'https://api.openweathermap.org/data/2.5/weather?zip=' +zipCode+ ',' +COUNTRY_CODE+ '&appid=' +API_KEY+ '&units=imperial';
        Map<String, String> dataMap = new Map<String, String>();

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();

        req.setEndpoint(ENDPOINT);
        req.setMethod('GET');
    
        res = http.send(req);

        if (res.getStatusCode() == 200) {
            String jsonResponse = res.getBody();
            dataMap = createDataMap(jsonResponse);

            return dataMap;
        } else{
            String msg = 'Please check zipcode or country';
            dataMap.put('error', msg);
            System.debug(msg);
            
            return dataMap;
        }
    }


    public static Map<String, String> createDataMap(String jsonString) {
        Map<String, String> dataMap = new Map<String, String>();

        Map<String, Object> stringToObjectMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        
        String name = (String)stringToObjectMap.get('name');
        dataMap.put('name', name);

        Map<String, Object> mainBodyMap = (Map<String, Object>)stringToObjectMap.get('main');
        Decimal temp = (Decimal)mainBodyMap.get('temp');
        Decimal tempMin = (Decimal)mainBodyMap.get('temp_min');
        Decimal tempMax = (Decimal)mainBodyMap.get('temp_max');
        dataMap.put('temp', String.valueOf(temp));
        dataMap.put('temp_min', String.valueOf(tempMin));
        dataMap.put('temp_max', String.valueOf(tempMax));

        List<Object> weatherList = (List<Object>)stringToObjectMap.get('weather');
        Map<String, Object> weatherMap = (Map<String, Object>)weatherList[0];
        String main = (String)weatherMap.get('main');
        String icon = (String)weatherMap.get('icon');
        String description = (String)weatherMap.get('description');
        dataMap.put('main', String.valueOf(main));
        dataMap.put('icon', String.valueOf(icon));
        dataMap.put('description', String.valueOf(description));

        return dataMap;
    }
}