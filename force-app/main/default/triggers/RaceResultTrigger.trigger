trigger RaceResultTrigger on Race_Result__c (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            Set<Id> resId = new Set<Id>();
            for(Race_Result__c res:Trigger.new){
                resId.add(res.Grand_Prix__c);
            }
            List<Race_Result__c> addResults = new List<Race_Result__c>([SELECT Position__c, Grand_Prix__c FROM Race_Result__c 
                                                                        WHERE Grand_Prix__c IN :resId]);
            Map<Id,List<Race_Result__c>> newMapa = new Map<Id,List<Race_Result__c>>();
            for(Race_Result__c re:addResults){
                if(newMapa.containsKey(re.Grand_Prix__c))
                    {
                        List<Race_Result__c> newRes = newMapa.get(re.Grand_Prix__c);
                        newRes.add(re);
                    }
                    else {
                        List<Race_Result__c> newRes = new List<Race_Result__c>{re};
                        newMapa.put(re.Grand_Prix__c,newRes);
                    }
            }
            Map<Id,Set<Decimal>> mapa = new Map<Id,Set<Decimal>>();

            for(Race_Result__c myResults:Trigger.new){
                List<Race_Result__c> oldRes = newMapa.get(myResults.Grand_Prix__c);
                if (oldRes==NULL){
                    continue;
                }
                for(Race_Result__c re:oldRes){
                    if(re.Position__c == myResults.Position__c){
                        myResults.addError('There cannot be the same value for position for different races');
                    }
                } 
            }
        }
    }

}