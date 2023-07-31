@isTest
public class CarDataServiceTest {
    @isTest static void TestGetTypesPositive() {
        Integer numTypes = 3;
        List<Car_Type__c> testTypes = TestDataFactory.createCarTypes(numTypes);
        

        
        List<Car_Type__c> actualTypes;
        System.runAs(new User(Id = UserInfo.getUserId())) {
			Test.startTest();
            
        	actualTypes = CarDataService.getCarTypes();
            
            Test.stopTest();
        }
        
        System.assertEquals(numTypes, actualTypes.size());
    }

    @isTest static void TestGetCarsWithoutTypeSelectedPositive() {
        Integer numCars = 3;
        List<Car__c> testCars = TestDataFactory.createCarsWithTypesAndAccounts(numCars);
        

        List<Car__c> actualCars;
               
        
		System.runAs(new User(Id = UserInfo.getUserId())) {
			Test.startTest();
            
        	actualCars = CarDataService.getCars('');
            
            Test.stopTest();
        }
        
        System.assertEquals(numCars, actualCars.size());
    }
    
    @isTest static void TestGetCarsWithTypeSelectedPositive() {
        Integer numCars = 3;
        List<Car__c> testCars = TestDataFactory.createCarsWithTypesAndAccounts(numCars);
        

        List<Car__c> actualCars;
        
        System.runAs(new User(Id = UserInfo.getUserId())) {
			Test.startTest();
            
        	actualCars = CarDataService.getCars(testCars[1].Car_Type__c);
            
            Test.stopTest();
        }
        
        System.assertEquals(1, actualCars.size());
        System.assertEquals(testCars[1].id, actualCars[0].id);
        System.assertNotEquals(testCars[0].id, actualCars[0].id);
    }
    @isTest static void TestGetCarsWithTypeSelectedNegative() {
        Integer numCars = 3;
        List<Car__c> testCars = TestDataFactory.createCarsWithTypesAndAccounts(numCars);

        List<Car__c> actualCars;
        
        System.runAs(new User(Id = UserInfo.getUserId())) {
			Test.startTest();
            
        	actualCars = CarDataService.getCars('6$87656');
            
           	Test.stopTest(); 
        }
        
        System.assertEquals(0, actualCars.size());
    }
}