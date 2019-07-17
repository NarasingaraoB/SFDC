public class pincode_directory_ctrl {

    public String jout { get; set; }

    public PageReference data() {
     HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('https://data.gov.in/api/datastore/resource.json?resource_id=0a076478-3fd3-4e2c-b2d2-581876f56d77&api-key=edf3b24ed449a993a577f779ed6cd42d');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     jout=res.getBody();
   // System.debug(res.getBody());
        return null;
    }

}