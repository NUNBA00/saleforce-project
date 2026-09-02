trigger OpportunityAutomation on Opportunity (before insert, after insert, before update, after update) {

    switch on Trigger.operationType {
        when  BEFORE_INSERT, BEFORE_UPDATE {
            // TODO: Update "NextStep"  on opportunity to "Onboard a Contract".
              for (Opportunity opp : Trigger.new) {
                if(opp.StageName == 'Closed Won'){
                    opp.NextStep = 'Onboard a Contract';
                }
              }
        }
        when AFTER_INSERT, AFTER_UPDATE{
            // Todo: Create follow-up tasks for the sales team 
            // to engage with the customer, schedule a welcome call ,
            // and send a thank-you email. 
            for (Opportunity opp : Trigger.new) {
                if (opp.StageName == 'Closed won') {
                    Task engageWithCustomer = new Task();
                    engageWithCustomer.WhatId = opp.Id;
                    engageWithCustomer.Subject = 'Engage with Customer';
                    insert engageWithCustomer;

                    Task welcomeCall = new Task();
                    welcomeCall.WhatId = opp.Id;
                    welcomeCall.Subject = 'schedule a welcome call';
                    insert welcomeCall;

                    Task thankYouEmail = new Task();
                    thankYouEmail.WhatId = opp.Id;
                    thankYouEmail.Subject = 'Send a thank-you email';
                    insert thankYouEmail;
                }
                
            }
            
        }
    }
}