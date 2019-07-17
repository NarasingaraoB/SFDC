({
	childAction : function(component, event, helper) {
        var eve=$A.get("e.c:event2");
        eve.setParams({"param2":"This is child comp"});
        eve.fire();
	}
})