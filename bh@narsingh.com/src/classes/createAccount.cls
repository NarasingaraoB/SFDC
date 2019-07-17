@RestResource(urlMapping='/INSERTAccount/*')
global with sharing class createAccount
{
@HttpPost
global static String accountCreate(String name)
{
Account a=new Account();
a.name=name;
insert a;
String response=JSON.serialize(a);
return response;
}
}