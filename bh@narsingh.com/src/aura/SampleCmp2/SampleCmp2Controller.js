({
    doAction : function(component, event, helper) {
        //Get Parameters
        var params = event.getParam('arguments');
        if (params) {
            //Get Welcome message parameter
            var msg = params.message.message;
            var developerGroup = params.message.developerGroup;
            //Get name parameter
            var name = params.name;
            //Set welcome message and name
            component.set("v.msg", name + ' ' + msg + ' ' + developerGroup);
        }
    }
})