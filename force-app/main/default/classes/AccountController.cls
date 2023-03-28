public with sharing class AccountController {
    // annotate the method with @AuraEnabled(cacheable=true) so that the results are cached.
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        List<Account> accountList = [SELECT Name, Type, Phone, Website
                                     FROM Account
                                     ORDER BY Name
                                     LIMIT 50];
        return accountList;
    }
}