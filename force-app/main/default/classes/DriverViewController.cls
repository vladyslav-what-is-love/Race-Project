public with sharing class DriverViewController {
    @AuraEnabled
    public static List<Driver__c> getHatTricks(){
        return[SELECT Id,Full_Name__c,HatTricks__c FROM Driver__c WHERE HatTricks__c!=NULL ORDER BY HatTricks__c DESC LIMIT 5];
    }
}
