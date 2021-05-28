@isTest
private with sharing class CleanInactiveAccountsTest {
    @isTest
    private static void testCleaning(){
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Task 90 days', AccountNumber = '12345678901', Type = 'Prospect'));
        accounts.add(new Account(Name='Opp 120 days not Closed Won', AccountNumber = '12345678912', Type = 'Prospect'));
        accounts.add(new Account(Name='Opp not Renegotiatio Review', AccountNumber = '12345678913123', Type = 'Prospect'));

        insert accounts;

        List<Task> listTask = new List<Task>();
        listTask.add(new Task(WhatId = accounts.get(0).Id, ActivityDate = Date.newInstance(2021, 05, 01)));
        listTask.add(new Task(WhatId = accounts.get(1).Id, ActivityDate = Date.newInstance(2021, 05, 02)));
        listTask.add(new Task(WhatId = accounts.get(2).Id, ActivityDate = Date.newInstance(2021, 05, 03)));
 
        insert listTask;

        List<Opportunity> opp = new List<Opportunity>();
        opp.add(new Opportunity(Name='New Opportunity', CloseDate = Date.newInstance(2020, 05, 27), StageName='Cloed Won', AccountId = accounts.get(0).Id));
        opp.add(new Opportunity(Name='New Opportunity', CloseDate = Date.newInstance(2021, 05, 11), StageName='Prospecting', AccountId = accounts.get(1).Id));
        opp.add(new Opportunity(Name='New Opportunity', CloseDate = Date.newInstance(2021, 05, 27), StageName='Negotiation/Review', AccountId = accounts.get(2).Id));

        insert opp;

        Test.startTest();
        CleanInactiveAccounts cia = new CleanInactiveAccounts();
        Database.executeBatch(cia);
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT id FROM Account WHERE Inativa__c = true];
        System.assertEquals(1, updatedAccounts.size(), 'ERROR: Nao funcionou');
    }
}
