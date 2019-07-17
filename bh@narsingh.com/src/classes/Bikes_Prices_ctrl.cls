public class Bikes_Prices_ctrl {

    public String jsonoutput { get; set; }

    public PageReference getData() {
     HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('http://api.dataweave.in/v1/telecom_data/listByCircle/?api_key=96e9d96ca6406fafe6fb43749b9b3d07d2cc9fc4&operator=Vodafone&circle=Andhra+Pradesh&page=1&per_page=10');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     jsonoutput=res.getBody();
        return null;
    }

}