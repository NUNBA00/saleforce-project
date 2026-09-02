trigger LeadTrigger on Lead (before update, after update) {

    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            System.debug('Lead  trigger invoked before update');
        }
    if(Trigger.isAfter){
        System.debug('Lead trigger invoked after update');
    }
    }
   switch on Trigger.operationType {
    when  BEFORE_UPDATE{
        System.debug('Lead trigger before update');
        Lead leadRecord = Trigger.new.get(0); // List<Lead> 
        leadRecord.Company += ' Inc';
        
    }
    when AFTER_UPDATE {
        System.debug('Lead trigger after update');
        List<Lead> leads = Trigger.new;
        Lead leadRecord = leads[0];
        if(leadRecord.Rating == 'Hot') {
            Task followup = new Task();
            followup.WhoId= leadRecord.Id;
            followup.Subject = 'Followup on a new hot lead';
            followup.Priority = 'High';
            insert followup;
        }
    }
    when else {
        System.debug('Error!');
    }
   }
}