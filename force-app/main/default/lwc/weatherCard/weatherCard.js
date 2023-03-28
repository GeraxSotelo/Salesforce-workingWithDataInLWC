import { LightningElement, wire, api} from 'lwc';
import getWeatherData from '@salesforce/apex/OpenWeatherMapHttpCallout.getWeatherData';

export default class WeatherCard extends LightningElement {
    @api contactZipCode;
    cityName;
    temperature;
    tempMin;
    tempMax;
    main;
    description;
    icon;

    @wire(getWeatherData, {zipCode : '$contactZipCode'})
    weatherData({data, error}){
        if (data) {
            this.cityName = data.name;
            this.temperature = data.temp;
            this.tempMin = data.temp_min;
            this.tempMax = data.temp_max;
            this.main = data.main;
            this.description = data.description;
            this.icon = data.icon;
            console.log('weather data: ', data);
            console.log('city name: ', this.cityName);
            console.log('data contactZipCode: ', this.contactZipCode);
        } else if (error) {
            console.log('error: ', error);
        }
    }

}