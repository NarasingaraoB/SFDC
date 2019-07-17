({
	myAction : function(component, event, helper) {
		console.log('..sample....');
        var param=helper.getJsonFromURL().myParam;
        console.log('..param.'+param);
        component.set("v.param",param);
	}
})