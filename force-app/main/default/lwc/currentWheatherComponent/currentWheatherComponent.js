import { LightningElement, track } from 'lwc';
import createWheaterApiRequest from '@salesforce/apex/WheatherApiController.createWheaterApiRequest'
export default class CurrentWheatherComponent extends LightningElement {

    @track submitButtonClass;
    @track showWheatherData;

    @track wheatherData;
    @track isLoader;

    @track description;
    @track main;

    constructor(){
        super();
        this.submitButtonClass = 'submit-button submit-button-disable';
    }

    getCityAndPincode(event){
        if(event.target.value){
            this.submitButtonClass = 'submit-button submit-button-enable';
        }else{
            this.submitButtonClass = 'submit-button submit-button-disable';
        }
    }

    handleClickSubmit(){
        this.isLoader = true;
        let inputValue;
        let pincode = this.template.querySelector('[data-id="pincode"]');
        let city = this.template.querySelector('[data-id="city"]');

        if(city && city.value != ''){
            inputValue = city.value;
        }else if(pincode && pincode.value != ''){
            inputValue = pincode.value
        }
        createWheaterApiRequest({ cityNameAndPinCode :  inputValue}).then(result=>{
            if(result != null && result != ''){
                console.log('Result : ',JSON.parse(result));
                let wheatherResult = JSON.parse(result);
                this.isLoader = false;
                this.showWheatherData = true;
                this.wheatherData = wheatherResult;

                this.description = this.wheatherData.weather[0].description;
                this.main = this.wheatherData.weather[0].main;

                console.log('temp : ',wheatherResult.weather[0].description);
            }else{
                this.showWheatherData = false;
            }
            

        }).catch(error=>{
            console.log('error : ',error);
        })

    }
}