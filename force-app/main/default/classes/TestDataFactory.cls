@isTest
public class TestDataFactory {
	public static List<Car__c> createCarsWithTypesAndAccounts(Integer numItems) {
        List<Account> accounts = new List<Account>();
        for(Integer i=0;i<numItems;i++) {
        	Account newAccount = new Account();
        	newAccount.Name = 'Test'+i;
            accounts.add(newAccount);
        }
        insert accounts;
        
        List<Car_Type__c> types = new List<Car_Type__c>();
        for (Integer i=0;i<numItems;i++) {
        	Car_Type__c newType = new Car_Type__c();
        	newType.Name = 'Test'+i;
            types.add(newType);
        }        
		insert types;
        
        List<Car__c> cars = new List<Car__c>();
        for (Integer i=0;i<numItems;i++) {
        	Car__c newCar = new Car__c();
        	newCar.Name = 'Test'+i;
            newCar.Account__c = accounts[i].id;
            newCar.Car_Type__c = types[i].id;
            cars.add(newCar);
        }        
		insert cars;
        
        return cars;
    }
    
    public static List<Car_Type__c> createCarTypes(Integer numItems) {
    
        List<Car_Type__c> types = new List<Car_Type__c>();
        for (Integer i=0;i<numItems;i++) {
        	Car_Type__c newType = new Car_Type__c();
        	newType.Name = 'Test'+i;
            types.add(newType);
        }        
		insert types;
                
        return types;
    }
        
}