import { LightningElement, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import googleTranslateCallout from "@salesforce/apex/GoogleTranslateHelper.googleTranslateCallout";

export default class GoogleTranslateComp extends LightningElement {

  text = "";
  @track translatedText;
  get options() {
    return [
      { label: 'Hindi', value: 'hi' },
      { label: 'English', value: 'En' },
      { label: 'Gujarati', value: 'gujarat' },
      { label: 'Punjabi', value: 'pa' },
      { label: 'Russian', value: 'rus' }
    ];
  }

  populateText(event){
    this.text = event.detail.value;
  }

  handleChange(event){
    this.value = event.detail.value;
  }

  translate() {
    console.log('Text : '+this.text);
    console.log('Value : '+this.value);

    if (this.text) {
      googleTranslateCallout({ word: this.text, target: this.value }).then(result => {
        console.log('Result : ',result);
        if (result != null && result != undefined && result != '') {
          //let dataClone = JSON.parse(JSON.stringify(result.translatedText));
          //let language = JSON.parse(JSON.stringify(result.language));

          console.log('language : ', result.translatedText);
          this.translatedText =  result.translatedText;
        }
      }).catch(error => {
        const event = new ShowToastEvent({
          title: "Error!",
          message: "Something went wrong and we could not translate the texts."
        });
        this.dispatchEvent(event);
      });
    }
  }
}