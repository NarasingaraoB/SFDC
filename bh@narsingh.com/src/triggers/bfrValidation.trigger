trigger bfrValidation on Account (before insert) {
for(Account a:Trigger.new)

{
if(a.triggerTest__c==null)
{
a.triggerTest__c.addError('plaese enter value in triggerTest Field');
}
}
}