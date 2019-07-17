({
	BEvent : function(cmp, event) { 
        //Get the event message attribute
        var message = event.getParam("param1"); 
        //Set the handler attributes based on event data 
        cmp.set("v.UName", 'Welcome' +message );         
    }
})