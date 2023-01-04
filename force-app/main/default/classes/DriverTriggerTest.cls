@isTest
private class DriverTriggerTest {
    @TestSetup
    static void Setup(){
        Driver__c firstTestDriver = new Driver__c(First_Name__c = 'Test',Last_Name__c = 'Qweer', Age__c = 19,HatTricks__c = 0);
        Driver__c secondTestDriver = new Driver__c(First_Name__c = 'Test1',Last_Name__c = 'Qweer', Age__c = 19);
        Driver__c thirdTestDriver = new Driver__c(First_Name__c = 'Test2',Last_Name__c = 'Qweer', Age__c = 19);
        insert firstTestDriver;
        insert secondTestDriver;
        insert thirdTestDriver;
        Race__c testRace = new Race__c(
            Amount_Of_Race_Results__c = 3,
            Laps__c = 12, 
            Status__c = 'Completed',
            Track__c = 'AVUS', 
            Date__c = date.today(),
            Winner__c = firstTestDriver.Id, 
            Podium_Second__c = secondTestDriver.Id, 
            Podium_Third__c = thirdTestDriver.Id);
        insert testRace;
        Race_Result__c testResult = new Race_Result__c(Grand_Prix__c = testRace.Id, Racer__c = firstTestDriver.Id,Is_Fastest_Lap__c = true,Position__c =1);
        Race_Result__c newtestResult = new Race_Result__c(Grand_Prix__c = testRace.Id, Racer__c = secondTestDriver.Id);
        insert testResult;
        insert newtestResult;
    }

    @isTest 
        static void beforeInsertTest(){

        Driver__c newtestDriver = new Driver__c(First_Name__c = 'Test',Last_Name__c = 'Test', Age__c = 19);
        Test.startTest();
        try{
            Database.SaveResult result = Database.insert(newtestDriver, true);
            System.assert(false,'Before Insert on Driver should be prevented');
        }
        catch(Exception ex){

        }
        Test.stopTest();
    }

    @isTest
    static void afterUpdateTest(){
        List<Driver__c> filter = new List<Driver__c>([
            SELECT Id, First_Name__c 
            FROM Driver__c WHERE First_Name__c IN ('Test','Test1')]);

        for(Driver__c dr:filter){
            dr.First_Name__c = 'Qwerttyy';
        }
        Test.startTest();
        update filter;
        
        Test.stopTest();
        List<Driver__c> filteredDr = new List<Driver__c>([SELECT Id, HatTricks__c FROM Driver__c WHERE First_Name__c='Qwerttyy']);
        System.assertEquals(1,filteredDr[0].HatTricks__c,'Error in afterUpdateDriver');
    }
   
}
