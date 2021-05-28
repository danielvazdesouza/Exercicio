global without sharing class CleanInactiveAccountsBatch implements Schedulable {
    global void execute(SchedulableContext context){
        CleanInactiveAccounts instance = new CleanInactiveAccounts(); 
        if(!Test.isRunningTest())
            Database.executeBatch(instance);
    }
}
