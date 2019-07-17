({
    setClock : function(component,h,m,s) {
        var self=this;
        var timeleftClock=component.get('v.timeLeft');
        var timeOverDueClock=component.get('v.timeOverDue');
        var interval = setInterval($A.getCallback(function () {
             var timeleftClock=component.get('v.timeLeft');
            if(timeleftClock){
                self.runTimeLeftClock(component,h,m,s); 
            }
            else if(timeOverDueClock){
               self.runTimeOverDueClock(component,h,m,s); 
            }
             
            h= component.get('v.Hour');
            m= component.get('v.Minute');
            s= component.get('v.Seconds');
            /* var progress = component.get('v.progress');
            var progress=100-Math.floor((((h*60*60)+(m*60))/(duration*60*60))*100);
            if(progress==100){
                component.set('v.progress', progress);
                clearInterval(interval);
                helper.clearWorkFlowAction(component);
            }*/
            
            // component.set('v.progress', progress == 100 ? clearInterval(interval) : progress);
            if(h==0&&m==0&&s==0){
                component.set('v.timeLeft',false);
                component.set('v.timeOverDue',true);
            }
            var hourFormate = (h < 10) ? "0" + h : h;
            var minFormate = (m < 10) ? "0" + m : m;
            var seconfdFormate = (s < 10) ? "0" + s : s;
            var time = hourFormate + ":" + minFormate + ":" + seconfdFormate ;
            component.set('v.clock',time); 
        }), 1000);
    },
    
    runTimeLeftClock : function(component,h,m,s) {
       s=s-1;
        if(s==0){
            m=m-1; // added extra code
            if(m==0 &&h!=0){
                m=59;
                s=59;
                h=h==0?0 :h-1;
            }
            else if(m==0 &&h==0){
                s=0;
            }
                else{
                    s=59;    
                }
        }
        component.set('v.Hour',h);  
        component.set('v.Minute',m);
        component.set('v.Seconds',s);
    },
    
    runTimeOverDueClock : function(component,h,m,s) {
        s=s+1;
        if(s==60){
            m=m+1; // added extra code
            if(m==60){
                m=0;
                h=h+1;
            }
            s=0;
            if(h==24){
                var days=component.get('v.Days');
                 component.set('v.Days',days+1);
                h=0;
            }
        }
        component.set('v.Hour',h);  
        component.set('v.Minute',m);
        component.set('v.Seconds',s);
    }

})