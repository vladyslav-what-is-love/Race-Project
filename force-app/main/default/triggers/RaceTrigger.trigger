trigger RaceTrigger on Race__c (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            for(Race__c ra: Trigger.new){
                if(ra.Winner__c == ra.Podium_Second__c || ra.Winner__c == ra.Podium_Third__c ||ra.Podium_Second__c == ra.Podium_Third__c )
                {
                    ra.addError('One Racer can only be at exact place');
                }
            }
        }
    }
}