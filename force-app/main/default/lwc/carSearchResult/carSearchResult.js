import { LightningElement, wire, api } from 'lwc';
import getCars from '@salesforce/apex/CarDataService.getCars';
import { refreshApex } from '@salesforce/apex';
import {
  publish,
  MessageContext
} from 'lightning/messageService';
import CarMC from '@salesforce/messageChannel/CarMessageChannel__c';

export default class CarSearchResult extends LightningElement {
    selectedCarId;

    @api
    carTypeId = '';

    cars;
    isLoading = false;
    

    @wire(MessageContext)
    messageContext;

    // wired Apex getCars method 
    @wire(getCars,{carTypeId: '$carTypeId'})
    wiredCars(result) {
      this.cars = result.data;
    }
    
    @api
    searchCars(carTypeId) {
      this.isLoading = true;
      this.notifyLoading(this.isLoading);

      this.carTypeId = carTypeId;

      this.isLoading = false;
      this.notifyLoading(this.isLoading);
    }
    
    @api
    async refresh() {
     /* this.isLoading = true;
      this.notifyLoading(this.isLoading);
      await refreshApex(this.cars);
      this.isLoading = false;
      this.notifyLoading(this.isLoading);
      */
    }
    
    updateSelectedTile(event) {
      this.selectedCarId = event.detail.carId;
      this.sendMessageService(this.selectedCarId);
    }
    
    // Publishes the selected car Id on the CarMC.
    sendMessageService(carId) { 
      publish(this.messageContext, CarMC, { recordId: carId });
    }
    
    // Check the current value of isLoading before dispatching the doneloading or loading custom event
    notifyLoading(isLoading) {
      if (isLoading) {
        this.dispatchEvent(new CustomEvent('loading'));
      }
      else {
        this.dispatchEvent(new CustomEvent('doneloading'));
      }      
      
    }
}