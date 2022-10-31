import { LightningElement } from 'lwc';


export default class CarRental extends LightningElement {
    isCheck;

    balenoBookButton(event){
        console.log('Called');
        this.isCheck = true;
    }
    cancelButton(){
        this.isCheck = false;
    }
}