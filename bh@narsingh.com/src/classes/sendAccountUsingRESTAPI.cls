public class sendAccountUsingRESTAPI
{
public final String clientId='3MVG9ZL0ppGP5UrA7oUICZRzuJZRCzFR_g0xiPPJr1cRR4wgt_LiJ5g6PS1gKuNg.2fXDXrs0TzoUIcViA1EI';
public final String clientSecret='4893374671520408803';
public final String username='tech@bhaviripudi.com';
public final String password='satyam12345';
class deserializeResponse
{
public String id;
public String access_token;
}
public String ReturnAccessToken(String accid)
{
 String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
Http h=new Http();
HttpRequest req=new HttpRequest();
req.setBody(reqbody);
req.setMethod('POST');
req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
HttpResponse res = h.send(req);
System.debug('......res............'+res);
System.debug('......res............'+res.getBody());
deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
System.debug('......res............'+resp1);
System.debug('......res............'+resp1.access_token);
return resp1.access_token;
}
public  List<Contact> callgetContact(String accId)
{
String accessToken;
sendAccountUsingRESTAPI restAccount=new sendAccountUsingRESTAPI();
accessToken=restAccount.ReturnAccessToken(accId);
 list<Contact> LstContact=new List<Contact>();
 if(accessToken!=null)
 {
  String endPoint = 'https://tech-all.ap2.salesforce.com/services/apexrest/v1/getContacts/' +accId;
           //String jsonstr = '{"accId" : "' + accId+ '"}';
           Http h2 = new Http();
           HttpRequest req1 = new HttpRequest();
           req1.setHeader('Authorization','Bearer ' + accessToken);
           req1.setHeader('Content-Type','application/json');
           req1.setHeader('accept','application/json');
           //req1.setBody(jsonstr);
           req1.setMethod('GET');
           req1.setEndpoint(endPoint);
           System.debug('......req1............'+req1);
           HttpResponse res1 = h2.send(req1);
           System.debug('......res1............'+res1);
           System.debug('......res1...body.........'+res1.getBody());
 }
return null;
}
}