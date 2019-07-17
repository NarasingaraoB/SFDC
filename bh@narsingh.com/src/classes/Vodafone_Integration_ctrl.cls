public class Vodafone_Integration_ctrl {

    public String jsonOut { get; set; }

    public PageReference Vconnection() {
     HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('https://partner.vodafone.in/services2/locationsandbox/8886073941');
    httpReq.setMethod('GET');
    String username = 'narsingbh@gmail.com';
     String password = '3=7Fbd#';
  
     Blob headerValue = Blob.valueOf(username + ':' + password);
     String authorizationHeader = 'BASIC ' +
     EncodingUtil.base64Encode(headerValue);
     httpReq.setHeader('Authorization', authorizationHeader);
   
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
  
     Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     jsonOut=res.getBody();
        return null;
    }


    public String pwd { get; set; }

    public String uName { get; set; }
}