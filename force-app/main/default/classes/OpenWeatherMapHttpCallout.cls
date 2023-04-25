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
        final String DATA_NAME = 'name';
        final String DATA_MAIN = 'main';
        final String DATA_ICON = 'icon';
        final String DATA_TEMP = 'temp';
        final String DATA_WEATHER = 'weather';
        final String DATA_TEMP_MIN = 'temp_min';
        final String DATA_TEMP_MAX = 'temp_max';
        final String DATA_DESCRIPTION = 'description';
        Map<String, String> dataMap = new Map<String, String>();
        Map<String, Object> stringToObjectMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        
        String name = (String)stringToObjectMap.get(DATA_NAME);
        dataMap.put(DATA_NAME, name);

        Map<String, Object> mainBodyMap = (Map<String, Object>)stringToObjectMap.get('main');
        Decimal temp = (Decimal)mainBodyMap.get(DATA_TEMP);
        Decimal tempMin = (Decimal)mainBodyMap.get(DATA_TEMP_MIN);
        Decimal tempMax = (Decimal)mainBodyMap.get(DATA_TEMP_MAX);
        dataMap.put(DATA_TEMP, String.valueOf(temp));
        dataMap.put(DATA_TEMP_MIN, String.valueOf(tempMin));
        dataMap.put(DATA_TEMP_MAX, String.valueOf(tempMax));

        List<Object> weatherList = (List<Object>)stringToObjectMap.get(DATA_WEATHER);
        Map<String, Object> weatherMap = (Map<String, Object>)weatherList[0];
        String main = (String)weatherMap.get(DATA_MAIN);
        String icon = (String)weatherMap.get(DATA_ICON);
        String description = (String)weatherMap.get(DATA_DESCRIPTION);
        dataMap.put(DATA_MAIN, String.valueOf(main));
        dataMap.put(DATA_ICON, String.valueOf(icon));
        dataMap.put(DATA_DESCRIPTION, String.valueOf(description));

        return dataMap;
    }
}