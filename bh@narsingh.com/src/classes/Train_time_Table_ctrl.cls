public class Train_time_Table_ctrl {

    public String jsonoutput { get; set; }

    public PageReference getData() {
     tInfo=new List<trainsInfo>();
     String tNo;
     HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('https://data.gov.in/api/datastore/resource.json?resource_id=b46200c1-ca9a-4bbe-92f8-b5039cc25a12&api-key=edf3b24ed449a993a577f779ed6cd42d');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     jsonoutput=res.getBody();
     JSONParser parser = JSON.createParser(res.getBody());
      while (parser.nextToken() != null) {

    if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
      
     if(parser.getText()== 'Train No.'){
        trainsInfo t=new trainsInfo();
       System.debug('.........current.....1....................'+parser.getCurrentToken());
     System.debug('..........txt..........1..............'+parser.getText());
                      parser.nextToken();
      System.debug('.........current.....1....................'+parser.getCurrentToken());
     System.debug('..........txt..........1..............'+parser.getText());                           
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       tNo= parser.getText();
                 
                    
                    parser.nextToken();
        
                    }
                    t.tNo=tNo;
                    tInfo.add(t);
    }
    
    }
    }
        return null;
    }
    public List<trainsInfo> tInfo{get;set;}
    class trainsInfo
    {
    public String tNo{get;set;}
    public trainsInfo()
    {
    
    }
    }
}