import { LightningElement, wire} from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class AccountList extends LightningElement {
    accountList;

    @wire(getAccounts) accounts({data,error}){
        if (data) {
            this.accountList = data;
            console.log('Account Data: ', data); 
        } else if (error) {
            console.log('error: ', error);
        }
    }

    // Send selected account Id
    handleAccountCardClick(evt) {
        const event = new CustomEvent('accountselected', {
            detail: evt.detail
        });
        // Fire event
        this.dispatchEvent(event);
    }
}