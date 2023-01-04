public with sharing class FormulaOneDAO {

  public static Driver__c getDriver(Id driverId){
    return[SELECT Name FROM Driver__c WHERE ID =: driverId];
  }
   
  public static List<Race_Result__c> getRaceResults(Id driverId){
    List<Race_Result__c> filteredDrivers = [SELECT Name FROM Race_Result__c WHERE Racer__c =: driverId];
    return filteredDrivers;
  }

  public static Set<String> getDriverCircuits(Id driverId){
    List <Race__c> myRaces = new List <Race__c>([SELECT Name FROM Race__c WHERE Winner__c =: driverId OR Podium_Second__c =: driverId OR Podium_Third__c =: driverId]);
    Set <String> names = new Set <String>();
    for(Race__c ra : myRaces){
      names.add(ra.name);
    }
    return names;
  }

  public static List<Driver__c> getYoungestDriversOnRace(Id raceId){
    Race__c thisRace = [SELECT Name,Winner__c,Podium_Second__c,Podium_Third__c FROM Race__c WHERE ID =: raceId];
    List<Driver__c> filteredDrivers = new List<Driver__c>([
      SELECT Name FROM Driver__c 
      WHERE ID =: thisRace.Winner__c 
      OR ID =: thisRace.Podium_Second__c 
      OR ID =: thisRace.Podium_Third__c]);
    return filteredDrivers;
  }
   
 public static Map<String, List<String>> getAllDriversByCircuit(){
    Map<String, List<String>> racersFullName = new Map<String, List<String>>();
      
    List<Race__c> races = [SELECT Name,Winner__c,Podium_Second__c,Podium_Third__c FROM Race__c];
    
    List<Driver__c> drivers = [ SELECT Full_Name__c FROM Driver__c];

    List<String> fullNames = new List<String>();

    for(Race__c ra : races){
      for (Driver__c dr : drivers){
          if(ra.Winner__c == dr.ID || ra.Podium_Second__c == dr.ID || ra.Podium_Third__c == dr.ID){
            fullNames.add(dr.Full_Name__c);
          }
      }
      racersFullName.put(ra.Name,fullNames);
      fullNames.clear();
    }
    

    return racersFullName;
  }
}