import { LightningElement, wire, api} from 'lwc';
import getWeatherData from '@salesforce/apex/OpenWeatherMapHttpCallout.getWeatherData';
import { subscribe, MessageContext } from 'lightning/messageService';
import CONTACT_SELECTED_CHANNEL from '@salesforce/messageChannel/Contact_Selected__c';

export default class Weather extends LightningElement {
    contactZipCode;
    cityName;
    temperature;
    tempMin;
    tempMax;
    main;
    description;
    icon;
    imageUrl;

    @wire(MessageContext) messageContext;

    subscribeToMessageChannel() {
      this.subscription = subscribe(
        this.messageContext,
        CONTACT_SELECTED_CHANNEL,
        (message) => this.handleMessage(message)
      );
    }

    handleMessage(message) {
      console.log('message from subscription: ', message);
      this.contactZipCode = message.zipcode;
    }
    
    connectedCallback() {
      this.subscribeToMessageChannel();
    }

    @wire(getWeatherData, {zipCode : '$contactZipCode'})
    weatherData({data, error}){
        if (data) {
          console.log('weatherData: ', data);
          this.cityName = data.name;
          this.temperature = data.temp;
          this.tempMin = data.temp_min;
          this.tempMax = data.temp_max;
          this.main = data.main;
          this.description = data.description;
          this.icon = data.icon;
          this.imageUrl = 'http://openweathermap.org/img/w/'+data.icon+'.png'
        } else if (error) {
            console.log('error: ', error);
        }
    }
}