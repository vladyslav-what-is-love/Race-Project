({
    setColumns : function(component) {
        component.set('v.columns',[
            {label:'Driver',fieldName:'fullName',type:'text'},
            {label:'Number of HatTricks',fieldName:'hatTricksNumber',type:'number'}
        ]);
    },

    getOpportunities:function(component,event,helper){
        var action = component.get("c.getHatTricks");

        action.setCallback(this, function(response){
            var drivers = [];
            response.getReturnValue().forEach(function callback(currentValue) {
                var obj = {};
                obj['id'] = currentValue.Id;
                obj['fullName'] = currentValue.Full_Name__c;
                obj['hatTricksNumber'] = currentValue.HatTricks__c;
                drivers.push(obj);
            })
            component.set("v.drivers",drivers);
        });
        $A.enqueueAction(action);
    }
})




