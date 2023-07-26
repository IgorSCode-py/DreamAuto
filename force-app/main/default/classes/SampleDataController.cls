public with sharing class SampleDataController {
    private static Map<Integer,Account> accIds = new Map<Integer,Account>();
    private static Map<Integer,Car_Type__c> carTypeIds = new Map<Integer,Car_Type__c>();

    @AuraEnabled
    public static void importSampleData() {
        List<Car__c> cars = [SELECT Id FROM Car__c];
        List<Account> accs = [SELECT Id FROM Account WHERE Id in (Select Account__c From Car__c)];
        
        delete cars;
        delete accs;
        delete [SELECT Id FROM Car_Type__c];
        

        insertAccounts();
        insertCarTypes();
        insertCars();
    }

    private static String getJSONStringFromStaticResource(String resourceName) {
        StaticResource accountsResource = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = :resourceName
        ];
        return accountsResource.body.toString();
    }

    private static void insertAccounts() {
        
        insertRecords(getJSONStringFromStaticResource('account_data'),'Account');
    }
    
    private static void insertCarTypes() {

        insertRecords(getJSONStringFromStaticResource('car_type_data'),'Car_Type__c');
    }

    private static void insertCars() {

        insertRecords(getJSONStringFromStaticResource('car_data'),'Car__c');
    }
    
    private static void insertRecords(String objectsJSON, String objType) {
        
        JSONParser parser = JSON.createParser(objectsJSON);
		List<SObject> objs;
        SObject obj;
        Integer i = 0;
        while (parser.nextToken() != null) {
            switch on parser.getCurrentToken() {
                when START_ARRAY {
                    if (objType == 'Account') {
                    	objs = new List<Account>();
                    }
                    else if (objType == 'Car_Type__c') {
                        objs = new List<Car_Type__c>();
                    }
                    else {
                        objs = new List<Car__c>();
                    }
                }
                when START_OBJECT {
                    if (objType == 'Account') {
                    	obj = new Account();
                    }
                    else if (objType == 'Car_Type__c') {
                        obj = new Car_Type__c();
                    }
                    else {
                        obj = new Car__c();
                    }
                	i++;
                }
                when END_OBJECT {
                    objs.add(obj);
                }
                when FIELD_NAME {
                    String fieldName = parser.getText();
                    switch on fieldName {
                    	when 'Number' {
                        	parser.nextToken();
                        	Integer objNum = Integer.valueOf(parser.getText());
                            if (objType == 'Account') {
                        		accIds.put(objNum, (Account)obj);
                            }
                            else {
                                carTypeIds.put(objNum, (Car_Type__c)obj);
                            }
                        	//System.debug('Number');
                        	//System.debug(objNum);
                    	}
                        when 'Name', 'Picture__c', 'Description__c' {
                        	parser.nextToken();
	                       	obj.put(fieldName,parser.getText());
                       	}
                        when 'Price__c', 'Geolocation__Latitude__s', 'Geolocation__Longitude__s' {//
                        	parser.nextToken();
	                       	obj.put(fieldName,parser.getDecimalValue());
                       	}
                        when 'Account__c' {
                            parser.nextToken();
	                       	obj.put(fieldName,accIds.get(parser.getIntegerValue()).get('Id'));
                    	}
                        when 'Car_Type__c' {
                            parser.nextToken();
	                       	obj.put(fieldName,carTypeIds.get(parser.getIntegerValue()).get('Id'));
                    	}
                	}
                }
            }
            


        }

        insert objs;
    }


 


    @testVisible
    private static void insertCarTypes2() {
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

    private static void insertCars2() {
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