public class India_Pin_Contact_Details_ctrl {

    public String count { get; set; }

    public PageReference getData() {
    String fName;
    String pincode;
    String fType;
    String dStatus;
    String divName;
    String rName;
    dInfo=new List<dataInfo>();
   
     HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('https://data.gov.in/api/datastore/resource.json?resource_id=0a076478-3fd3-4e2c-b2d2-581876f56d77&api-key=edf3b24ed449a993a577f779ed6cd42d');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     jsonOutput=res.getBody();
      JSONParser parser = JSON.createParser(res.getBody());
      while (parser.nextToken() != null) {

    if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
       if(parser.getText()== 'officename'){
        dataInfo d=new dataInfo();
       System.debug('.........current.....1....................'+parser.getCurrentToken());
     System.debug('..........txt..........1..............'+parser.getText());
                      parser.nextToken();
                                
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       fName= parser.getText();
                 
                    
                    parser.nextToken();
        
                    }
                    if(parser.getText()== 'pincode'){
     
                      parser.nextToken();
                                
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       pincode= parser.getText();
                 
                    
                    parser.nextToken();
        
                    }
   
        }
        if(parser.getText()== 'officetype'){
     
                      parser.nextToken();
                                
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       fType= parser.getText();
                 
                    
                    parser.nextToken();
        
                    }
   
        }    
        if(parser.getText()== 'Deliverystatus'){
     
                      parser.nextToken();
                                
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       dStatus= parser.getText();
                 
                    
                    parser.nextToken();
        
                    }
   
        }   
        if(parser.getText()== 'divisionname'){
     
                      parser.nextToken();
                                
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       divName= parser.getText();
                 
                    
                    parser.nextToken();
        
                    }
   
        }     
        if(parser.getText()== 'regionname'){
     
                      parser.nextToken();
                                
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       rName= parser.getText();
                 
                    
                    parser.nextToken();
        
                    }
   
        }                       
   d.fName=fName;
         d.pincode=pincode;
         d.fType=fType;
         d.dStatus=dStatus;
         d.divName=divName;
         d.rName=rName;
    dInfo.add(d);
        }
        
        
    }
    
    }
    System.debug('..........dInfo.......................'+dInfo);
        return null;
        
    }
    public String jsonOutput {get;set;}
    public List<dataInfo> dInfo{get;set;}
    class dataInfo
    {
    public String fName{get;set;}
    public String pincode{get;set;}
    public String fType{get;set;}
    public String dStatus{get;set;}
    public String divName{get;set;}
    public String rName{get;set;}
    public dataInfo()
    {
    }
    }
}