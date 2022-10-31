import { LightningElement , wire } from 'lwc';
import {fireEvent, registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class PublisherComponent extends LightningElement {
    
    @wire(CurrentPageReference) pageRef;

    quantity;
    Product;
    productOptions;
    Price;
    allDetails={};
    isDisplay;

    //isShow;
    recieveValues = [];

    connectedCallback(){
        registerListener("recieveBillData",this.recieveData,this);
    }

    recieveData(value){
        //alert(value);
       
            this.recieveValues = value;
            console.log('Name : ', value.Name);
            
        //console.log('Data : ' + JSON.stringify(this.recieveValues));
    }

    handleProduct(event){ 
        this.Product = event.target.value;
        //console.log('Selected : ' + this.Product);
    }
    
    get QuantityOptions(){
        return [
            { label : 1 , value : 1 },
            { label : 2 , value : 2 },
            { label : 3 , value : 3 },
            { label : 4 , value : 4 },
            { label : 5 , value : 5 },
        ];
    }

    handleQuantity(event){
        
            this.quantity = JSON.parse(event.target.value);
        //console.log('Qunatity ' + this.quantity);
    }

    handlePrice(event){
        this.Price = event.target.value;
        //console.log('Price : ' + this.price);
    }
    

    data = [
        {
            "Laptop" : {
                'Name' : 'Laptop',
                'qty' :  this.quantity,
                'price' : this.Price,
            },
            "Keyboard" : {
                'Name' : 'Keyboard',
                'qty' : this.quantity,
                'price' : this.Price,
            },
            "Mouse" : {
                'Name' : 'Mouse',
                'qty' : this.quantity,
                'price' : this.Price,
            },
            "HeadPhones" : {
                 'Name' : 'HeadPhones',
                'qty' : this.quantity,
                'price' : this.Price,
            },
            "Speakers" : {
                'Name' : 'Speakers',
                'qty' : this.quantity,
                'price' : this.Price,
            }
        }
    ];

    get product(){
        this.productOptions = [];
        for(var product in this.data[0]){
            var obj={};
            obj.label = product;
            obj.value = product;
            this.productOptions.push(obj);
        }
        return  this.productOptions;
    }

    addProduct(event){

        this.data[0][this.Product].qty = this.quantity;
        this.data[0][this.Product].price = (this.Price * this.quantity);
        this.allDetails = this.data[0][this.Product];
        //console.log('All Details : ' , this.allDetails);
        fireEvent(this.pageRef,"addProduct",this.allDetails)

    }

    disconnectedCallBack(){
        unregisterAllListeners(this);
    }
}