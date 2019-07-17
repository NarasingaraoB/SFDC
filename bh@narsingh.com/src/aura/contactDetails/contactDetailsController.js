({
	doInit : function(component, event, helper) {
		console.log('initialize....');
        var action = component.get("c.fetchData");
        action.setCallback(this,function(response)
                           {
                               var state=response.getState();
                               console.log('state'+state);
                               console.log('val'+response.getReturnValue());
                               if(state==="SUCCESS")
                               {
                                   component.set("v.conList",response.getReturnValue());
                               }
                           });
         $A.enqueueAction(action);
	}
})