import { LightningElement , api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api allDetails;
    count = 0;
    cancelButton(event){
        this.allDetails = false;
    }
    addButton(event){
        if(this.count < 3){
            this.count++;
        }  
        const customEvent = CustomEvent('myevent',{
                detail : this.count
        });   
    
        this.dispatchEvent(customEvent);
    }
   
}