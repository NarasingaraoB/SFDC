({
	serverCall : function(component, event, helper) {
      
        console.log('controller is ready...');
		helper.serverCall(component, event, helper);
	},
    itemSelected  : function(component, event, helper) {
      
        console.log('controller is ready.for.item selected.');
		helper.itemSelected(component, event, helper);
	},
})