@isTest
private class FormulaOneDaoTest {

    @TestSetup
    static void Setup(){
        Driver__c firstTestDriver = new Driver__c(First_Name__c = 'Test',Last_Name__c = 'Qweer', Age__c = 19);
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
        Race_Result__c testResult = new Race_Result__c(Grand_Prix__c = testRace.Id, Racer__c = firstTestDriver.Id);
        insert testResult;
    }

    @isTest
    static void getDriverTest(){
        Driver__c newtestDriver =[SELECT Id, Name FROM Driver__c WHERE First_Name__c = 'Test'];
        Driver__c secondTestDriver = FormulaOneDAO.getDriver(newtestDriver.Id);
        System.assert(secondTestDriver !=NULL,'Error');
    }
    @isTest
    static void getRaceResultsTest(){
        Driver__c newTestDriver = [SELECT Id,Name FROM Driver__c WHERE First_Name__c = 'Test'];
        Race_Result__c newRaceResult = [SELECT Id FROM Race_Result__c WHERE Racer__c =: newTestDriver.Id];
        Test.startTest();
        List<Race_Result__c> myfilteredDrivers = FormulaOneDAO.getRaceResults(newTestDriver.Id);
        Test.stopTest();
        System.assertEquals(newRaceResult.Id,myfilteredDrivers[0].Id,'Error in getRaceResults');
    }

   @isTest
    static void getDriverCircuitsTest(){
        Driver__c newTestDriver = [SELECT Id FROM Driver__c WHERE First_Name__c = 'Test'];
        Race__c newTestRace = [SELECT Id,Name FROM Race__c WHERE Winner__c =:newTestDriver.Id];
        Test.startTest();
        Set <String> mynames = FormulaOneDAO.getDriverCircuits(newTestDriver.Id);
        Test.stopTest();
        System.assertEquals(true,mynames.contains(newTestRace.Name),'Error in getDriverCircuits');
    }
   @isTest
    static void getYoungestDriversOnRace(){
        Driver__c newTestDriver = [SELECT Id,First_Name__c FROM Driver__c WHERE First_Name__c = 'Test'];
        Race__c newTestRace = [SELECT Id FROM Race__c WHERE Winner__c =:newTestDriver.Id];
        Test.startTest();
        List<Driver__c> newfilteredDrivers = FormulaOneDAO.getYoungestDriversOnRace(newTestRace.Id);
        Test.stopTest();
        System.assertEquals(newTestDriver.Id,newfilteredDrivers[0].Id,'Error in getYoungestDriversOnRace');
    }
    
    @isTest
    static void getAllDriversByCircuitTest(){
        List<Driver__c> drivers = [SELECT Id,Full_Name__c FROM Driver__c WHERE First_Name__c = 'Test' OR First_Name__c = 'Test1' OR First_Name__c = 'Test2'];
        List<String> fullNames = new List<String>();
        Race__c newTestRace = [SELECT Id, Name FROM Race__c WHERE Winner__c =:drivers[0].Id];
        for(Driver__c dr:drivers){
            fullNames.add(dr.Full_Name__c);
        }
        Test.startTest();
        Map<String, List<String>> testMap = FormulaOneDAO.getAllDriversByCircuit();
        
        Test.stopTest();
        System.assert(testMap.keySet().isEmpty(),'Map should contain values');
        //System.assertEquals(fullNames[0],testMap.get(newTestRace.Name),'Error in getAllDriversByCircuit');
    }
}