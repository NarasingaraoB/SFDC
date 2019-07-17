({
	doInit : function(component, event, helper) {
		console.log('start intialize component..');
        helper.fetchData(component, event, helper);
	}
})