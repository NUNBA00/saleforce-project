trigger AccountTrigger on Account (before insert, before update, after update) {
	
    if(Trigger.isInsert){
        if(Trigger.isBefore) {
           System.debug('Before Insert Context'); 
        }
        if(Trigger.isAfter) {
        System.debug('After Insert Context');
    }
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore) {
            for(Account acc : Trigger.new ){
              System.debug('New name' + acc.Name);  
              System.debug('Old name:' + Trigger.oldMap.get(acc.Id).Name); 
        }
        
    }
    }
}