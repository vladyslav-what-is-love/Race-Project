@isTest
private class FormulaOneServicesTest {
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
        Race__c newtestRace = new Race__c(
            Amount_Of_Race_Results__c = 4,
            Laps__c = 11, 
            Status__c = 'Completed',
            Track__c = 'AVUS', 
            Date__c = date.today(),
            Winner__c = firstTestDriver.Id, 
            Podium_Second__c = secondTestDriver.Id, 
            Podium_Third__c = thirdTestDriver.Id);
        insert newtestRace;
        Race_Result__c testResult = new Race_Result__c(
            Is_Fastest_Lap__c = true,
            Position__c = 1,
            Grid__c = 1,
            Grand_Prix__c = testRace.Id, 
            Racer__c = firstTestDriver.Id);
        insert testResult;
    }
    

    @isTest
    static void generateKeyTest(){ //Як закинути значення в List< SObjectField > ?????
        Driver__c newtestDriver =[SELECT Id, Name,First_Name__c FROM Driver__c WHERE First_Name__c = 'Test'];
        List< SObjectField > some = new List< SObjectField >();
        some.add(Driver__c.First_Name__c);
        Test.startTest();
        String str = FormulaOneServices.generateKey(newtestDriver,some,' ');
        Test.stopTest();
        String newstr = newtestDriver.First_Name__c + ' ';
        System.assertEquals(newstr, str,'Error');
    }
    
    @isTest
    static void isHatTrickTest(){
        Race_Result__c newRaceResult = [SELECT Id,Position__c,Grid__c,Is_Fastest_Lap__c FROM Race_Result__c LIMIT 1];
        Test.startTest();
        Boolean myTrigger = FormulaOneServices.isHatTrick(newRaceResult);
        Test.stopTest();
        System.assertEquals(true,myTrigger,'Error in getRaceResults');
    }

    @isTest
    static void createDriverTest(){
        Test.startTest();
        FormulaOneServices.createDriver('Testing','Test,',40);
        Test.stopTest();
        Driver__c newDr = [SELECT Id,First_Name__c,Last_Name__c FROM Driver__c WHERE Age__c = 40];
        System.assertEquals('Testing',newDr.First_Name__c,'Error in createDriver');
    }

    @isTest
    static void createDriversTest(){
        List<FormulaOneServices.DriverDTO> drivers = new List<FormulaOneServices.DriverDTO>();
        FormulaOneServices.DriverDTO first = new FormulaOneServices.DriverDTO();
            first.firstName = 'Testing1';
            first.lastName = 'Test1';
            first.age = 20;
        FormulaOneServices.DriverDTO second = new FormulaOneServices.DriverDTO();
            second.firstName = 'Testing2';
            second.lastName = 'Test2';
            second.age = 20;
        System.debug(second.firstName);
        drivers.add(first);
        drivers.add(second);
        List<Driver__c> trueDr = [SELECT Id,First_Name__c FROM Driver__c];
        Test.startTest();
        FormulaOneServices.createDrivers(drivers);
        Test.stopTest();
        List<Driver__c> newTrueDr = [SELECT Id,First_Name__c FROM Driver__c];
        System.assertEquals(newTrueDr.size()-2,trueDr.size(),'Error');
    }

    @isTest
    static void updateDriverNameTest(){
        Driver__c newTestDriver = [SELECT Id,First_Name__c,Last_Name__c FROM Driver__c WHERE First_Name__c = 'Test'];
        Test.startTest();
        FormulaOneServices.updateDriverName(newTestDriver.Id, 'NewTesting', 'NewTest');
        Test.stopTest();
        Driver__c nnewTestDriver = [SELECT Id,First_Name__c,Last_Name__c FROM Driver__c WHERE First_Name__c = 'NewTesting'];
        System.assertEquals('NewTesting', nnewTestDriver.First_Name__c,'Error');
    }

   @isTest
    static void updateGrandPrixWinnersTest(){
        List<Race__c> newList= new List<Race__c>([SELECT Id FROM Race__c]);
        Set<Id> raceIds = new Set<Id>();
        raceIds.add(newList[0].Id);
        raceIds.add(newList[1].Id);
        Test.startTest();
        List<Race__c> mynewList = FormulaOneServices.updateGrandPrixWinners(raceIds);
        Test.stopTest();
        System.assert(mynewList!=NULL,'Error in updateGrandPrixWinners');
    }


}
