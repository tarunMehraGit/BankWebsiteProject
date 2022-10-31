import { LightningElement,wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';

import CONTACT_OBJ from '@salesforce/schema/Contact';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
import CONTACT_Phone from '@salesforce/schema/Contact.Phone';
//import CONTACT_ACCOUNT from '@salesforce/schema/Contact.AccountId';

export default class FetchContactList extends LightningElement {

    contactList;

    @wire(getListUi, {
        objectApiName : CONTACT_OBJ,
        listViewApiName : "AllContacts",
        //sortBy:NAME_FIELD,
    })listview({ error, data}){
        if(data){
            this.contactList =  data.records.records;
            //console.log('&& ' + JSON.stringify(data));
            //console.log('## ' + this.contactList);
            //console.log('acc ' +data.records.records[0].fields.BirthDate.value);
        }else{
            console.log('$$ ' + error);
        }
    }
}