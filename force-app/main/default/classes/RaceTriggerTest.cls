@isTest
private class RaceTriggerTest {
    @isTest
    static void beforeInsertTest(){
        Driver__c firstTestDriver = new Driver__c(First_Name__c = 'Test',Last_Name__c = 'Qweer', Age__c = 19);
        insert firstTestDriver;
        
        Race__c testRace = new Race__c(
            Amount_Of_Race_Results__c = 3,
            Laps__c = 12, 
            Status__c = 'Completed',
            Track__c = 'AVUS', 
            Date__c = date.today(),
        Winner__c = firstTestDriver.Id);
        boolean isAcseption = false;
        Test.startTest();
        try{
            insert testRace;
            //System.assert(false,'Race Trigger does not work');
        }
        catch (Exception ex){
            isAcseption = true;
        }
        Test.stopTest();
        System.assert(isAcseption,'Race Trigger does not work');
    }
    
}
