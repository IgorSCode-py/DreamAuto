import { LightningElement } from 'lwc';

export default class CarSearch extends LightningElement {
    isLoading = false;
  
    // Handles loading event for spinner
    handleLoading() {
        this.isLoading = true;
    }
    
    // Handles done loading event for spinner
    handleDoneLoading() { 
        this.isLoading = false;
    }
    
    // Handles search car event
    // This custom event comes from the form
    searchCars(event) { 
        const carTypeId = event.detail.carTypeId;
        this.template.querySelector("c-car-search-result").searchCars(carTypeId);
    }
    
}
