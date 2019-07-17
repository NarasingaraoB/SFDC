({
	onFocus : function(component, event, helper) {
		var getInputkeyWord='';
        helper.searchHelper(component, event,getInputkeyWord);
	},
    keyPressController : function(component, event, helper) {
		var getInputkeyWord='t';
        console.log('getInputkeyWord');
        
        helper.searchHelper(component, event,getInputkeyWord);
	},
})