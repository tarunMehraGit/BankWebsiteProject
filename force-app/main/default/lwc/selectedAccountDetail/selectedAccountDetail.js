import { LightningElement , api ,wire } from 'lwc';
import editRecord from '@salesforce/apex/displayAllAccountsController.editRecord';
import getContactList from '@salesforce/apex/SelectAccountController.getContactList'
import {fireEvent , registerListener, unregisterAllListeners} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class SelectedAccountDetail extends LightningElement {
    
    @wire(CurrentPageReference) pageRef;

    alldetails = [];
    showModal;
    Name;
    Email;
    Rating;
    Phone;
    contactLength;
    contactList = [];
    isView ;
    value;
    Id;
    
    connectedCallback(){
        registerListener("detailButton",this.showData,this);
    }
    
    showData(data){
        this.isView = true;
        this.Id     = data.id;
        this.Name   = data.name;
        this.Email  = data.email;
        this.Rating = data.rating;
        this.Phone  = data.phone;

        getContactList({recordId : this.Id})
        .then(result =>{
            this.contactList = result;
        })
        .catch(error =>{
            console.log('Error' , error);
        });
    }
    


    editButton(){ 
        this.showModal = true;
        this.isView = false;
    }
    
    updateButton(event){
        this.isView = false;
        this.Id = event.target.value;
        console.log('Id : ' + this.Id);
        const accountObject = this.template.querySelectorAll('.accountRecord'); 
        const record = {
            Id : this.Id,
            Name : accountObject[0].value,
            Phone : accountObject[1].value,
            Rating : accountObject[2].value,
            Email__c : accountObject[3].value 
        };
        editRecord ({accountRecord : record})
        .then(result =>{
           console.log('Success : ' + JSON.stringify(result));
           location.reload(); 
        })
        .catch(error =>{
            console.log('Error' , error);
        });
    }
    
    get ratingOptions(){
        this.value = this.Rating;
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }

    handleRating(event){
        this.value = event.detail.value;
    }

    closeModel(){
        this.showModal = false;
        this.isView = true;
    }

    disconnectedCallBack(){
        unregisterAllListeners(this);
    }

}