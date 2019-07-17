public class smsClass
{
public smsClass(String to,String message)
{

//httpReq.setEndpoint('http://api.sends.im/messages/send/?ims_id=1&recipient='+to+'&message=message&api_key=161ae8568acd2ceb95a6d818d1d55286');

   HttpRequest httpReq=new HttpRequest();
    //httpReq.setEndpoint('https://api.smsapi.com/sms.do?username=narsingh.bh@gmail.com&password=Data1nfoMD5&from=Narsingh&to=919293159856&message=success');
   httpReq.setEndpoint('http://api.sends.im/messages/send/?ims_id=system&recipient='+to+'&message=message&api_key=161ae8568acd2ceb95a6d818d1d55286');
   // httpReq.setEndpoint('http://api.sends.im/messages/info/?message_id=bac45622b05039ad3b9730a31cde7133&api_key=161ae8568acd2ceb95a6d818d1d55286');
    httpReq.setMethod('GET');
httpReq.setHeader('ContentType','application/json');
Http http = new Http();
     HTTPResponse res = http.send(httpReq);
System.debug('........response.........................'+res.getBody());

}
}