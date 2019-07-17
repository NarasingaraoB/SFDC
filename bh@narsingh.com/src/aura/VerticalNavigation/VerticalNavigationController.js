({
	doInit : function(component, event, helper) {
		console.log('..start...');
        var action =component.get("c.AccountList");
        action.setCallback(this,function(response)
                           {
                           var state=response.getState();
                               console.log('..'+state);
        					if(state==="SUCCESS")
                            {
                                var result = response.getReturnValue();
                                component.set("v.accList", result);
                            }
                           });
        $A.enqueueAction(action);
	},
    handleBeforeSelect : function(component, event, helper) {
		component.set("v.beforeSelItem",component.get("v.selectedaccId"));
        console.log('.handleBeforeSelect.'+component.get("v.selectedaccId"));
	},
    handleOnSelect : function(component, event, helper) {
		component.set("v.OnSelItem","onselect");
        console.log('.handleOnSelect.'+component.get("v.beforeSelItem"));
	}
})