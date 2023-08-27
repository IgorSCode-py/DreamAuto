import { createElement } from 'lwc';
import CarSearchForm from 'c/carSearchForm';
import getCarTypes from '@salesforce/apex/CarDataService.getCarTypes';
// Realistic data with a list of car types
const mockGetCarTypesList = require('./data/getCarTypesList.json');
// An empty list of records to verify the component does something reasonable
// when there is no data to display
const mockGetCarTypesListNoRecords = require('./data/getCarTypesListNoRecords.json');

const CAR_TYPE = {
  "Id":'123',
  "Name":'Luxury'
}

// Mock getCarTypes Apex wire adapter
jest.mock(
    '@salesforce/apex/CarDataService.getCarTypes',
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

describe('c-car-search-form', () => {
    afterEach(() => {
        while (document.body.firstChild) {
          document.body.removeChild(document.body.firstChild);
        }
        // Prevent data saved on mocks from leaking between tests
        jest.clearAllMocks();
      });
    
    // Helper function to wait until the microtask queue is empty.
    // Used when having to wait for asynchronous DOM updates.

    
    describe('getCarTypesList @wire data', () => {

      it('renders records', () => {
        const element = createElement('c-car-search-form', {
          is: CarSearchForm
        });
        document.body.appendChild(element);
          
        // Emit data from @wire
        getCarTypes.emit(mockGetCarTypesList);
          
        return Promise.resolve().then(() => {
          // Select elements for validation
          const carTypesElement = element.shadowRoot.querySelector('lightning-combobox');
          expect(carTypesElement.options.length).toBe(mockGetCarTypesList.length+1);
          expect(carTypesElement.options[0].label).toBe('All Types');
        });
      });
      it('renders items when no records are returned', () => {
        const element = createElement('c-car-search-form', {
          is: CarSearchForm
        });
        document.body.appendChild(element);
          
        // Emit data from @wire
        getCarTypes.emit(mockGetCarTypesListNoRecords);
          
        return Promise.resolve().then(() => {
          // Select elements for validation
          const carTypesElement = element.shadowRoot.querySelector('lightning-combobox');
          expect(carTypesElement.options.length).toBe(1);
          expect(carTypesElement.options[0].label).toBe('All Types');
        });
      });
    });
    describe('getCarTypesList @wire error', () => {
        it('shows error panel element', () => {
          const element = createElement('c-car-search-form', {
            is: CarSearchForm
          });
          document.body.appendChild(element);
            
          // Emit error from @wire
          getCarTypes.error();
            
          return Promise.resolve().then(() => {
            const carTypesElement = element.shadowRoot.querySelector('lightning-combobox');
            expect(carTypesElement.options).toBe(undefined);
          });
        });
    });
    describe('firing the event', () => {
      async function flushPromises() {
        return Promise.resolve();
      }
      it('Fires the event on click', async () => {
        const element = createElement('c-car-search-form', {
            is: CarSearchForm
        });
        //element.searchOptions = CAR_TYPE;
        document.body.appendChild(element);
        
        const handler = jest.fn();
        element.addEventListener('search', handler);

        const anchorEl = element.shadowRoot.querySelector('lightning-combobox');
        anchorEl.dispatchEvent(new CustomEvent('change', {
                          detail: CAR_TYPE
                          }));             

        await flushPromises();
    
        // Validate if event got fired
        expect(handler).toHaveBeenCalled();
        const selectEvent = handler.mock.calls[0][0];
        expect(selectEvent.detail.carTypeId).toBe(CAR_TYPE.id);

      });
  });
});