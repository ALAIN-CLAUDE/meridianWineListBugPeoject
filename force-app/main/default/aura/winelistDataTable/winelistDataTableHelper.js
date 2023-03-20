({
    setupTable: function (component) {
        var action = component.get("c.getPicklistValues");
        action.setParams({
            objectAPIName: "AssortmentProduct",
            fieldAPIName: "Active__c"
        },
         {
            objectAPIName: "AssortmentProduct",
            fieldAPIName: "Listing__c"
        });
        action.setCallback(this, function (response) {
            if (response.getState() === "SUCCESS") {
                var activeOptions = [{label:'Active',value:true}, {label:'Inactive',value:false}];
                var listingOptions = [{label:'By the Glass', value: 'By the Glass'},{label:'By the Bottle', value:'By the Bottle'}, {label:'By Glass and Bottle',value:'By Glass and Bottle'},];                     
                Object.entries(response.getReturnValue()).forEach(([key, value]) => types.push({ label: key, value: value }));
                var cols = [
                    { label: "ID", fieldName: "ProductId", sortable: true },
                    { label: "Product Name", fieldName: "Product_Name__c", sortable: true },
                    { label: "Active", fieldName: "Active__c", sortable: true, editable: true, type: "picklist", selectOptions: activeOptions},
                    { label: "Listing", fieldName: "Listing__c", editable: true, type: "picklist", selectOptions: listingOptions},
                    { label: "Bottle Price", fieldName: "Bottle_Price__c", editable: true },
                    { label: "Glass Price", fieldName: "Glass_Price__c", editable: true },
                ];
                component.set("v.columns", cols);
                this.loadRecords(component);
            } else {
                var errors = response.getError();
                var message = "Error: Unknown error";
                if (errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: " + errors[0].message;
                component.set("v.error", message);
                console.log("Error: " + message);
            }
        });
        $A.enqueueAction(action);
    },

    loadRecords: function (component) {
        var action = component.get("c.getRecords");
        action.setCallback(this, function (response) {
            if (response.getState() === "SUCCESS") {
                var allRecords = response.getReturnValue();
                component.set("v.data", allRecords);
                component.set("v.isLoading", false);
            } else {
                var errors = response.getError();
                var message = "Error: Unknown error";
                if (errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: " + errors[0].message;
                component.set("v.error", message);
                console.log("Error: " + message);
            }
        });
        $A.enqueueAction(action);
    },
    
})