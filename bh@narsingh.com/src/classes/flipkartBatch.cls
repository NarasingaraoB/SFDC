global class flipkartBatch implements Database.Batchable<sobject>
{
global final String query;
global final JSONParser parser;
global flipkartBatch(JSONParser parser,String s){

      
   }

global Database.QueryLocator start(Database.BatchableContext BC)
{
return Database.getQueryLocator(query);
}
global void execute(Database.BatchableContext BC, List<sObject> scope)
{
}
global void finish(Database.BatchableContext BC){
   }
}