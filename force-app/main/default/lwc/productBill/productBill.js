import { LightningElement , wire } from 'lwc';
import {fireEvent , registerListener, unregisterAllListeners} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class ProductBill extends LightningElement {

    @wire(CurrentPageReference) pageRef;

    count=0;
    temp = false;
    value=true;
    details=[];

    totalAmount=0;

    connectedCallback(){
        registerListener("addProduct",this.showData,this);
    }

    showData(data){
        
        this.temp = false;
        this.details.push(data);
        this.temp = true;
        //console.log('Price : ' , data.price);
        this.totalAmount += data.price;
        //console.log('Total Amount : ' , this.totalAmount);
        //console.log('Data Bill  : ' + JSON.stringify(this.details));
    }

    handleEdit(event){
        //alert('Method Called.....');
        //console.log('$$' + this.value);
        fireEvent(this.pageRef,"recieveBillData", this.details);
    }

    disconnectedCallBack(){
        unregisterAllListeners(this);
    }
}