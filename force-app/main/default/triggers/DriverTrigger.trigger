trigger DriverTrigger on Driver__c (before insert,before update,after update) {

    if(Trigger.isInsert){
        if(Trigger.isBefore){
            
            for(Driver__c dr:Trigger.new){
                if(dr.First_Name__c ==dr.Last_Name__c){
                    dr.addError('Drivers can not have the same First Name and Last Name');
                }
            }
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isAfter){
            if(checkRecursive.runOnce())
            {
                Map<Id,Decimal> myMap = new Map<Id,Decimal>();

            List<Race_Result__c> myResults = new List<Race_Result__c> ([SELECT Id, Is_Fastest_Lap__c, Position__c, Racer__r.HatTricks__c,Racer__r.Id FROM Race_Result__c WHERE Racer__c IN :Trigger.new]);
            
            for(Race_Result__c res:myResults){
                if(myMap.containsKey(res.Racer__r.ID) && res.Is_Fastest_Lap__c == true && res.Position__c ==1){
                    Decimal buff = myMap.get(res.Racer__r.ID);
                    buff++;
                    myMap.put(res.Racer__r.ID,buff);
                }
                else{
                    if (res.Is_Fastest_Lap__c == true && res.Position__c ==1){
                        Decimal buff = 0;
                        if(res.Racer__r.HatTricks__c == NULL){
                            buff =1;
                        }
                        else{
                            buff = res.Racer__r.HatTricks__c;
                            buff++;
                        }
                        myMap.put(res.Racer__r.ID, buff);
                    }
                }
                
            }
            Set <Id> driverId = myMap.keySet();

            List<Driver__c> myDrivers = new List<Driver__c>([SELECT Id, HatTricks__c FROM Driver__c WHERE Id in :driverId]);

            for(Driver__c dr:myDrivers){
                dr.HatTricks__c = myMap.get(dr.Id);
            }

            update myDrivers;
            }
        }
    }

}