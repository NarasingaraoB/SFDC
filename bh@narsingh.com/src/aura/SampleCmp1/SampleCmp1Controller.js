({
	doInit : function(component, event, helper) {
		console.log('.....sampleComp1');
        var msg="hi hello";
        var vfJsMethod=component.get("v.JsMethod");
        vfJsMethod(msg,function()
                   {
                       //handle callback
                   });
	}
})