import { LightningElement, api, track  } from 'lwc';
import updateWineListItem from '@salesforce/apex/WineListController.updateWineListItem';
export default class MobileWineListDTWebComponent extends LightningElement {

    @api records = [];
    @api winelist;
    
    @track openEditModal = false;
    @track id;
    @track active;
    @track isting;
    @track bottle;
    @track glass;
    
    assortmentId;

    get activeOptions() {
        return [
            { label: 'Active', value: true },
            { label: 'Inactive', value: false },
        ];
    }

    get listingOptions() {
        return [
            { label: 'By the Glass', value: 'By the Glass' },
            { label: 'By the Bottle', value: 'By the Bottle' },
            { label: 'By Glass and Bottle', value: 'By Glass and Bottle' },
        ];
    }

    productSelected(event){
        this.id = event.currentTarget.dataset.id;
        if(event.currentTarget.dataset.active === 'true'){
            this.active = true;
        } else {
            this.active = false;
        }
        this.assortmentId = event.currentTarget.dataset.assortment; 
        this.listing = event.currentTarget.dataset.listing;
        this.bottle = event.currentTarget.dataset.bottle;
        this.glass = event.currentTarget.dataset.glass;
        
        this.openEditModal = true;
    }

    closeEditModal(){
        this.openEditModal = false;
    }

    handleActiveChange(event) {
        if(event.detail.value === 'true'){
            this.active = true;
        } else {
            this.active = false;
        }
    }
    
    handleListingChange(event) {
        this.listing = event.detail.value;
    }

    handleBottlePriceChange(event){
        this.bottle = event.detail.value;
    }

    handleGlassPriceChange(event){
        this.glass = event.detail.value;
    }


    updateProduct() {
       this.closeEditModal();
    
       const product = {
         Id: this.id,
         AssortmentId: this.assortmentId,
         Active__c: this.active,
         Listing__c: this.listing,
         Bottle_Price__c: this.bottle,
         Glass_Price__c: this.glass
       };

        
        updateWineListItem({record: JSON.stringify(product)}).then((result) => {
            if(result ==='success'){
                let updateRecords = JSON.parse(JSON.stringify(this.records));
                for(const record of updateRecords){
                    if(product.Id == record.Id) {
                       record['Active__c'] = product.Active__c; 
                       record['Listing__c'] = product.Listing__c;
                       record['Bottle_Price__c'] = product.Bottle_Price__c;
                       record[' Glass_Price__c'] = product.Glass_Price__c;
                    }
                }
                this.records = [...updateRecords];
                console.log('wine list item updated'); 
            }
       }).catch((error) => {
          console.log(error);
       });
       
    
    }
}