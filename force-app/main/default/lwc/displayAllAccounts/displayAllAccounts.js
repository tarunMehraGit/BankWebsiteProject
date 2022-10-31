import { LightningElement, wire , track } from 'lwc';
import getAccountSearchingRecord from '@salesforce/apex/displayAllAccountsController.getAccountSearchingRecord';
import editRecord from '@salesforce/apex/displayAllAccountsController.editRecord';
import deleteRecord from '@salesforce/apex/displayAllAccountsController.deleteRecord';
import fatchRecord from '@salesforce/apex/displayAllAccountsController.fatchRecord';
import {fireEvent , registerListener, unregisterListener} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class DisplayAllAccounts extends LightningElement {

    @wire(CurrentPageReference) pageRef;

    Id;
    searchValue = '' ;   
    error;
    deleteId; 
    allAccountList = [];
    details = {};
    isPopup;
    loader;
    
    connectedCallback() {
        this.doSearch();
    }

    

    // Method For get Search value
    search(event) {
        this.searchValue = event.target.value;
    }

    // Method For Search Account Record
    doSearch() {
        this.loader = true;
        getAccountSearchingRecord({ searchkey: this.searchValue })
            .then(result => {
                this.loader = false;
                this.allAccountList = result;
            })
            .catch(error => {
                this.loader = false;
                this.error = error;
                console.log('Error' + error);
            });
    }

    // Method of detail Button
    detailButton(event) {
       this.Id = event.target.value;
       fatchRecord({id : this.Id}).then(result=>{
            this.details = result;
             var data = {
                id     : result.Id,
                name   : result.Name,
                rating : result.Rating,
                email  : result.Email__c,
                phone  : result.Phone
                //contactName : result.contactFull_Name__c
            }
           // console.log('Name : ' + contactName);
            fireEvent(this.pageRef,"detailButton",data)

        }).catch(error=>{
            console.log('!! '+JSON.stringify(error));
        });   
    }

    // Method for delete Record
    deleteButton(event){
        this.isPopup = true;
        this.deleteId = event.target.name;
    }

    confirm(event){
        //this.loader = false;
        deleteRecord({delId : this.deleteId})
        .then(result =>{
            this.loader = true;
            this.allAccountList = result;
            this.isPopup = false;
            this.loader = false;

        }).catch(error => {
             this.loader = false;
            console.log("Error : "+JSON.stringify(error));
        });
    }

    closeModel(){
        this.isPopup = false;
        //this.isView = true;
    }

    disconnectedCallBack(){
        unregisterAllListeners(this);
    }

}