trigger AccountValidation on Account (before insert, before update, after insert) {
    Utils u = new Utils();
    List<Opportunity> opp = new List<Opportunity>();
    List<Task> taskList = new List<Task>();

    for(Account a: Trigger.new){
        if(!u.validaCPF(a.AccountNumber) && !u.validaCNPJ(a.AccountNumber)){
            a.AccountNumber.addError('Número do cliente é inválido');
        }

        if(a.Type.equals('Prospect')){
            newOpportunity(a);
        }

        if (a.Type.equals('Customer - Direct')) {
            newTask(a);
        }
    }

    void newOpportunity(Account a){
        opp.add(new Opportunity(Name = a.Name + '-opp Parceiro',
        CloseDate = System.today().addDays(30),
        StageName = 'Qualification',
        AccountId = a.Id));
    }

    if (opp.size() > 0) {
        insert opp;
    }

    void newTask(Account a){
        taskList.add(new Task(WhatId = a.Id,
        Subject = 'Consumidor Final',
        Status= 'Not Started',
        Priority= 'Normal'));
    }

    if(taskList.size() > 0){
        insert taskList;
    }

}