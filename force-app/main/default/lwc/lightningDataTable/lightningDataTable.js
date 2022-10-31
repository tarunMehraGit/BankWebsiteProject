import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getContactRecords from '@salesforce/apex/ContactSearch.getContactRecords';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const columns = [
    { label: "First Name", fieldName: "FirstName", editable: true, sortable: true },
    { label: "Last Name", fieldName: "LastName", editable: true },
    { label: "Account Name", fieldName: "AccountName", editable: true },
    { label: "Phone", fieldName: "Phone", editable: true },
    { label: "Email", fieldName: "Email", editable: true }
];

export default class LightningDataTable extends NavigationMixin(LightningElement) {

    contactList;
    columns = columns;
    saveDraftValues = [];
    isLoader;

    connectedCallback() {
        try {
            getContactRecords().then(result => {
                console.log('Result : ', result);
                if (result != null && result != undefined && result != '') {
                    let contactData = result;
                    contactData.forEach(record => {
                        if (record.AccountId) {
                            //record.recordLink = "/" + record.AccountId;  
                            record.AccountName = record.Account.Name;
                        }
                    });
                    this.contactList = contactData;
                    console.log('contactList : ', this.contactList);
                }
            })
        } catch (error) {
            console.log('@connectedCallback ERROR message : ' + error.message);
            console.log('@connectedCallback ERROR : ', error);
        } finally {
            console.log('@finally @connectedCallback are execute..');
        }
    }

    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(result => {
            console.log('OUTPUT : ',result);
            this.ShowToast('Success', 'Records Updated Successfully!', 'success', 'dismissable');
            this.saveDraftValues = [];
            //return this.refresh();
        }).catch(error => {
            console.log('Error --> ',error); 
            this.ShowToast('Error', 'Error updating or refreshing records', 'error' , 'dismissable');
        }).finally(() => {
            this.saveDraftValues = [];
        });

        /*console.log('contactDetails : ',JSON.stringify(contactDetails));

        await updateContacts({ data : JSON.stringify(contactDetails), contactId : this.recordId}).then(result => {
            //this.isLoader = false;
            console.log('Apex update result : ',JSON.parse(result)); 
            this.ShowToast('Success', 'Records Updated Successfully!', 'success', 'dismissable');
            return this.refresh();
        }).catch(error => {
            console.log('Error is ' + JSON.stringify(error));
            this.ShowToast('Error', 'Error updating or refreshing records', 'error', 'dismissable');
        });*/
    }

    ShowToast(title, message, variant, mode) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }

    async refresh() {
        await refreshApex(this.contactList);
    }
}