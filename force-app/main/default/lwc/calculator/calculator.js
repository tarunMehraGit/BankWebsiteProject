import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
    firstNumber; secondNumber;
    result; text_color;
    show = true;
    getNumber(event){
        if((event.target.name) == "value1"){
            this.firstNumber = Number(event.target.value);
        }
        if((event.target.name) == "value2"){
            this.secondNumber  = Number(event.target.value);
            //alert(this.secondNumber);
        }
        if(this.firstNumber != 0 || this.secondNumber != 0){
            this.show = false;
        }else{
            this.show = true;
        }
    }
    calcButton(event){
        switch(event.target.value == 'all'){
            case (event.target.label) == 'Add' :
                this.result = this.firstNumber + this.secondNumber;
                this.text_color = 'slds-text-color_success';
                if(isNaN(this.result)){
                    this.result = 0;
                }
                break;
            case (event.target.label) == 'Subtract' :
                this.result = this.firstNumber - this.secondNumber;
                this.text_color ="slds-text-color_error";
                if(isNaN(this.result)){
                    this.result = 0;
                }
                break;
            case (event.target.label) == 'Multiply' : 
                this.result = this.firstNumber *  this.secondNumber;
                this.text_color="slds-text-color_success";
                if(isNaN(this.result)){
                    this.result = 0;
                }
                break;
            case (event.target.label) == 'Division' :
                this.result = this.firstNumber / this.secondNumber;
                this.text_color="slds-text-color_inverse-weak";
                if(isNaN(this.result)){
                    this.result = 0;
                }else if(this.secondNumber == 0){
                    this.result = 'Could Not Divisible by ZERO..';
                }
                break;
            case (event.target.label) == 'Modulas' :
                this.result = this.firstNumber % this.secondNumber;
                this.text_color="slds-text-color_inverse-weak";
                if(isNaN(this.result)){
                    this.result = 0;
                }
                break;
            case (event.target.label) == 'Clear' :
                this.firstNumber = '';
                this.secondNumber = '';
                this.result = '';
        }
    }
    /*calcButton(event){
        //alert(event.target.label);
        if(event.target.label == 'Add'){
            this.result = this.firstNumber + this.secondNumber;
            this.text_color = 'slds-text-color_success';
            if(isNaN(this.result)){
                this.result = 0;
            }
        }
        else if((event.target.label) == 'Subtract'){
            this.result = this.firstNumber - this.secondNumber;
            this.text_color ="slds-text-color_error";
            if(isNaN(this.result)){
                this.result = nhgy0;
            }
        }
        else if((event.target.label) == 'Multiply'){
            this.result = this.firstNumber * this.secondNumber;
            this.text_color="slds-text-color_success";
            if(isNaN(this.result)){
                this.result = 0;
            }
        }
        else if((event.target.label) == 'Division'){
            this.result = this.firstNumber / this.secondNumber;
            this.text_color="slds-text-color_inverse-weak";
            if(isNaN(this.result)){
                this.result = 0;
            }else if(this.secondNumber == 0){
                this.result = 'Could Not Divisible by ZERO..';
            }
        }   
        else if((event.target.label) == 'Modulas'){
            this.result = this.firstNumber % this.secondNumber;
            this.text_color = "slds-text-color_success";
            if(isNaN(this.result)){
                this.result = 0;
            }
        } 
        else if((event.target.label) == 'Clear'){
            this.firstNumber = '';
            this.secondNumber = '';
            this.result = '';
        }
    }*/
}