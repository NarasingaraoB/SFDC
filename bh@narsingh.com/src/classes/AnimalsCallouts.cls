public class AnimalsCallouts {
public static HttpResponse makeGetCallout()
{
   Http http=new Http();
HttpRequest req=new HttpRequest();
req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
req.setMethod('GET');
HttpResponse res=http.send(req);
if(res.getstatusCode()==200)
{
    Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(res.getBody());
    List<Object> animals=(List<Object>)results.get('animals');
    System.debug('Received the following animals');
    for(Object animal:animals)
    {
        System.debug(animal);
    }
}

 
 return res;   
}
    public static HttpResponse makePostCallout()
    {
        Http http=new Http();
HttpRequest req=new HttpRequest();
req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
req.setBody('{"name":"mighty moose"}');
req.setHeader('Content-Type', 'application/json;charset=UTF-8');
req.setMethod('POST');
HttpResponse res=http.send(req);
if(res.getstatusCode()!=201)
{
    System.debug('The status code returned was not expected: '+res.getStatusCode()+ ' '+res.getstatus());
    
}
else
{
    System.debug(res.getBody());
}
        return res;
    }
}