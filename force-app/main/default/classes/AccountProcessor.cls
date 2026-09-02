public with sharing class AccountProcessor {
    // Annotation to mark method as asynchronous @future
    @future
    public static void UpdateAccountDescription(List<Id> accountIds) {
        // Query the record based on the IDs passed 
        List<Account> accountsToUpdate = [SELECT Id, Description FROM Account WHERE Id IN :accountIds];

        for(Account acc : accountsToUpdate){
            acc.Description = 'Updated via @future at ' + System.now();
        }

        // DML operation to update the records
        update accountsToUpdate;

    }
}