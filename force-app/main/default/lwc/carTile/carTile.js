import { LightningElement, api } from 'lwc';

const TILE_WRAPPER_SELECTED_CLASS = 'tile-wrapper selected';
const TILE_WRAPPER_UNSELECTED_CLASS = 'tile-wrapper';

export default class CarTile extends LightningElement {
    @api car;
    @api selectedCarId;
    
    // dynamically setting the background image for the picture
    get backgroundStyle() { 
        return 'background-image:url('+ this.car.Picture__c +')';
    }
    
    // if car is selected is selected set the tile class
    get tileClass() { 
        if (this.car.Id == this.selectedCarId) {
            return TILE_WRAPPER_SELECTED_CLASS;
        }
        return TILE_WRAPPER_UNSELECTED_CLASS;
    }
    
    // Fires event with the Id of the car that has been selected.
    selectCar() { 
        this.selectedCarId = this.car.Id;
        const carselect = new CustomEvent('carselect', {
            detail: {
                carId: this.selectedCarId
            }
        });
        this.dispatchEvent(carselect);
    }
}