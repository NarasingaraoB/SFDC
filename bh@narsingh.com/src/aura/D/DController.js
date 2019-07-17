({
	ParentAction : function(component, event, helper) {
		var param2=event.getParam("param2");
        component.set("v.message",param2);
	}
})