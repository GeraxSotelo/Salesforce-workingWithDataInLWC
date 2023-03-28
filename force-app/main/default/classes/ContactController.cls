public with sharing class ContactController {
    // We annotate the method with @AuraEnabled(cacheable=true) so that the results are cached.
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {
        List<Contact> contactList = [SELECT Id, FirstName, LastName, Email, Phone, MailingPostalCode
                                     FROM Contact
                                     WHERE AccountId = :accountId];
        if(contactList.size() > 0) {
            System.debug('contactList: ' + contactList);
            System.debug('contactList zip code: ' + contactList[0].MailingPostalCode);  
        } else {
            System.debug('No contacts');
        }

        return contactList;
    }
}