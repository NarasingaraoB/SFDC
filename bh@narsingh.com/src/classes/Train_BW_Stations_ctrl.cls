public with sharing class Train_BW_Stations_ctrl {

    public String trainName { get; set; }

    public Train_BW_Stations_ctrl()
    {
     viewD='none';
     viewB='block';
     trNo='12004';
    }
    public String viewD { get; set; }

    public PageReference getTrainRoute() {
    viewD='block';
    viewB='none';
    HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('http://railpnrapi.com/test/route/train/'+trNo+'/format/json/pbapikey/f17a704c61a95084ec11d879b090e0be/pbapisign/d9c04130b897f9e052afe7ca0ae0fcab');
    httpReq.setMethod('GET');
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
        if(fieldName == 'number'){
            trNo= parser.getText();
        }
        else if(fieldName == 'name'){
            trainName= parser.getText();
        }
        else if(fieldName == 'days'){
        String code;
        String run;
        rDays=new List<runsOnDays>();
        
      
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
        
        
         while(parser.nextToken() != JSONToken.END_ARRAY){
         runsOnDays rday=new runsOnDays();
         
          if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
          
           
            if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
            parser.nextToken();
            
        if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
        //parser.nextToken();
       
         if(parser.getText()== 'day-code'){
                  parser.nextToken();
             
               if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                 code = parser.getText();
                  
                    
                    
                    //runsOnDays rDay=(runsOnDays)parser.readValueAs(runsOnDays.class);
                   // rDays.add(rDay);
                    }
                  
                    if(parser.getText()== 'runs'){
                      parser.nextToken();
                                
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       run= parser.getText();
                 
                    
                    
                    //runsOnDays rDay=(runsOnDays)parser.readValueAs(runsOnDays.class);
                   // rDays.add(rDay);
                    }
        }
         rday.dayCode = code;
         rday.runs=run;
                 rDays.add(rday); 
        }
       
        
        }
        }
        }
        }
        
        }
        System.debug('.......rDays........................'+rDays);
        }
        else if(fieldName == 'route'){
        String sNo;
        String arrTime;
        String depTime;
        String haltTime;
        String distance;
        String name;
        String code;
        String day;
        String dist;
        String stName;
        String stCode;
        tRoute=new List<trainRoute>();
        
        System.debug('.............token....1......................'+parser.getCurrentToken());
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
        
        System.debug('.............token.....2.....................'+parser.getCurrentToken());
         while(parser.nextToken() != JSONToken.END_ARRAY){
         trainRoute rt=new trainRoute();
         System.debug('.............token.....3.....................'+parser.getCurrentToken());
          if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
          System.debug('.............text.....4.....................'+parser.getText());
           System.debug('.............token....44....................'+parser.getCurrentToken());
            if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
            parser.nextToken();
            System.debug('.............token....444....................'+parser.getCurrentToken());
        if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
        //parser.nextToken();
        System.debug('.............text.....5.....................'+parser.getText());
         if(parser.getText()== 'no'){
                  parser.nextToken();
           
               if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                 sNo = parser.getText();
                  
                  parser.nextToken();  
                    
                 
                    }
                  
                    if(parser.getText()== 'arrival_time'){
                      parser.nextToken();
                          
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       arrtime= parser.getText();
                 
                    parser.nextToken();
                    
                   
                    }
                    }
                    if(parser.getText()== 'departure_time'){
                      parser.nextToken();
                             
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 
                       deptime= parser.getText();
                 
                    parser.nextToken();
                    
                  
                    
                    }
                    }
                    if(parser.getText()== 'stop_time'){
                      parser.nextToken();
                          
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                
                       haltTime= parser.getText();
                 
                     parser.nextToken();
                    
                   
                    }
                    }
                    if(parser.getText()== 'day'){
                      parser.nextToken();
                               
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                
                       day= parser.getText();
                 
                    parser.nextToken();
                  
                    }
                    }
                    if(parser.getText()== 'distance'){
                      parser.nextToken();
                            
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                
                       dist= parser.getText();
                 
                    
                    parser.nextToken();
                     System.debug('........staion...1......................'+parser.getCurrentToken());
                 
                    }
                    }
                    if(parser.getText()== 'station'){
                      parser.nextToken();
                       System.debug('........staion....2.....................'+parser.getCurrentToken());
                       if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                       parser.nextToken();
                       System.debug('........staion.......3..................'+parser.getCurrentToken());
                       if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                System.debug('........staion.......3..................'+parser.getText());
                       if(parser.getText()== 'name')
                       {
                       parser.nextToken();
                            
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                
                       stName=parser.getText();
                       }
                       parser.nextToken();
                       
                       if(parser.getText()== 'code')
                       {
                       parser.nextToken();
                            
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                
                       stCode=parser.getText();
                       }
                       }
                       }
                    }
                       }        
                       
                    }
         rt.sNo = sNo;
         rt.arrTime=arrTime;
         rt.depTime=depTime;
         rt.haltTime=haltTime;
         rt.day=day;
         rt.dist=dist;
         rt.stName=stName;
         rt.stCode=stCode;
         
                 tRoute.add(rt); 
        }
       
        
        }
        }
        }
        }
        
        }
        System.debug('.............trainRoute............................'+tRoute);
        }
        }
        }
        return null;
    }


    public String trNo { get; set; }

    public String viewB { get; set; }
    public List<runsOnDays> rDays {get;set;}
    public List<trainRoute> tRoute {get;set;}
    class runsOnDays
    {
    public String dayCode {get;set;}
    public String runs {get;set;}
    }
    class trainRoute
    {
        public String sNo {get;set;}
        public String arrTime {get;set;}
        public String depTime {get;set;}
        public String haltTime {get;set;}
        public String distance {get;set;}
        public String day {get;set;}
        public String dist {get;set;}
        public String stName {get;set;}
        public String stCode {get;set;}
    }
}