@isTest
public with sharing class AccountProcessorTest {
    @isTest
    static void testFutureMethod() {

        Account acc = new Account(Name = 'Test Future Method Account');
        insert acc;

        Test.startTest();
        AccountProcessor.UpdateAccountDescription(new List<Id>{acc.Id});
        Test.stopTest(); // Forces the @Future method to run

        Account updatedAcc = [SELECT Description FROM Account WHERE Id = :acc.Id];
        System.assert(updatedAcc.Description.contains('Updated via @future Method at'));

    }
}