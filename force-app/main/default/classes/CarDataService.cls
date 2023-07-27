public with sharing class CarDataService {

    @AuraEnabled(cacheable=true)
    public static List<Car_Type__c> getCarTypes() {
        List<Car_Types> carTypes;
        try {
            carTypes = [SELECT Name, Id FROM Car_Type__c WITH SECURITY_ENFORCED ORDER BY Name];
        }
        catch(System.QueryException qe) {
            System.debug(qe.getMessage());
        }
        return carTypes;
    }

    @AuraEnabled(cacheable=true)
    public static List<Car__c> getCars(String carTypeId) {
        // Without a carTypeId, the full list is queried
        List<Car__c> cars;
        try {
            String query = 'SELECT '
                     + 'Name, Description__c, Geolocation__Latitude__s, '
                     + 'Geolocation__Longitude__s, Picture__c, Account__r.Name, '
                     + 'Car_Type__c, Car_Type__r.Name '
                     + 'FROM Car__c';
            if (String.isNotBlank(carTypeId)) {
                query += ' WHERE Car_Type__c = :carTypeId';
            }
            query += ' WITH SECURITY_ENFORCED ';
            cars = System.Database.query(query);
        } 
        catch(System.QueryException qe) {
            System.debug(qe.getMessage());
        }  
        return cars;
    }
}