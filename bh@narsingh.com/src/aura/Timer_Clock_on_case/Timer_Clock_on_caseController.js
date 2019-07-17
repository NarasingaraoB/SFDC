({
	doInit : function(component, event, helper) {
      var action = component.get("c.fetchStatusChangeTime");
        action.setParams({ "recordId"   : component.get("v.recordId") });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state=='SUCCESS'){
                var timeFormateString=response.getReturnValue();
                console.log('recieved datetime is '+timeFormateString);
                var timeformate = timeFormateString.split(":");
                var duration=parseInt(timeformate[0]);
                var h=parseInt(timeformate[0]);
                var m=parseInt(timeformate[1]);
                var s=parseInt(timeformate[2]);
                console.log(' hour:',h);
                console.log(' minute:',m);
                console.log(' second:',s);
                if(h!=0 && h!=0 && s!=0){
                    if(h<2||(h==2&&m==0&&s==0)){
                       h=1-h;
                       h=h<0?0:h;
                       m=59-m;
                       s=59-s;
                       component.set('v.timeLeft',true);
                    var clock = component.find('timer');
                    $A.util.removeClass(clock, 'clockOverdue');
                    helper.setClock(component,h,m,s);
                }else{
                    h=h-2;
                    h=h==24?0:h;
                    var clock = component.find('timer');
                    $A.util.addClass(clock, 'clockOverdue');
                    component.set('v.timeOverDue',true);
                    helper.setClock(component,h,m,s);
                }  
                }else{
                    var hourFormate = (h < 10) ? "0" + h : h;
                    var minFormate = (m < 10) ? "0" + m : m;
                    var seconfdFormate = (s < 10) ? "0" + s : s;
                    var time = hourFormate + ":" + minFormate + ":" + seconfdFormate ;
                    component.set('v.clock',time); 
                }
         
            }
        });
        $A.enqueueAction(action);  
       
}
})