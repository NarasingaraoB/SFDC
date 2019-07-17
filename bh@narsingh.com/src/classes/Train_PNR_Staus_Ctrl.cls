public class Train_PNR_Staus_Ctrl {

   public String dest { get; set; }

    public String src { get; set; }

    public String trName { get; set; }

    public String reservedUpto { get; set; }

    public String boardingPoint { get; set; }

    

    public String classType { get; set; }

    public String boardingDate { get; set; }

    public String tName { get; set; }

    public String trNo { get; set; }
 
    public Train_PNR_Staus_Ctrl()
    {
    pnr=ApexPages.currentPage().getParameters().get('pnrNo');
    }

    public PageReference getPnrStatus() {
    HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('http://railpnrapi.com/test/check_pnr/pnr/'+pnr+'/format/json/pbapikey/ee75be96cbfefc48bae4998972836f9a/pbapisign/1d934cef9f7adbb2878ed96945d765ec97664f20');
    httpReq.setMethod('GET');
     String username = 'narsingbh@gmail.com';
     String password = 'findrailinfo';
  
     Blob headerValue = Blob.valueOf(username + ':' + password);
     String authorizationHeader = 'BASIC ' +
     EncodingUtil.base64Encode(headerValue);
     httpReq.setHeader('Authorization', authorizationHeader);
   
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
  
     Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     JSONParser parser = JSON.createParser(res.getBody());
while (parser.nextToken() != null) {

    //if current token is a field name
    if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
        String fieldName = parser.getText();
        System.debug('fieldName: ' + fieldName);
        //move to token after the field name
        parser.nextToken(); 
        if(fieldName == 'train_num'){
            trNo= parser.getText();
        }
        else if(fieldName == 'train_name'){
            trName= parser.getText();
        }
        else if(fieldName == 'doj'){
            boardingDate= parser.getText();
        }
        else if(fieldName == 'from_station'){
        parser.nextToken(); 
        fieldName = parser.getText();
          if(fieldName == 'code')
          {
          parser.nextToken(); 
            src= parser.getText();
          }
          
        }
        else if(fieldName == 'to_station'){
        parser.nextToken(); 
        fieldName = parser.getText();
          if(fieldName == 'code')
          {
          parser.nextToken(); 
           dest= parser.getText();
          }
          
            
        }
        else if(fieldName == 'reservation_upto'){
        parser.nextToken(); 
        fieldName = parser.getText();
          if(fieldName == 'code')
          {
          parser.nextToken(); 
            reservedUpto= parser.getText();
          }
          
           
        }
        else if(fieldName == 'boarding_point'){
        parser.nextToken(); 
        fieldName = parser.getText();
          if(fieldName == 'code')
          {
          parser.nextToken(); 
          boardingPoint= parser.getText();
          }
          
            
        }
        else if(fieldName == 'class'){
            classType= parser.getText();
        }
        else if(fieldName == 'passengers'){
           //if current token is array
           passengersList=new List<Passengers>();
if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
 while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    Passengers pass = (Passengers)parser.readValueAs(Passengers.class);
                        system.debug('sr: ' + pass.sr);
                        system.debug('booking_status: ' + pass.booking_status);
                        passengersList.add(pass);
                    }
 }
}
        }
        }
        }
     
     /*
     Train_PNR_Staus_Ctrl obj = (Train_PNR_Staus_Ctrl) System.JSON.deserialize(res.getBody(), Train_PNR_Staus_Ctrl.class);
        System.assert(obj != null);
        System.debug('......object........'+obj);
        System.debug('.........from_station.......................'+from_station);
        System.debug('.........to_station.......................'+to_station);
        System.debug('..........reservation_upto......................'+reservation_upto);
        System.debug('.........boarding_point.......................'+boarding_point);
        System.debug('..........passengers......................'+passengers);
        */
        return null;
    }


    public String pnr { get; set; }
    
   /* public String train_num { get; set; }
    public String train_name { get; set; }
    public String doj { get; set; }
    public From_station from_station { get; set; }
    public From_station to_station { get; set; }
    public From_station reservation_upto { get; set; }
    public From_station boarding_point { get; set; }
    public String classT { get; set; }
    public Integer no_of_passengers { get; set; }
    public String chart_prepared { get; set; }
    public List<Passengers> passengers { get; set; }
    public Object error { get; set; }
    public class From_station {
        public String code;
        public String name;
    }*/
    public List<Passengers> passengersList { get; set; }
    public class Passengers {
        public Integer sr {get;set;}
        public String booking_status {get;set;}
        public String current_status {get;set;}
    }
}