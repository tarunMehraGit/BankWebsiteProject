import { LightningElement } from 'lwc';
import getContactSearchingList from '@salesforce/apex/SearchContactController.getContactSearchingList';

export default class SearchContacts extends LightningElement {

    loader;
    searchValue = '';
    pageSize = 5;
    totalRecords;
    startIndex;
    endIndex;
    allContactList = [];
    ContactList = [];

    connectedCallback() {
        this.doSearch();
    }

    handlePageSize(event) {
        this.pageSize = parseInt(event.target.value);
        this.selectList();
    }

    search(event) {
        this.searchValue = event.target.value;
    }

    //Method for Search Contact
    doSearch() {
        this.allContactList = [];
        this.loader = true;
        getContactSearchingList({ searchKey : this.searchValue })
            .then(result => {
                result.forEach(element => {
                    this.loader = false;
                    let contact = {
                        Name : element.Name ,
                        Email : element.Email,
                        AccountName : element.Account === undefined ? '' : element.Account.Name,
                        Phone : element.Phone,
                        Type : element.Type__c
                    };  
                    this.allContactList.push(contact);
                    this.selectList();
                });
                this.totalRecords = this.allContactList.length;
            }).catch(error => {
                this.loader = false;
                this.ContactList = [];
            });
    }

    // Method for Disply pageSize
    get options() {
        return [
            { label: "All", value: 0 },
            { label: "5" ,  value: 5 },
            { label: "10", value: 10 },
            { label: "15", value: 15 },
            { label: "20", value: 20 },
        ];
    }

    //Method for working pageSize
    selectList() {
        this.startIndex = 0;
        if (this.pageSize != 0) {
            this.endIndex = this.pageSize;
            this.fillContacts(this.startIndex, this.endIndex);
        } else {
            this.ContactList = this.allContactList;
            this.endIndex = this.totalRecords;
        }   
    }

    // Method For Display Data 
    fillContacts(start, End) {
        this.ContactList = [];
        this.allContactList.forEach((element, index) => {
            if(index >= start && index < End){
                this.ContactList.push(element);
            }
        });
    }

   // Method for First Button
    first() {
        this.startIndex = 0;
        this.fillContacts(0, this.pageSize);
        this.endIndex = this.pageSize;
    }

    // Method for next Button
    next() {
        this.startIndex = this.endIndex;
        var nextPageSize = parseInt(this.pageSize + this.endIndex);
        this.endIndex = nextPageSize > this.totalRecords ? this.totalRecords : nextPageSize;
        this.fillContacts(this.startIndex, this.endIndex);
    }

    // Method for Previous Button
    previous() {
        this.endIndex = this.startIndex;
        this.startIndex = (this.startIndex - this.pageSize) < 0 ? 0 : (this.startIndex - this.pageSize);
        this.fillContacts(this.startIndex, this.endIndex);
    }

    // Method for last Button
    last() {
        var reminder = (this.totalRecords % this.pageSize);
        this.startIndex = reminder == 0 ? this.totalRecords - this.pageSize : this.totalRecords - reminder;
        this.fillContacts(this.startIndex, this.totalRecords);
        this.endIndex = this.totalRecords;
    }

    // Method for Disable First & Previous Button
    get disableFirstPrevious() {
        return this.startIndex == 0 ? true : false;
    }

    // Method for disable Next & Last Button
    get disableNextLast() {
        return this.totalRecords == this.ContactList.length || this.endIndex == this.totalRecords ? true : false;
    }
}