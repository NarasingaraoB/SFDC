({
	fetchData : function(component, event, helper) {
		console.log('initialize helper start..');
        var recId=component.get("v.recordId");
        var action = component.get("c.initData")
        action.setParams({recordID : recId});
       action.setCallback(this, function(response) {
            var state = response.getState();
           var retVal=response.getReturnValue();
           
            if (state === "SUCCESS") {
                console.log('..success..');
                console.log('..retVal..'+retVal);
                console.log('..length..'+retVal.length);
                
                component.set("v.conList",retVal);
            }
                           });
        $A.enqueueAction(action);
	}
})