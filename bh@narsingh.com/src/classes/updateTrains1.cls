global class updateTrains1 implements Schedulable
{
global void execute(SchedulableContext SC) {
updateTrains2 ut2=new updateTrains2();
ut2.updateTrains();
datetime nextScheduleTime = system.now().addMinutes(1);
 string minute = string.valueof(nextScheduleTime.minute());
      string second = string.valueof(nextScheduleTime.second ());
      string cronvalue = second+' '+minute+' * * * ?' ;
      string jobName = 'updateTrains1' +
  nextScheduleTime.format('hh:mm');
 
    updateTrains1 p = new updateTrains1();
    system.schedule(jobName, cronvalue , p);
 
    // this section of code will abort the current schedule job
    system.abortJob(sc.getTriggerId());
  

}
}