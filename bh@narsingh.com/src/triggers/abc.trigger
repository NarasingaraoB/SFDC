trigger abc on Contact (after Insert) {
List<Account> act=new List<Account>();
String nm;
Id i;
for(Contact c:trigger.New)
{
nm=c.firstname;
i=c.AccountId;
}

System.debug('.....nm....'+nm+','+i);
for(Account a:[select id,domns__c from Account where id=:i])
{
a.domns__c=nm;
act.add(a);
}
update act;
}