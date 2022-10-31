import { LightningElement , api , wire} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
export default class ProgressIndicator extends LightningElement {
    @api recordId;
    type;
    name;
    @wire(getRecord, {
        recordId: '$recordId',
        fields : ['Project__c.Name', 'Project__c.Status__c']
    })projectDetails({error,data}){
        if(error){
            console.log('Error');
        }else if(data){
             console.log('data '+JSON.stringify(data));
            this.name = data.fields.Name.value;
            this.type = data.fields.Status__c.value;
             console.log('name '+this.name);
             console.log('status '+ this.type);
        }
    }

}