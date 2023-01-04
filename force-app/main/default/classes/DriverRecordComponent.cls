public with sharing class DriverRecordComponent {
    @AuraEnabled(Cacheable=true)
    public static List<Race_Result__c> getWonResults(Id recordId){
        List<Race_Result__c> thisList = [SELECT Id,Name,Position__c,Grid__c FROM Race_Result__c WHERE Racer__c =:recordId AND Position__c = 1];
       // System.debug(thisList);
        return thisList;
    }
}
