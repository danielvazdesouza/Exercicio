public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static Account getAccount(){
        return [SELECT Name, AccountNumber, Type
        FROM Account
        WITH SECURITY_ENFORCED
        LIMIT 1];
    }
}
