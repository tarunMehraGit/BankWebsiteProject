import { LightningElement, api, track} from 'lwc';
import deleteRecord from '@salesforce/apex/UserRecordsController.deleteRecord';
import createTaskRecord from '@salesforce/apex/UserRecordsController.createTaskRecord';
import completeTask from '@salesforce/apex/UserRecordsController.completeTask';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
export default class UsersTaskModal extends LightningElement {

    @track tasks = [];
    @track usersList = [];
    @api taskRecord;
    isCompleted;
    status = '';
    subject = '';
    deleteId;
    @api showModal;
    ownerId;

    connectedCallback() {
        this.usersList = this.user.taskList;
    }

   // This method used for get userId.
    showTask(event) {
        this.showModal = true;
        this.ownerId = event.target.dataset.id;
        this.filterTasks();
    }


    //This method used for add color on completed tasks.
    filterTasks() {
        let data = JSON.parse(JSON.stringify(this.usersList));
        this.tasks = data;
        let tasksArr = [];
        this.tasks.forEach(element => {
            if (element.OwnerId == this.ownerId) {
                //element = JSON.parse(JSON.stringify(element));
                element.isCompleted = element.Status == 'Completed' ? false : true;
                element.isColor = element.Status == 'Completed' ? 'background-color:rgba(3, 194, 252,10)' : 'background-color:none';
                tasksArr.push(element);
            }
            this.tasks = tasksArr;
        });
        // this.tasks = tasksArr;
    }

    //This method used for get task subject.
    handleSubject(event) {
        this.subject = event.target.value;
    }

    //This method used for create tasks.
    handleTask(event) {
        this.status = 'Pending';
        this.Date = new Date().toLocaleString();
        createTaskRecord({ ownerId: this.ownerId, taskSubject: this.subject, status: this.status })
            .then(result => {
                if (this.subject != '') {
                    refreshApex(this.tasks);
                    this.dispatchEvent(
                        new ShowToastEvent({
                           // title: 'Success',
                            message: 'Task created sucessfully',
                            variant: 'success',
                        }),
                    );
                    setTimeout(() => {
                        this.filterTasks();
                    }, 1500);
                }
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }

    //This method used for manage tooltip.
    handleMouse() {
        ('[data-toggle="tooltip"]').tooltip();
    }

    //This method used for delete task record.
    deleteTaskRecord(event) {
        this.deleteId = event.target.name;
        deleteRecord({ delId : this.deleteId })
            .then(result => {
                this.taskRecords = result;
                refreshApex(this.tasks);
                this.dispatchEvent(
                    new ShowToastEvent({
                        //title: 'Success',
                        message: 'Record Is Deleted',
                        variant: 'success',
                    }),
                );
                this.showModal = false;

            }).catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error While Deleting record',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }

    statusChange(event) {
        let checkStatus = event.target.value;
        completeTask({ taskId: checkStatus })
            .then(task => {
                this.dispatchEvent(
                    new ShowToastEvent({
                       // title: 'Record',
                        message: 'Task Completed',
                        variant: 'success',
                    }),
                );

            }).catch(error => {
                window.console.log('Error >>>> ' + error.body.message);
            })
    }

    closeModel(event) {
        this.showModal = false;
    }

}