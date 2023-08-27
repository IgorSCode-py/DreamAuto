import { createElement } from 'lwc';
import CarTile from 'c/carTile';

const ACCOUNT = {
    "Id":'123456',
    "Name":'Luxury'
}

const CAR_TYPE = {
    "Id":'123',
    "Name":'Luxury'
}

const CAR_TILE_INPUT = {
    "Id":'12345',
    "Name" : "Toyota Land Cruiser",
    "Picture__c" : "https://avatars.mds.yandex.net/i?id=26a3b6fb262caa171c030d2c7d36750fc8e884ff-8208008-images-thumbs&n=13",
    "Price__c" : 100.00,
    "Description__c" : "Big off-road car",
    "Geolocation__Latitude__s" : 41.7885950,
    "Geolocation__Longitude__s" : 44.8171920,
    "Account__r" : ACCOUNT,
    "Car_Type__r" : CAR_TYPE
};

describe('c-car-tile', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });
    // Helper function to wait until the microtask queue is empty.
    // Used when having to wait for asynchronous DOM updates.
    async function flushPromises() {
        return Promise.resolve();
    }
    
    it('renders picture, Name, Account, Car_Type', () => {
        // Create component
        const element = createElement('c-car-tile', {
            is: CarTile
        });
        // Set public property
        element.car = CAR_TILE_INPUT;
        document.body.appendChild(element);

        // Select elements for validation
        const detailEl = element.shadowRoot.querySelector('.tile');
        expect(detailEl.style.backgroundImage).toBe(`url(${CAR_TILE_INPUT.Picture__c})`);

        const detailH1 = element.shadowRoot.querySelector('.slds-text-heading_medium');
        expect(detailH1.textContent).toBe(CAR_TILE_INPUT.Name);

        const detailH2 = element.shadowRoot.querySelector('h2');
        expect(detailH2.textContent).toBe(CAR_TILE_INPUT.Account__r.Name);
        
        const detailType = element.shadowRoot.querySelector('.slds-text-body_small');
        expect(detailType.textContent).toBe(`Type: ${CAR_TILE_INPUT.Car_Type__r.Name}`);

    });
    it('Fires the event on click', async () => {
        const element = createElement('c-car-tile', {
            is: CarTile
        });
        element.car = CAR_TILE_INPUT;
        document.body.appendChild(element);

        // Mock handler for child event
        const handler = jest.fn();
        element.addEventListener('carselect', handler);

        const anchorEl = element.shadowRoot.querySelector('.tile-wrapper');
        // Validate not selected class
        expect(anchorEl.className).toBe('tile-wrapper');
        
        anchorEl.click();

        // Wait for any asynchronous DOM updates
        await flushPromises();

        // Validate if event got fired
        expect(handler).toHaveBeenCalled();
        const selectEvent = handler.mock.calls[0][0];
        expect(selectEvent.detail.carId).toBe(CAR_TILE_INPUT.Id);
        // Validate selected class
        expect(anchorEl.className).toBe('tile-wrapper selected');
    });
});