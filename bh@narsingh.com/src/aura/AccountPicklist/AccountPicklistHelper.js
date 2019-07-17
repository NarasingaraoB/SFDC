({
	getPickList : function(component, event) {
		var action =component.get("c.pickList");
        action.setCallback(this,function(res)
                           {
                              var state = res.getState(); 
                               console.log('.st.'+state);
                               component.set("v.leadS",res.getReturnValue());
                           });
        $A.enqueueAction(action);
	}
})