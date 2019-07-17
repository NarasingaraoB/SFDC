({
	serverCall : function(component, event, helper) {
		 console.log('controller-serverCall- helper is ready...');
        var target=event.target;
        var searchText=target.value;
        var last_SearchText =component.get("v.last_SearchText ");
        console.log('..target..'+target);
        console.log('..searchText..'+searchText);
        console.log('..eventkey code..'+event.keyCode);
        if(event.keyCode=='27' && !searchText.trim())
        {
            helper.clearSelection(component, event, helper);
        }
            else if(searchText.trim()!=last_SearchText && /\s+$/.test(searchText) )
        {
            console.log('..ready for search...');
            var ObjectName=component.get("v.ObjectName");
            var field_API_text=component.get("v.field_API_text");
            var field_API_value=component.get("v.field_API_value");
            var limit=component.get("v.limit");
            var field_API_search=component.get("v.field_API_search");
            var action = component.get("c.searchDB");
            action.setParams({
                ObjectName:ObjectName,
                field_API_text:field_API_text,
                field_API_value:field_API_value,
                field_API_search:field_API_search,
                searchText:searchText.trim(),
                lmt:limit
            	});
            action.setCallback(this,function(response)
                               {
                                 helper.hanldeResponse(response,component,helper);  
                               });
            component.set("v.last_SearchText",searchText.trim());
            console.log('Server call made');
            $A.enqueueAction(action);
        }
	},
    clearSelection : function(component, event, helper) {
		 console.log('controller-clearSelection- helper is ready...');
       
	},
    hanldeResponse : function(response, component, helper) {
		 console.log('controller-hanldeResponse- helper is ready...');
        console.log('..res..'+response.getState());
       if(response.getState()==="SUCCESS")
       {
           var result=response.getReturnValue();
           console.log('..result.'+result);
           component.set("v.server_result",result);
       }
	},
    itemSelected : function(component, event, helper) {
		 console.log('controller-itemSelected- helper is ready...');
       
	}
})