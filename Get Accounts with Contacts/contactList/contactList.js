import { LightningElement, api, track } from 'lwc';
import getContactsByAccount from '@salesforce/apex/GetAccountsWithContacts.getContactsByAccount';

const COLUMNS = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Title', fieldName: 'Title' },
    { label: 'Department', fieldName: 'Department' }
];

export default class ContactList extends LightningElement {
    @track contacts = [];
    @track error;
    @track isLoading = false;
    columns = COLUMNS;

    _accountId;
    @api
    set accountId(value) {
        if (value !== this._accountId) {
            this._accountId = value;
            this.fetchContacts();
        }
    }
    get accountId() {
        return this._accountId;
    }

    fetchContacts() {
        if (!this._accountId) return;

        this.isLoading = true;
        this.contacts = [];
        this.error = undefined;

        getContactsByAccount({ accountId: this._accountId })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                this.error = error.body?.message || 'Error fetching contacts';
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}
