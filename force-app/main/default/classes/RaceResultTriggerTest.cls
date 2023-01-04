@isTest
private class RaceResultTriggerTest {
    @isTest
    static void beforeInsert(){ //у випадку 2 інсертів переробити
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
        Race_Result__c testResult = new Race_Result__c(Grand_Prix__c = testRace.Id, Racer__c = firstTestDriver.Id, Position__c =1);
        insert (testResult);
        Race_Result__c newtestResult = new Race_Result__c(Grand_Prix__c = testRace.Id, Racer__c = secondTestDriver.Id, Position__c =1);
        List<Race_Result__c> myResults = new List<Race_Result__c>();
        myResults.add(newtestResult);
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(myResults,false);
        Test.stopTest();
        for(Database.SaveResult sv:results){
            System.assert(!(sv.isSuccess()),'Error in beforeInsert');
        }

    }
}
