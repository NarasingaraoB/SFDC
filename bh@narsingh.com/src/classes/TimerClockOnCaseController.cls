public class TimerClockOnCaseController {
    
    @AuraEnabled  
    public static String  fetchStatusChangeTime(String recordId){
        case caseRecord =  [ SELECT Id,Stage__c,StatusChangeDateTime__c ,Stage_Changed_Time__c,BusinessHoursId FROM Case where Id =:recordId limit 1];    
        return returnDurationLeftMethod2(caseRecord.Stage_Changed_Time__c,caseRecord.BusinessHoursId);
    }
    
    
    public static String returnDurationLeftMethod2(Datetime startDate , Id BusinessHoursId){
        Decimal hours=0;    Decimal decMinutes=0;     Decimal seconds =0; String hourMinuteSecondFormate='';
        Datetime currentTime = Datetime.now();
        Integer offset = UserInfo.getTimezone().getOffset(currentTime);
        Datetime localUserTime = currentTime.addSeconds(offset/1000);
        Datetime localCaseStageTime = startDate.addSeconds(offset/1000);
        Long busnessMinute= (((BusinessHours.diff(BusinessHoursId, startDate, localUserTime))/1000)/60);
        //calculate end of business hour
        decMinutes=busnessMinute;
        seconds =system.Math.mod((Integer)busnessMinute, 60);  
        if(busnessMinute>=60){
            hours=(busnessMinute/60);
            decMinutes=(system.Math.mod((Integer)busnessMinute,60));
        }
        hourMinuteSecondFormate=''+hours+':'+decMinutes+':'+seconds;
        System.debug('Is current running after adding 2 hour within business hour'+BusinessHours.isWithin(BusinessHoursId, localCaseStageTime.addHours((Integer)hours)));
      /*  if(!BusinessHours.isWithin(BusinessHoursId, localUserTime)){
            hourMinuteSecondFormate='00:00:00';
        }*/
          return hourMinuteSecondFormate;
    }    
    
    
    public static String returnDurationLeft(Datetime startDate ,Id BusinessHoursId){
         System.debug('startDate '+startDate);
        
        
        String hourMinuteSecondFormate='';
        Datetime endDate=system.now();
        System.debug('is between business hour '+BusinessHours.isWithin(BusinessHoursId,endDate));
        System.debug('time difference is '+((BusinessHours.diff(BusinessHoursId, startDate, endDate))/1000/60/60));
        System.debug('endDate '+endDate);
        if(endDate>startDate){
            integer intDays =  startDate.Date().daysBetween(endDate.Date());
            SYstem.debug('Integer days '+intDays);
            datetime sameDayEndDate = startDate.addDays(intDays);
            decimal decHours = ((endDate.getTime())/1000/60/60) - ((sameDayEndDate.getTime())/1000/60/60);
            decimal decMinutes = ((endDate.getTime())/1000/60) - ((sameDayEndDate.getTime())/1000/60);
           
            System.debug('total minutes '+decMinutes);
            Decimal totalHourInMinutes=((intDays*24*60)+decMinutes);
            System.debug('total minutes '+totalHourInMinutes);
            decHours=(Integer)totalHourInMinutes/60;
            decMinutes=(system.Math.mod((Integer)totalHourInMinutes,60));
            decimal seconds = ((endDate.getTime())/1000) - ((sameDayEndDate.getTime())/1000);
            seconds= system.Math.abs((system.Math.mod((Integer)seconds, 60))) ; 
            hourMinuteSecondFormate=''+decHours+':'+decMinutes+':'+seconds;
        }
        return hourMinuteSecondFormate;
    }
}