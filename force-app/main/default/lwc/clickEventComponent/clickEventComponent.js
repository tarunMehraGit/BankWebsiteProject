import { LightningElement } from 'lwc';

export default class ClickEventComponent extends LightningElement {
    name; nameValue;
    age; ageValue;
    changeHandler(event){
        this.nameValue = event.target.value;
        //this.ageValue = event.target.value;
    }
    changeAge(event){
        this.ageValue = event.target.value;
    }
    clickHandler(event){
        this.name = this.nameValue;
        this.age = this.ageValue;
    }
}