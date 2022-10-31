import { LightningElement, wire, api, track } from 'lwc';
import getAccountRecord from '@salesforce/apex/RelatedContact.getAccountRecord'
export default class RelatedContactOfAccount extends LightningElement {

    @track accountList = [];
    isShow = '';

    connectedCallback() {
        //this.doExpend();
    }

    @wire(getAccountRecord)
    wiredContacts({ error, data }) {
        if (data) {
            this.accountList = data;
            console.log('Result : ', this.accountList);
        } else if (error) {
            console.log('Error', error);
        }
    }

    doExpend() {

        this.isShow = true;
    }
    doCollapse() {
        //this.accountList = [];
        this.isShow = false;
    }
}