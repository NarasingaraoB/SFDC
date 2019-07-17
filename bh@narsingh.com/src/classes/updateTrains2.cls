public class updateTrains2
{
public void updateTrains() {

datetime dTime = system.now();
Date currentDate=date.newinstance(dTime.year(), dTime.month(), dTime.day());
dTime=dTime.addMinutes(5);
String hrMin=dTime.hour()+':'+dTime.minute();
Set<Decimal> tNos=new Set<Decimal>();
System.debug('........currentDate...............'+currentDate);
System.debug('.....hrMin..................'+hrMin);
for(DateByTrain__c dbt:[select Train_Number__c from DateByTrain__c where SheduleDate__c=:currentDate])
{
tNos.add(dbt.Train_Number__c);
}
System.debug('......tNos.............'+tNos);
List<String> trDepTimes=new List<String>();
Set<Decimal> trNos=new Set<Decimal>();
for(TrainByStation__c t:[select Train_No__c,Departure__c from TrainByStation__c where Train_No__c IN:tNos and Distance_KM__c=0])
{
if(hrMin==t.Departure__c)
{
trNos.add(t.Train_No__c);
}
}
System.debug('.....trNos..................'+trNos);
for(DateByTrain__c dbt:[select X1AC__c,X2AC__c,X3AC__c,X2S__c,CC__c,SL__c,SheduleDate__c from DateByTrain__c where Train_Number__c IN:trNos and SheduleDate__c=:currentDate])
{
System.debug('.......shedule................'+dbt.SheduleDate__c);
dbt.X1AC__c='0';
dbt.X2AC__c='0';
dbt.X3AC__c='0';
dbt.X2S__c='0';
dbt.CC__c='0';
dbt.SL__c ='0';
update dbt;
}
   
  
}
}