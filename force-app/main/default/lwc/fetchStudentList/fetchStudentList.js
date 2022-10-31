import { LightningElement ,wire } from 'lwc';
import getStudentList from '@salesforce/apex/FetchStudentListController.getStudentList';
import editStudentRecord from '@salesforce/apex/FetchStudentListController.editStudentRecord';
import deleteRecord from '@salesforce/apex/FetchStudentListController.deleteRecord';
import cloneRecord from '@salesforce/apex/FetchStudentListController.cloneRecord';
import saveRecord from '@salesforce/apex/FetchStudentListController.saveRecord';
export default class FetchStudentList extends LightningElement {
    
    editId;
    getRecord = {};
    showModal; isView; isList = true;
    studentCloneId;
    @wire(getStudentList) getstudentList;

    newButton(event){
        this.showModal = true;
    }
    updateValue(event){
        this.getRecord = {...this.getRecord ,  [event.target.dataset.field] : event.detail.value };
    }
    editButton(event){
        this.editId = event.target.name;
            editStudentRecord({recordId : this.editId}).then(result => {
                this.getRecord = result; 
                this.showModal = true;
            }).catch(error => {
                console.log("!! : "+JSON.stringify(error));
            });        
    }
    saveRecord(event){
        saveRecord({student : this.getRecord,studentClone : this.studentCloneId}).then(result =>{
            this.getRecord = result;
            location.reload(); 
            this.showModal = false;
        }).catch(error => {
            console.log("!! : "+JSON.stringify(error));
        });        
    }
    deleteButton(event){
        this.editId = event.target.name;
        deleteRecord({deleteId : this.editId}).then(result =>{
            this.getRecord = result;
            location.reload(); 
        }).catch(error => {
            console.log("!! : "+JSON.stringify(error));
        });
    }
    viewButton(event){
        this.editId = event.target.name;
        editStudentRecord({recordId : this.editId}).then(result => {
            this.getRecord = result;
            this.isView = true;
            this.isList = false;
        }).catch(error => {
            console.log("!! : "+JSON.stringify(error));
        });        
    }
    cloneButton(event){
        this.studentCloneId = event.target.name;
        cloneRecord({cloneId : this.studentCloneId}).then(result =>{
            this.getRecord = result;
            this.showModal=true;
        }).catch(error => {
            console.log("!! : "+JSON.stringify(error));
        });    
    }
    backButton(event){
        this.isView = false;
        this.isList = true;
    }
    closeModel(event){
        this.showModal = false;
        this.isNew = false;
    }
}