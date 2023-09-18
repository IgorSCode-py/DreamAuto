@RestResource(urlmapping='/car-integration-service/*')
global with sharing class CarRESTService {

    //private static String getAccountId() {
        //in the future I am going to get it from the user's authentification
    //    return '0015t00001A12bKAAR';
    //}

    @HttpGet
    global static String getCarsToReturn() {

        // Instantiate the RestResponse
        RestResponse response = RestContext.response;
        List<Car__c> cars = [
            SELECT Id, Name
            FROM Car__c
            //WHERE Account__c = :accountId
        ];

        // Manually set the status code
        response.statusCode = 200;
        String serializedCars = JSON.serialize(cars);

        return serializedCars;

    }
    
    @HttpDelete
    global static String deleteSingleCar() {
        // Get the details of the RestRequest from the RestContext
        RestRequest request = RestContext.request;
        // We can get the Id of the car from the URL params by isolating the
        // requestUri from the RestRequest
        String recordId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1
        );
        RestResponse response = RestContext.response;


        // We can query the Car__c against the Id sent in the request and
        // check that it was found
        List<Car__c> cars = [
            SELECT Id
            FROM Car__c
            WHERE Id = :recordId
            LIMIT 1
        ];
        Car__c car = (cars.size() == 1) ? cars.get(0) : null;
        delete car;
        response.statusCode = 200;
        return 'Successful Delete';
    }

    @HttpPost
    global static String parseAndCreateNewCars() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String requestBody = request.requestBody.toString();
        // Deseralize the requestBody into a list of Cars
        List<Car__c> carRecords = (List<Car__c>) JSON.deserialize(
            requestBody,
            List<Car__c>.class
        );

        // insert the Cars
        insert carRecords;
        response.statusCode = 200;
        return 'Successful Insert';
    }
    
    @HttpPut
    global static String upsertCarRecords() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String requestBody = request.requestBody.toString();
        // Deserialize the requestBody into a list of Cars
        List<Car__c> carRecords = (List<Car__c>) JSON.deserialize(
            requestBody,
            List<Car__c>.class
        );

        // upsert the Cars by their ExternalId__c
        upsert carRecords ExternalCarId__c;
        response.statusCode = 200;
        return 'Successful Upsert';

    }
}