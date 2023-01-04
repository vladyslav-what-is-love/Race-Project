public with sharing class FormulaOneServices {

    public class DriverDTO{
        
            public String firstName;
            public String lastName;
            public Integer age;
        
}

public static String generateKey (SObject record, List<SObjectField> fields, String separator){
        string newString = '';
        for (Integer i = 0; i<fields.size(); i++){
            newString += record.get(fields[i]) + separator;
        }

        System.debug(newString);
        return newString;
}

public static Boolean isHatTrick(Race_Result__c raceResult){
    return (raceResult.Position__c == 1 && raceResult.Grid__c == 1 && raceResult.Is_Fastest_Lap__c);
}

public static Database.SaveResult createDriver(String firstName, String lastName, Integer age){
    Driver__c myDriver = new Driver__c (First_Name__c = firstName, Last_Name__c = lastName, Age__c = age);
    return Database.insert(myDriver,true);
}

public static void createDrivers(List<DriverDTO> drivers){
    List<Driver__c> myDrivers = new List<Driver__c>();
    for(DriverDTO dr:drivers){
        Driver__c myD = new Driver__c();
            myD.First_Name__c = dr.firstName;
            myD.Last_Name__c = dr.lastName;
            myD.Age__c = dr.age;
        myDrivers.add(myD);
    }
    Database.SaveResult[] saving = Database.insert(myDrivers, true);
}

public static void updateDriverName (Id driverId, String firstName, String lastName){
    Driver__c myDriver = [SELECT First_Name__c,Last_Name__c FROM Driver__c WHERE ID =:driverId];
    myDriver.First_Name__c = firstName;
    myDriver.Last_Name__c = lastName;
    update myDriver;
}

public static List<Race__c> updateGrandPrixWinners (Set<Id> raceIds){

    List<Race__c> races = new List<Race__c>([SELECT Id , Name, (SELECT Id,Name,Position__c , Racer__c FROM Race_Results1__r) FROM Race__c WHERE ID IN :raceIds]);
    
    for(Race__c ras:races){
        for(Race_Result__c resul:ras.Race_Results1__r){
            if(resul.Position__c == 1){
                ras.Winner__c = resul.Racer__c;
            }
            if(resul.Position__c == 2){
                ras.Podium_Second__c = resul.Racer__c;
            }
            if(resul.Position__c == 3){
                ras.Podium_Third__c = resul.Racer__c;
            }
        }
    }

    Database.SaveResult[] updation = Database.update(races, true);
    return races;
}
    
    
}