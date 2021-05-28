global without sharing class CleanInactiveAccounts implements Database.Batchable<SObject> {

    global Integer recordCount = 0;

    global Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([SELECT Id
        FROM Account
        WHERE Id IN :searchAccountIds()]); 
    }

    global void execute(Database.BatchableContext dbc, List<Account> accounts){
        for(Account a: accounts){
            a.Inativa__c = true;
        }
        update accounts;
        recordCount = recordCount + accounts.size();
    }

    global void finish(Database.BatchableContext dbc){
        System.debug('Total records processed ' + recordCount);
    }

    public List<Id> searchTaskId(){
        List<Id> taskId = new List<Id>();
        for (Task t : [SELECT WhatId FROM Task WHERE ActivityDate = LAST_90_DAYS]) {
            taskId.add(t.WhatId);
        }
        return taskId;
    }

    public List<Id> searchOpportunityId(){
        List<Id> oppId = new List<Id>();
        for (Opportunity p : [SELECT AccountId FROM Opportunity WHERE CloseDate = LAST_N_DAYS:120 and StageName != 'Closed Won' and StageName != 'Negotiation/Review']) {
            oppId.add(p.AccountId);
        }
        return oppId;
    }

    public List<Id> searchAccountIds(){
        List<Id> accountIds = new List<Id>();
        for(Integer i = 0; i < searchTaskId().size(); i++){
            for (Integer j = 0; j < searchOpportunityId().size(); j++) {
                if (searchTaskId().get(i) == searchOpportunityId().get(j)) {
                    accountIds.add(searchTaskId().get(i));
                }
            }
        }
        return accountIds;
    }
}
