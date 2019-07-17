({
	AEvent : function(cmp, event,helper) { 
        //Get the event using event name. 
        var appEvent = $A.get("e.c:event1"); 
        //Set event attribute value
        appEvent.setParams({"param1" : cmp.get("v.userName")}); 
        appEvent.fire(); 
    }
})