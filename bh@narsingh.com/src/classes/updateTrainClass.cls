public class updateTrainClass
{
public void updateByDates()
{
Date curentDate=date.today();
 System.debug('.........curentDate...................'+curentDate);
 for(DateByTrain__c dbt:[select SheduleDate__c from DateByTrain__c])
 {
 System.debug('.........SheduleDate__c...................'+dbt.SheduleDate__c);
 if(curentDate>dbt.SheduleDate__c)
 {
 Date existDate=dbt.SheduleDate__c;
  System.debug('.........existDate...................'+existDate);
 Date updateDate = existDate.addDays(6);
 System.debug('.........updateDate..................'+updateDate);
 dbt.SheduleDate__c=updateDate;
 update dbt;
 }
 }
}
}