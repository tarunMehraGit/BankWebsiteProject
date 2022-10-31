import { LightningElement,api,track } from 'lwc';
import uploadFile from '@salesforce/apex/UploadFileController.loadData';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class XmlConversionComp extends LightningElement {

    @api recordId;
    @track fileData = [];
    @track readyState = '';
    @track status = '';
    get acceptedFormats(){
        return ['.xml'];
    }
    openfileUpload(event) {
        const uploadedFiles = event.detail.files;
        console.log('GET files : - ',uploadedFiles);
        
        let uploadedFileNames = '';
        let fileValue = '';
        for(let i = 0; i < uploadedFiles.length; i++) {
            // fileValue += uploadedFiles[i].value;
            uploadedFileNames += uploadedFiles[i].name + ', ';
            //this.recordId = uploadedFiles[i].documentId;
        }
        //console.log('recordid : ',this.recordId );
        //c/avatarUploadconsole.log('FileValue : ',fileValue);
        //this.loadXMLDoc(uploadedFiles[0]);
        uploadFile({ uploadData : uploadedFiles}) 
        .then(result => {
            console.log('Data ##: ',result);
			//this.fileData = result;
			//console.log('Data : ',this.fileData);
		})
		.catch(error => {
			console.log('Error : ',error);
		})

        let title = `${uploadedFileNames} uploaded successfully!!`
        this.toast(title);


    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title, 
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }

//     loadXMLDoc(file){
//     console.log('file  :-  ',file);
//         // let file = this.uploadedFiles[index];
// try {
//     let blob = new Blob([new Uint8Array(file)], {type: 'text/xml' });
//     console.log(blob);
//     let fileReader = new FileReader();
//         console.log('fileReader  :-  ',fileReader);
//         fileReader.addEventListener("loadend", () => {
//             console.log('test');
//             console.log('fileReader.result  :-  ',fileReader.result);
//             let fileContents = fileReader.result;
//             console.log('fileContents  :-  ',fileContents);
//             // let base64 = 'base64,';
//             // let content = fileContents.indexOf(base64) + base64.length;
//             // fileContents = fileContents.substring(content);
//             // self.uploadProcess(index, fileContents);
//             // let strjson = xml2json.fromStr(fileContents, 'string');
//            // console.log(strjson);
//         });
//         fileReader.readAsText(blob);
// } catch (error) {
//     console.log('error  :-  ',error);
// }
        

    // fileData(xml){
    //     console.log('fileData Called...');
    //     let i;
    //     let table = '';
    //     // let title = '';
    //     let xmlDoc = xml.responseXML;
    //     let x = xmlDoc.getElementsByTagName("Book"); 
        
    //     for(let i = 0; i < x.length ; i++){
    //         table += x[i].getElementsByTagName("author")[0].childNodes[0].nodeValue +
    //         x[i].getElementsByTagName("title")[0].childNodes[0].nodeValue  ;
    //     }
    //     console.log('table Data : ',table);
    // }
}