import { createElement } from 'lwc';
import CarSearchResult from 'c/carSearchResult';
import getCars from '@salesforce/apex/CarDataService.getCars';
// Realistic data with a list of cars
//const mockGetCarsList = require('./data/getCarsList.json');
// An empty list of records to verify the component does something reasonable
// when there is no data to display
//const mockGetCarsListNoRecords = require('./data/getCarsListNoRecords.json');
const ACCOUNT = {
    "Id":'123456',
    "Name":'Luxury'
}

const CAR_TYPE = {
    "Id":'123',
    "Name":'Luxury'
}

const MOCK_CARS = [
    {
        "Id": "id1",
        "Name": "Toyota Land Cruiser",
        "Picture__c": "https://avatars.mds.yandex.net/i?id=26a3b6fb262caa171c030d2c7d36750fc8e884ff-8208008-images-thumbs&n=13",
        "Price__c": 100,
        "Description__c": "Big off-road car",
        "Geolocation__Latitude__s": 41.7885950,
        "Geolocation__Longitude__s": 44.8171920,
        "Account__r": ACCOUNT,
        "Car_Type__r": CAR_TYPE
    },
    {
        "Id": "id2",
        "Name": "Toyota Land Cruiser2",
        "Picture__c": "https://avatars.mds.yandex.net/i?id=26a3b6fb262caa171c030d2c7d36750fc8e884ff-8208008-images-thumbs&n=13",
        "Price__c": 100,
        "Description__c": "Big off-road car",
        "Geolocation__Latitude__s": 41.7885950,
        "Geolocation__Longitude__s": 44.8171920,
        "Account__r": ACCOUNT,
        "Car_Type__r": CAR_TYPE
    }    
];
// Mock getCars Apex wire adapter
jest.mock(
    '@salesforce/apex/CarDataService.getCars',
    () => {
      const {
        createApexTestWireAdapter
      } = require('@salesforce/sfdx-lwc-jest');
      return {
        default: createApexTestWireAdapter(jest.fn())
      };
    },
    { virtual: true }
);

describe('c-car-search-result', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        // Prevent data saved on mocks from leaking between tests
        jest.clearAllMocks();
    });

    // Helper function to wait until the microtask queue is empty.
    // Used when having to wait for asynchronous DOM updates.
    async function flushPromises() {
        return Promise.resolve();
    }

    describe('getCarsList @wire data', () => {
        it('renders records', async () => {
            // Arrange
            const element = createElement('c-car-search-result', {
                is: CarSearchResult
            });

            // Act
            //element.cars = MOCK_CARS;
            document.body.appendChild(element);
            
            // Emit data from @wire
            getCars.emit(MOCK_CARS);

            // Wait for any asynchronous DOM updates
            await flushPromises();

            const carTileEls = element.shadowRoot.querySelectorAll('c-car-tile');
            expect(carTileEls.length).toBe(MOCK_CARS.length);
            expect(carTileEls[0].car.Name).toBe(MOCK_CARS[0].Name);
        });
    });
});