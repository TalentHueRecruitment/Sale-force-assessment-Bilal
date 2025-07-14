import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/GetAccountsWithContacts.getAccounts';
import getTotalAccountCount from '@salesforce/apex/GetAccountsWithContacts.getTotalAccountCount';

export default class AccountList extends LightningElement {
    @track accounts = [];
    @track pageNumber = 1;
    pageSize = 10;
    totalAccounts = 0;
    selectedAccountId;

    connectedCallback() {
        this.loadAccounts();
    }

    get isFirstPage() {
        return this.pageNumber === 1;
    }

    get isLastPage() {
        return this.pageNumber * this.pageSize >= this.totalAccounts;
    }

    loadAccounts() {
        getTotalAccountCount()
            .then(count => {
                this.totalAccounts = count;
                return getAccounts({ pageSize: this.pageSize, pageNumber: this.pageNumber });
            })
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                console.error('Error loading accounts:', error);
            });
    }

    handlePrevious() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            this.loadAccounts();
        }
    }

    handleNext() {
        if (!this.isLastPage) {
            this.pageNumber++;
            this.loadAccounts();
        }
    }

    handleAccountClick(event) {
        this.selectedAccountId = event.currentTarget.dataset.id;
    }
}
