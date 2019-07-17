({
	searchHelper : function(comp,event,getInputkeyWord) {
        console.log('.searchHelper start..');
		var action=comp.get("c.fetchLookUpValues");
        var objName=comp.get("v.objectAPIName");
        action.setParams({'searchKeyword':getInputkeyWord,'objectName':objName});
        action.setCallback(this,function(response)
                           {
                           var state=response.getState();
                               console.log('.##state.'+state);
                               if(state==SUCCESS)
                               {
                                  var responseVal=response.getReturnValue();
                                  comp.set("v.listOfSearchRecords",responseVal);
                                  console.log('.##responseVal.'+responseVal); 
                               }
                           });
        // enqueue the Action  
        $A.enqueueAction(action);
	}
})