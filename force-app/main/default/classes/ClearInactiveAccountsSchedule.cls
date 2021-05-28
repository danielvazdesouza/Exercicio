global class ClearInactiveAccountsSchedule implements Schedulable{
    global void execute(SchedulableContext sc){
        CleanInactiveAccountsBatch inactiveAccounts = new CleanInactiveAccountsBatch();
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
        String sch = '0 0 0/6 0 0 MON-FRI';
        String jobName = 'Clean Inactive Accounts';
        System.schedule(jobName, sch, inactiveAccounts);
    }
}
