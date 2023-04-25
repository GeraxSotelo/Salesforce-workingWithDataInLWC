public with sharing class ContactController {
    // We annotate the method with @AuraEnabled(cacheable=true) so that the results are cached.
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {
        List<Contact> contactList = [SELECT Id, FirstName, LastName, Email, Phone, MailingPostalCode
                                     FROM Contact
                                     WHERE AccountId = :accountId];

        return contactList;
    }
}