@isTest 
private with sharing class CarRESTServiceTest {
    
    @isTest
    static void httpCalloutGetCarsToReturnPositive() {
        TestDataFactory.createCarsWithTypesAndAccounts(5);
        //Account newAccount = new Account();
        //TestDataFactory.createCarsWithTypesAndAccounts(3,newAccount);
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/car-integration-service/';
        request.httpMethod = 'GET';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CarRESTService.getCarsToReturn();
        List<Car__c> carRecords = (List<Car__c>) JSON.deserialize(
            calloutResponse,
            List<Car__c>.class
        );
        Test.stopTest();

        System.Assert.areEqual(
            Car__c.SObjectType,
            carRecords.getSObjectType(),
            'Car__c object was not returned'
        );
        System.Assert.areEqual(
            5,
            carRecords.size(),
            'The correct number of cars was not returned, expected 5, got ' +
            carRecords.size()
        );
    }
    
    @isTest
    static void httpCalloutDeleteSingleContactPositive() {
        SObject car = (SObject) TestDataFactory.createCarsWithTypesAndAccounts(1)[0];
        RestRequest request = new RestRequest();
        System.debug(LoggingLevel.INFO, car.Id);
        request.requestUri =
            '/services/apexrest/car-integration-service/' + car.Id;
        request.httpMethod = 'DELETE';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CarRESTService.deleteSingleCar();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        System.Assert.areEqual(
            'Successful Delete',
            calloutResponse,
            'Expected successful delete'
        );
    }

    @isTest
    static void httpPostParseAndCreateNewCarsPositive() {

        List<Car__c> carList = TestDataFactory.createCarsWithTypesAndAccounts(5, false);

        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/car-integration-service/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(JSON.serialize(carList));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CarRESTService.parseAndCreateNewCars();
        Test.stopTest();

        System.Assert.areEqual(
            'Successful Insert',
            calloutResponse,
            'Expected response to be: "Successful Insert"'
        );
    }

    @isTest
    static void httpPutUpsertContactRecordsPositive() {

        TestDataFactory.createCarsWithTypesAndAccounts(5, false);

        List<Car__c> carsToUpdate = new List<Car__c>();
        for (Car__c car : [SELECT Id FROM Car__c LIMIT 5]) {
            car.ExternalCarId__c = car.Id;
            carsToUpdate.add(car);
        }
        update carsToUpdate;
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/car-integration-service/';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(JSON.serialize(carsToUpdate));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CarRESTService.upsertCarRecords();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        System.Assert.areEqual(
            'Successful Upsert',
            calloutResponse,
            'Expected response to be: "Successful Upsert"'
        );
    }
}