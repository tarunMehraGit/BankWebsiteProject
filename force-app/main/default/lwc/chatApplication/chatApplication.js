import { LightningElement, api, track, wire } from 'lwc';
import getContactDetails from '@salesforce/apex/chatApplicationController.getContactDetails';
import { publish, subscribe, unsubscribe, createMessageContext, releaseMessageContext } from "lightning/messageService";
import SAMPLEMC from "@salesforce/messageChannel/MyMessageChannel__c";

export default class ChatApplication extends LightningElement {

    context = createMessageContext();
    subscription = null;
    inputMessage = '';
    @api emojis; 
    @api contactId;
    @track messageList = [];
    @track contactList;

    connectedCallback() {
        this.subscribeMC();
    }

    @wire(getContactDetails, { recordId: '$contactId' })
    wiredContact({ error, data }) {
        if (data) {
            this.contactList = data.Name;
        }
        else if (error) {
            console.log('Error : ', error);
        }
    }

    getMessage(event) {
        this.inputMessage = event.target.value;
    }

    handleSearchInputKeyPress(event) {
       // var code = ('charCode' in event) ? event.charCode : event.keyCode;
        if(event.keyCode == 13){
            this.sendMessage();
        }
    }

    sendMessage() {
      const message = {
            mainMessage : this.inputMessage,
            sender : this.contactId,
            reciever : '',
            inboundMessage : false,
            outboundMessage : false
        };
        publish(this.context, SAMPLEMC, message);
        this.inputMessage = '';
    }

    handleEmojis(){
        this.emojis = {
            laugh : '😂',
            love : '🥰',
            heart : '💖',
            angry : '😤',
            sad : '😢'
        }
    }
    subscribeMC() {
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.context, SAMPLEMC, (message) => {
            this.displayMessage(message);
        });
        setTimeout(function() {
            this.scrollWin(); 
        }.bind(this), 500);
    }

    scrollWin() {
        let element = this.template.querySelector('.container');
        let height = element.scrollHeight + 200;
        element.scrollTop = height;
    } 

    
    displayMessage(message) {
        let newChatMessage = Object.assign({}, message);
        newChatMessage.reciever = this.contactId;
        if (newChatMessage.sender == this.contactId) {
            newChatMessage.inboundMessage = false;
            newChatMessage.outboundMessage = true;
        }
        else if(newChatMessage.reciever == this.contactId) {
            newChatMessage.outboundMessage = false;
            newChatMessage.inboundMessage = true;
        }
        this.messageList.push(newChatMessage);
    }
    
}