import { LightningElement } from 'lwc';
import createAccountRecord from '@salesforce/apex/CreateAccountController.createAccountRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CreateAccountRecordComp extends LightningElement {

    loader = false ;
    createRecord(){
        this.loader = true;
        let accountName = this.template.querySelector(".inputName").value;
        let accountWebsite = this.template.querySelector(".inputWebsite").value;
        let accountPhone = this.template.querySelector(".inputPhone").value;
    if(accountName != '' && accountWebsite != '' && accountPhone != ''){
       let accountObj = {
            'Name' : accountName,
            'Website' : accountWebsite,
            'Phone' : accountPhone
        };
        
        createAccountRecord ({ record : accountObj})
        .then(result =>{
            if(result == 'success'){
                this.loader = false;
                this.showToastMessage('Success', 'Record SuccessFully Created.!!' , 'success');
                accountName.value = '';
                accountWebsite = '';
                accountPhone = '';
            }
        }).catch(error => {
            this.showToastMessage('Error', error.body.message, 'error');
        })
    }
        else{
            this.loader = false;
            this.showToastMessage('Error', 'Please fill this field', 'error');
        }
    }
    
    showToastMessage(title, message, variant){
        const event = new ShowToastEvent({
            title: title,
            message: message ,
            variant: variant 
        });
        this.dispatchEvent(event);
    }
}