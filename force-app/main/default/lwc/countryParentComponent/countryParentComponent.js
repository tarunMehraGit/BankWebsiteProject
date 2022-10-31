import { LightningElement ,wire,track} from 'lwc';
import getCountryRecords from '@salesforce/apex/CountryDetailsController.getCountryRecords';
export default class CountryParentComponent extends LightningElement {

    countryDetails = [];

    @wire(getCountryRecords)
    getCountryList(result){
        console.log('Result : ',result);
        if(result.data){
            this.countryDetails = result.data;
        }
    }

}