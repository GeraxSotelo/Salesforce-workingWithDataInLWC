import { LightningElement } from 'lwc';

export default class Lists extends LightningElement {
    accountSelectedId;
    contactSelectedZipCode;

    handleAccountSelected(evt) {
        this.accountSelectedId = evt.detail;
        // To clear the weather when a different account is selected
        // uncomment the line belore
        // this.contactSelectedZipCode = null;
    }

    handleContactSelected(evt) {
        console.log('handle contact selected');
        this.contactSelectedZipCode = evt.detail;
    }
}