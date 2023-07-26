public without sharing class JSONSerializeHelper {
    private static Map<Id,Integer> accountIds = new Map<Id,Integer>();
    private static Map<Id,Integer> carTypeIds = new Map<Id,Integer>();

    private static String serializeObject(List<SObject> objs, List<String> fieldNames, Map<Id,Integer> ids) {
        JSONGenerator jsonObjs = JSON.createGenerator(true);
        jsonObjs.writeStartArray();
        Integer i = 0;
        for (Sobject obj : objs) {
            i++;
            jsonObjs.writeStartObject();
            for (String fieldName : fieldNames) {
                switch on fieldName {
                    when 'Number'{
                        jsonObjs.writeNumberField(fieldName,i);
                        ids.put(obj.Id,i);
                    }
                    when 'Name', 'Picture__c', 'Description__c'  {
                        jsonObjs.writeStringField(fieldName,(String)obj.get(fieldName));
                    }
                    when 'Price__c', 'Geolocation__Latitude__s', 'Geolocation__Longitude__s' {
                        jsonObjs.writeNumberField(fieldName,(Decimal)obj.get(fieldName));
                    }
                    when 'Account__c' {
                        jsonObjs.writeNumberField(fieldName,accountIds.get((Id)obj.get(fieldName)));
                    }
                    when 'Car_Type__c' {
                        jsonObjs.writeNumberField(fieldName,carTypeIds.get((Id)obj.get(fieldName)));
                    }
                } 
            }

            jsonObjs.writeEndObject();
         
        }
        jsonObjs.writeEndArray();
        return jsonObjs.getAsString();
    }

    private static void serializeAccounts() {
        List<Account> accounts = [SELECT Id,Name FROM Account WHERE id in (select account__c from Car__c)];

        String JSONStringAccounts = serializeObject(accounts,new List<String>{'Number','Name'},accountIds);


        System.debug('Serialized list of acccounts into JSON format: ' + JSONStringAccounts);
        saveJsonAsFile('accounts',JSONStringAccounts);

    }

    private static void serializeCarTypes() {

        String JSONStringCarTypes = serializeObject([SELECT Id,Name FROM Car_Type__c],
                                                            new List<String>{'Number','Name'},
                                                            carTypeIds);
        System.debug('Serialized list of car types into JSON format: ' + JSONStringCarTypes);
        saveJsonAsFile('car_types',JSONStringCarTypes);

    }

    private static void serializeCars() {

        String JSONStringCars = serializeObject([SELECT Name,Picture__c,Price__c,Description__c,Geolocation__Latitude__s,Geolocation__Longitude__s, Account__c, Car_Type__c FROM Car__c],
                                                            new List<String>{'Name','Picture__c','Price__c','Description__c','Geolocation__Latitude__s','Geolocation__Longitude__s','Account__c','Car_Type__c'},
                                                            new Map<Id,Integer>());
        System.debug('Serialized list of cars into JSON format: ' + JSONStringCars);
        saveJsonAsFile('cars',JSONStringCars);

    }

    public static void serializeCarsWithTypesAndAccounts() {
        
        serializeaccounts();
        serializeCarTypes();
        serializeCars();
    }    
    
    
    public static string saveJsonAsFile(String fileName, String JSONString){
        try {
            ContentVersion ContVerFile = new ContentVersion();
            ContVerFile.VersionData = Blob.valueOf(JSONString);
            ContVerFile.Title = fileName; 
            ContVerFile.ContentLocation= 's';
            ContVerFile.PathOnClient=fileName+'.txt';
            ContVerFile.FirstPublishLocationId = userinfo.getUserid();
            insert ContVerFile;
            return ContVerFile.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}