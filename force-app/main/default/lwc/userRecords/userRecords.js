import { LightningElement, wire, track, api } from 'lwc';
import getUserRecords from '@salesforce/apex/UserRecordsController.getUserRecords';
export default class UserRecords extends LightningElement {

    @track userRecords = [];
    usersList = [];
    @api progress = ''; 

    @wire(getUserRecords)
    getUsersList(result) {
        this.usersList = result;
        if (result.data) {
            let users = [];
            result.data.forEach(element => {  
                let user = Object.assign({}, element); 
                user.progress = parseInt(((element.completedTaskCount / element.taskCount) * 100));
                users.push(user);
            });
            this.userRecords = users;
        }
        else if (result.error) {
            console.log('error' + result.error);
        }
    }

    // This method for search users.
    handleSearch(event) {
        let searchKey = event.target.value;
        if (this.usersList.data.length > 0 && searchKey != '') {
            this.userRecords = this.usersList.data.filter((record) => {
                return record.userObj.Name.toLowerCase().includes(searchKey.toLowerCase());
            });
        }
        if (searchKey == '') {
            this.userRecords = this.usersList.data;
        }
    }

    // this method for showing if record not available 'Record Not Found'.
    get isRecord() {
        return (this.userRecords.length);
    }

}