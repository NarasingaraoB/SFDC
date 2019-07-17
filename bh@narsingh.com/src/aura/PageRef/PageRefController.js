({
	doInit : function(component, event, helper) {
        var rTypeId=component.get("v.pageReference").state.recordTypeId;
		console.log('...'+rTypeId);
        component.set("v.recTypeId",rTypeId);
         var rAction=component.get("v.pageReference").attributes.actionName;
		console.log('...'+rAction);
        component.set("v.recAction",rAction);
         var rObjAPi=component.get("v.pageReference").attributes.objectApiName;
		console.log('...'+rObjAPi);
        component.set("v.recObject",rObjAPi);
	}
})