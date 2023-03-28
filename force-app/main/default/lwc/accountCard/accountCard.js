import { LightningElement, api } from 'lwc';

export default class AccountCard extends LightningElement {
    @api account;

    accountCardClick() {
        const event = new CustomEvent('accountcardclick', {
            detail: this.account.Id
        });
        console.log('account clicked: ', this.account.Name);

        // fire event
        this.dispatchEvent(event);
    }
}