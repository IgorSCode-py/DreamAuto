import { LightningElement, wire } from 'lwc';
import getCarTypes from '@salesforce/apex/CarDataService.getCarTypes';

export default class CarSearchForm extends LightningElement {
    selectedCarTypeId = '';
    error;
    searchOptions;

     // Wire Apex method getCarTypes
    @wire(getCarTypes)
    carTypes({ error, data }) {
      if (data) {
        this.searchOptions = data.map(type => {
          return {
            label: type.Name,
            value: type.Id
          };
        });
        this.searchOptions.unshift({ label: 'All Types', value: '' });
      } else if (error) {
        this.searchOptions = undefined;
        this.error = error;
      }
    }

    handleSearchOptionChange(event) {
        event.preventDefault();
        this.selectedCarTypeId = event.detail.value;

        const searchEvent = new CustomEvent('search', {
          detail: { carTypeId: this.selectedCarTypeId }
        });
        this.dispatchEvent(searchEvent);
      }
}