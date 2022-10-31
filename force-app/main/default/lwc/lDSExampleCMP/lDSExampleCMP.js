import { LightningElement, api} from 'lwc';
export default class LDSExampleCMP extends LightningElement {
    
    @api recordId;
    @api objectApiName;

    connectedCallback() {
        this.objectName = this.objectApiName;
    }
}