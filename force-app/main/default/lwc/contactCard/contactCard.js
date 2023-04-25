import { LightningElement, api } from 'lwc';

export default class ContactCard extends LightningElement {
    @api contact;

    contactCardClick() {
        const event = new CustomEvent('contactcardclick', {
            detail: this.contact.MailingPostalCode
        });
        console.log('contact: ', this.contact);

        // fire event
        this.dispatchEvent(event);
    }
}