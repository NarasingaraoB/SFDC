@isTest
public class callAccountTest {
static testMethod void testGetMethod()
{
    Account acc=new Account();
    acc.Name='test';
    acc.AccountNumber='12345';
    insert acc;
    RestRequest request =new RestRequest();
    request.requestURI='/services/apexrest/api/Account/'+acc.id;
    request.httpMethod='GET';
    RestContext.request=request;
    Account acct=callAccount.doGet();
    System.assert(acct!=null);
    System.assertEquals('test', acct.name);
}
static testMethod void testPostMethod()
{
     Account acc=new Account();
    acc.Name='test1';
    acc.AccountNumber='123456';
    String JsonAcc=JSON.serialize(acc);
    RestRequest request =new RestRequest();
    request.requestURI='/services/apexrest/api/Acount/';
    request.httpMethod='POST';
    String s='"Name"="test1"';
    request.requestBody=Blob.valueOf(JsonAcc);
    RestContext.request=request;
    String accid=callAccount.doPost();
    system.assert(accid!=null);
}
    static testMethod void testDeleteMethod()
    {
        Account acc=new Account();
        acc.Name='test2';
        acc.AccountNumber='1234567';
        insert acc;
        RestRequest request =new  RestRequest();
        request.requestURI='/service/apexrest/api/Account/'+acc.Id;
        request.httpMethod='DELETE';
        RestContext.request=request;
        callAccount.doDelete();
        List<Account> accts=[select id from Account where id=:acc.Id];
        System.assert(accts.size()==0);
    }
}