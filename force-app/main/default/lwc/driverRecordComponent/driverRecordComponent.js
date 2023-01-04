import { LightningElement, wire, api, track } from 'lwc';
import getWonResults from '@salesforce/apex/DriverRecordComponent.getWonResults';
//import getWeather from '@salesforce/apex/WeatherResult.getWeather';

export default class DriverRecordComponent extends LightningElement {
   
    @api recordId;
   // @track data;
  //  @track error;

    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Position', fieldName: 'Position__c', type: 'number'},
        { label: 'Grid', fieldName: 'Grid__c', type: 'number'}//,
       // { label: 'Weather', fieldName: 'Weather__c', type: 'number'}
    ];

    @wire(getWonResults, { recordId: '$recordId' }) drivers;
    
    get data(){
        if(this.drivers)
            return this.drivers.data;
        else
            return [];
    }

   // @wire (getWeather, { recordId: '$recordId' }) weather;

    /*connectedCallback() {
        getWeather(this.recordId).then(result => {
            this.data = JSON.parse(result);
        }).catch(error => {
            console.log(error);
        });
    }*/
}