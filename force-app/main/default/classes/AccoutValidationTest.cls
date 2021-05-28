@isTest
private class AccoutValidationTest {
    @isTest static void testUpdateTrigger(){
        Account invalid = new Account(Name='Account Test', AccountNumber='123456789101', Type ='Prospect'); //12 Char
        Account validCPF = new Account(Name='Account Test', AccountNumber='12345678910', Type ='Customer - Direct'); //11 Char
        Account validCNPJ = new Account(Name='Account Test', AccountNumber='12345678910111', Type ='CNPJ'); //14 Char
        Test.startTest();
        Database.UpsertResult resultInvalid = Database.upsert(invalid, false);
        Database.UpsertResult resultCPF = Database.upsert(validCPF, true);
        Database.UpsertResult resultCNPJ = Database.upsert(validCNPJ, true);
        Test.stopTest();
    }

}
