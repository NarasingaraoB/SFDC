({
	doAction : function(component, event, helper) {
		console.log('...start..');
        var eve=$A.get("e.c:SampleEvent");
        eve.setParams({"mesg":"Hello world"});
        eve.fire();
	}
})