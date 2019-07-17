global class testWebservice
{
webService static Id makeContact(String  lastName,String accName)
{
Account a=[select id from Account where name=:accName limit 1];
Contact c=new Contact();
c.lastName=lastName;
c.AccountId=a.id;
insert c;
return c.id;
}
}