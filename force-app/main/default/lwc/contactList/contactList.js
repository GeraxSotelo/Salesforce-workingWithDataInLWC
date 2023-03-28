import { LightningElement, wire, api } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import CONTACT_SELECTED_CHANNEL from '@salesforce/messageChannel/Contact_Selected__c';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class ContactList extends LightningElement {
    @api accountId;
    contactList;

    @wire(MessageContext) messageContext;

    @wire(getContacts, {accountId : '$accountId'})
    contacts({data, error}){
        if (data) {
            this.contactList = data;
            console.log('Contact Data: ', data); 
        } else if (error) {
            console.log('error: ', error);
        }
    }

    handleContactCardClick(evt) {
            const event = new CustomEvent('contactselected', {
                detail: evt.detail
            });
            this.dispatchEvent(event);

            const payload = {zipcode : evt.detail};

            publish(this.messageContext, CONTACT_SELECTED_CHANNEL, payload);
    }
}