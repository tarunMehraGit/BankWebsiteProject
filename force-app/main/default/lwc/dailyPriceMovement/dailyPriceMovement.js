import { LightningElement , wire , track } from 'lwc';
import getDailyPriceList from '@salesforce/apex/DailyPriceMovement.getDailyPriceList';
export default class DailyPriceMovement extends LightningElement {

    @track dailyPriceList = [];

    @wire(getDailyPriceList)
    wiredDailyPriceData({error,data}){
        if(data){
            console.log('Data',data);
            this.dailyPriceList = data;
        }else if(error){
            console.log('Error : ',error);
        }
    }
}