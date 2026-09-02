public with sharing class UpdateAccountDescription implements Queueable{
    public List<Account> accountList ;

    //Constructor to pass data into the job 
    public UpdateAccountDescription(List<Account> accounts) {
           this.accountList = accounts;
    }

    // Madatory method from the Queueable interface 
    public void execute(QueueableContext context) {
        for(Account acc : accountList) {
            acc.Description = 'Updated via Queueable Apex at ' + System.now();
        }
        update accountList;
    }

    }