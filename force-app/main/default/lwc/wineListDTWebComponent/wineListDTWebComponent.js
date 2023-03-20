import { LightningElement, api, track } from 'lwc';
import updateWineList from '@salesforce/apex/WineListController.updateWineList';
import createNewWinelist from '@salesforce/apex/WineListController.createNewWinelist';
import updateWineListItems from '@salesforce/apex/WineListController.updateWineListItems';
//import updateWineListItem from '@salesforce/apex/WineListController.updateWineListItem';

export default class WineListDTWebComponent extends LightningElement {
    @track openActiveModal = false;
    @track openListingModal = false;
    @track openBottlePriceModal = false;
    @track openGlassPriceModal = false;
    @track openNewProductModal = false;
    
    @track activeValue = false;
    @track listingValue = '';
    @track bottlePrice;
    @track glassPrice;
    @track productId = '';

    @track listdata = [];

    @api records = [];
    @api winelist;
    @api fieldColumns = [
        { label: 'Product Name', fieldName: 'Product_Name__c', wrapText: true },
        { label: 'Active', type: "button",
        typeAttributes: {
            iconName: 'utility:edit',
            iconPosition: 'right',
            label: { fieldName: 'Active__c'},
            name: 'editActiveField',
        } 
        },
        { label: 'Listing', type: "button",
        typeAttributes: {
            iconName: 'utility:edit',
            iconPosition: 'right', 
            label: { fieldName: 'Listing__c'},
            name: 'editListingField',
        }
        },
        { label: 'Bottle Price', type: "button",
        typeAttributes: {
            iconName: 'utility:edit',
            iconPosition: 'right', 
            label: { fieldName: 'Bottle_Price__c'},
            name: 'editBottlePriceField',
        }
        },
        { label: 'Glass Price', type: "button",
        typeAttributes: {
            iconName: 'utility:edit',
            iconPosition: 'right', 
            label: { fieldName: 'Glass_Price__c'},
            name: 'editGlassPriceField',
        }
        },
    ];


    editRecord(event){
        this.productId = event.detail.row.Id; 
        const actionName = event.detail.action.name;
        if (actionName === 'editActiveField') { 
            this.activeValue = event.detail.row.Active__c;
            this.openActiveModal = true;
        } else if(actionName === 'editListingField') {
            this.listingValue = event.detail.row.Listing__c;
            this.openListingModal = true;
        }else if(actionName === 'editBottlePriceField') {
            this.bottlePrice = event.detail.row.Bottle_Price__c;
            this.openBottlePriceModal = true;
        }else if(actionName === 'editGlassPriceField') {
            this.glassPrice = event.detail.row.Glass_Price__c;
            this.openGlassPriceModal = true;
        }
    }

    handleActiveChange(event) {
        if(event.detail.value === 'true'){
            this.activeValue = true;
        } else {
            this.activeValue = false;
        }
    }
    
    get activeOptions() {
        return [
            { label: 'Active', value: true },
            { label: 'Inactive', value: false },
        ];
    }

    handleListingChange(event) {
        this.listingValue = event.detail.value;
    }

    get listingOptions() {
        return [
            { label: 'By the Glass', value: 'By the Glass' },
            { label: 'By the Bottle', value: 'By the Bottle' },
            { label: 'By Glass and Bottle', value: 'By Glass and Bottle' },
        ];
    }

    updateActiveStatus() {
        this.updateRecord('Active__c', this.activeValue);
        console.log("Testing active ",this.activeValue);

        var dataToApex1 = JSON.stringify(this.records);
        console.log("Check dataToAPex1: " + dataToApex1);
        //updateWineListItem(dataToApex1);
        
        console.log("Check salesforce record: " + this.records);
        console.log("Check salesforce record2: " + this.records[0]);
        console.log("Check salesforce record3: " + typeof this.records[0]);
        this.records.Active__c = false;
        var dataToApex = JSON.stringify(this.listdata);
        console.log("Test check ", dataToApex);
        updateWineListItems({"records"  : dataToApex1})
        .then(result => {
               console.log("Testing mgcini ",result);
        })
        .catch(error => {
            console.log("Test Mgcini ",error);
         });
        this.closeActiveModal();
    }

    closeActiveModal(){
        this.openActiveModal = false;
    }

    updateListing() {
      this.updateRecord('Listing__c',this.listingValue);
      console.log("Testing active ",this.listingValue);

      var dataToApex1 = JSON.stringify(this.records);
      console.log("Check dataToAPexListing: " + dataToApex1);
      //updateWineListItem(dataToApex1);
      
     
      
        updateWineListItems({"records"  : dataToApex1})
      .then(result => {
             console.log("Test Listing ",result);
      })
      .catch(error => {
          console.log("Test Fail Listing ",error);
       });

      this.closeListingModal();
    }

    closeListingModal(){
        this.openListingModal = false;
    }

    handleBottlePriceChange(event){
        this.bottlePrice = event.detail.value;
        console.log("Testing Bottle change===============>",this.bottlePrice);

    }

    updateBottlePrice(){
        this.updateRecord('Bottle_Price__c', this.bottlePrice);
        console.log("Testing Bottle ",this.bottlePrice);

        var dataToApex1 = JSON.stringify(this.records);
        console.log("Check dataToAPexBottle: " + dataToApex1);
        //updateWineListItem(dataToApex1);
        
       
        
          updateWineListItems({"records"  : dataToApex1})
        .then(result => {
               console.log("Test Bottle Price ",result);
        })
        .catch(error => {
            console.log("Test Fail Bottle Price ",error);
         });

        this.closeBottlePriceModal();
    }

    closeBottlePriceModal(){
        this.openBottlePriceModal = false;
    }

    handleGlassPriceChange(event){
        this.glassPrice = event.detail.value;
        console.log("Testing Bottle change===============>",this.glassPrice);
    }

    updateGlassPrice(){
        this.updateRecord('Glass_Price__c', this.glassPrice);
        console.log("Testing Glass ",this.bottlePrice);

        var dataToApex1 = JSON.stringify(this.records);
        console.log("Check dataToAPexGlass: " + dataToApex1);
        //updateWineListItem(dataToApex1);
        
       
        
          updateWineListItems({"records"  : dataToApex1})
        .then(result => {
               console.log("Test Glass Price ",result);
        })
        .catch(error => {
            console.log("Test Fail Glass Price ",error);
         });
        
        this.closeGlassPriceModal();
    }

    closeGlassPriceModal(){
        this.openGlassPriceModal = false;
    }

    
    updateRecord(columnName, updatedValue) {
        let tableData = JSON.parse(JSON.stringify(this.records)); 
        if(Array.isArray(tableData)) {    
           for(const obj of tableData){
            if(obj.Id === this.productId){
                obj[columnName] = updatedValue;
                break;   
            }
           }
        } else {
            obj[columnName] = updatedValue;
        }
        this.records = tableData;
    }

    //Create New WineList with Dates
   /*handleSave(event) {   
        //Old WineList
        const oldWineList = JSON.parse(JSON.stringify(this.winelist));
        oldWineList['Active__c'] = false;
        oldWineList['Status__c'] = 'Old';
        oldWineList['Start_Date__c'] = new Date(oldWineList['CreatedDate']).toISOString().split('T')[0];
        oldWineList['End_Date__c'] = new Date().toISOString().split('T')[0];
        updateWineList({obj: oldWineList}).then((result) => {
            console.log(result);
        }).catch((error) => {
            console.log(error);
        });

        //New Winelist
        const newWineList = JSON.parse(JSON.stringify(this.winelist));
        delete newWineList['Id'];
        delete newWineList['CreatedDate'];
        newWineList['Name'] = oldWineList['Name'];
        newWineList['Active__c'] = true;
        newWineList['Status__c'] = 'Current';
        newWineList['Start_Date__c'] = new Date().toISOString().split('T')[0];
        newWineList['End_Date__c'] = null;
        createNewWinelist({obj: newWineList}).then((result) => {
            //Add Winelist items to New Winelist
            let wineListItems = JSON.parse(JSON.stringify(this.records));
            for(const winelistItem of wineListItems) {
                delete winelistItem['Id'];
                winelistItem['AssortmentId'] = result;
                winelistItem['Bottle_Price__c'] = parseInt(winelistItem['Bottle_Price__c']);
                winelistItem['Glass_Price__c'] = parseInt(winelistItem['Glass_Price__c']);
            }

            const onlyActive = wineListItems.filter(x => x.Active__c == true);
            
            updateWineListItems({records: JSON.stringify(onlyActive)}).then((result) => {
                console.log(result);
            }).catch((error) => {
                console.log(error);
            }); 
        }).catch((error) => {
            console.log(error);
        });                    
    }*/

    openProductModel(){

    }
    addNewProduct(){

    }

}