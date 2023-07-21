public with sharing class SampleDataController {
    @AuraEnabled
    public static void importSampleData() {
        delete [SELECT Id FROM Car__c];
        delete [SELECT Id FROM Car_Type__c];
        //delete [SELECT Id FROM Account];

        insertAccounts();
        insertCarTypes();
        insertCars();
    }

    private static void insertAccounts() {
        StaticResource accountsResource = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = 'account_data'
        ];
        String accountsJSON = accountsResource.body.toString();
        List<Account> accounts = (List<Account>) JSON.deserialize(
            accountsJSON,
            List<Account>.class
        );
        insert accounts;
    }

    @testVisible
    private static void insertCarTypes() {
        StaticResource carTypesResource = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = 'car_type_data'
        ];
        String carTypesJSON = carTypesResource.body.toString();
        List<Car_Type__c> carTypes = (List<Car_Type__c>) JSON.deserialize(
            carTypesJSON,
            List<Car_Type__c>.class
        );
        insert carTypes;
    }

    private static void insertCars() {
        StaticResource carsResource = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = 'car_data'
        ];
        String carsJSON = carsResource.body.toString();
        List<Car__c> cars = (List<Car__c>) JSON.deserialize(
            carsJSON,
            List<Car__c>.class
        );
        insert cars;
    }

}