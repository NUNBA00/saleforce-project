public class BankAccount {
    // 1. private variables - Data hiding 
    private Decimal balance;
    private String accountHolderNumber;

    // Constructor to initialize variables
    public BankAccount(String name, Decimal initialBalance){
        this.accountHolderNumber = name;
        if (initialBalance >= 0 ) {
                this.balance = initialBalance;
        } else {
            this.balance = 0;
            System.debug('Initial balance cannot be negative. Setting balance to 0.');
        }
    }
}