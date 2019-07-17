global class updateTByD implements Schedulable
{
 global void execute(SchedulableContext SC) {
 updateTrainClass utc=new updateTrainClass();
 utc.updateByDates();
  datetime nextScheduleTime = system.now().addMinutes(5);
      string minute = string.valueof(nextScheduleTime.minute());
      string second = string.valueof(nextScheduleTime.second ());
      string cronvalue = second+' '+minute+' * * * ?' ;
      string jobName = 'updateTByD' +
  nextScheduleTime.format('hh:mm');
 
    updateTByD p = new updateTByD();
    system.schedule(jobName, cronvalue , p);
 
    // this section of code will abort the current schedule job
    system.abortJob(sc.getTriggerId());
  
 }

}