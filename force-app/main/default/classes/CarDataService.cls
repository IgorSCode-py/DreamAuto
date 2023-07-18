public with sharing class CarDataService {

    @AuraEnabled(cacheable=true)
    public static List<Car_Type__c> getCarTypes() {
        return [SELECT Name, Id FROM Car_Type__c WITH SECURITY_ENFORCED ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<Car__c> getCars(String carTypeId) {
        // Without a carTypeId, the full list is queried
        String query = 'SELECT '
                     + 'Name, Description__c, Geolocation__Latitude__s, '
                     + 'Geolocation__Longitude__s, Picture__c, Account__r.Name, '
                     + 'Car_Type__c, Car_Type__r.Name '
                     + 'FROM Car__c';
        if (String.isNotBlank(carTypeId)) {
            query += ' WHERE Car_Type__c = :carTypeId';
        }
        query += ' WITH SECURITY_ENFORCED ';
        return System.Database.query(query);
    }
}