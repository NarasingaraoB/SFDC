public class Train_Seat_Availability_ctrl {

     public String viewB { get; set; }

    public String viewD { get; set; }
    public Train_Seat_Availability_ctrl()
    {
     viewD='none';
    viewB='block';
    }
    public PageReference getReset() {
        return null;
    }


    public String quota { get; set; }

    public String selClass { get; set; }

    public String destCode { get; set; }

    public String srcCode { get; set; }

    public String jrdat { get; set; }
    public String tName {get; set;}
    public String trClassName {get;set;}
    public PageReference getSeatAvailability() {
     viewD='block';
    viewB='none';
    /*String[] spltS=jrDat.split('/');
    String jrDate=spltS[1]+spltS[0]+spltS[2];
     HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('http://railpnrapi.com/test/check_avail/tnum/'+trNo+'/fscode/'+srcCode+'/tscode/'+destCode+'/date/'+jrDate+'/class/'+selClass+'/quota/'+quota+'/format/json/pbapikey/ee75be96cbfefc48bae4998972836f9a/pbapisign/1d934cef9f7adbb2878ed96945d765ec97664f20');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     */
     String tempJsonCode='{'
    +'"response_code": 200,'
    +'"availability": {'
        +'"train_number": "12004",'
        +'"train_name": "LKO SWRAN SHTBD",'
        +'"date_of_journey": "31-12-2013",'
        +'"from": {'
            +'"name": "NEW DELHI      ",'
            +'"code": "NDLS",'
            +'"location": null'
        +'},'
        +'"to": {'
            +'"name": "KANPUR CENTRAL ",'
            +'"code": "CNB",'
            +'"location": null'
        +'},'
        +'"class": {'
            +'"class_code": "CC",'
            +'"class_name": "AC Chair Car"'
        +'},'
        +'"quota": {'
            +'"quota_code": "GN",'
            +'"quota_name": "GENERAL"'
        +'},'
        +'"availability_status": ['
            +'{'
                +'"date": "31-12-2013",'
                +'"status": "AVAILABLE 591"'
            +'},'
            +'{'
                +'"date": "01-01-2014",'
                +'"status": "AVAILABLE 592"'
            +'},'
            +'{'
                +'"date": "02-01-2014",'
                +'"status": "AVAILABLE 499"'
            +'},'
            +'{'
                +'"date": "03-01-2014",'
                +'"status": "AVAILABLE 681"'
            +'},'
            +'{'
                +'"date": "04-01-2014",'
                +'"status": "AVAILABLE 610"'
            +'},'
            +'{'
                +'"date": "05-01-2014",'
                +'"status": "AVAILABLE 627"'
            +'}'
        +']'
    +'}'
+'}';
//JSONParser parser = JSON.createParser(res.getBody());
String avail;

JSONParser parser = JSON.createParser(tempJsonCode);
while (parser.nextToken() != null) {
System.debug('......cuerrent....1.........'+parser.getCurrentToken());
System.debug('......cuerrent....1...txt......'+parser.getText());
if(parser.getText()== 'availability'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       avail=parser.getText();
}
}
else if(parser.getText()== 'train_number'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       trNo=parser.getText();
}
}
else if(parser.getText()== 'train_name'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       tName=parser.getText();
}
}
else if(parser.getText()== 'date_of_journey'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       jrDat=parser.getText();
}
}
else if(parser.getText()== 'from'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
parser.nextToken();
if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 if(parser.getText()== 'name'){
 parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       srcCode=parser.getText();
 }
 }
}
 
                       
}
}
else if(parser.getText()== 'to'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
parser.nextToken();
if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 if(parser.getText()== 'name'){
 parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       destCode=parser.getText();
 }
 }
}
 
                       
}
}
else if(parser.getText()== 'class'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
parser.nextToken();
if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 if(parser.getText()== 'class_code'){
 parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       //trClassName=parser.getText();
   parser.nextToken();                     
 }
 }
 if(parser.getText()== 'class_name'){
 parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       trClassName=parser.getText();
 }
 }
}
 
                       
}
}
else if(parser.getText()== 'quota'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());

 parser.nextToken();
 System.debug('......cuerrent....22.........'+parser.getCurrentToken());
System.debug('......cuerrent....22...txt......'+parser.getText());
if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 if(parser.getText()== 'quota_code'){
 parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       quota=parser.getText();
 }
 }
}
                      
}

}
else if(parser.getText()== 'availability_status'){
String dt;
String st;
availStatus=new List<AvailableStatus>();
parser.nextToken();
 System.debug('......cuerrent....22.........'+parser.getCurrentToken());
System.debug('......cuerrent....22...txt......'+parser.getText());
if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
 
 while (parser.nextToken() != null) {
  System.debug('......cuerrent....222.........'+parser.getCurrentToken());
System.debug('......cuerrent....222...txt......'+parser.getText());
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                   // AvailableStatus status = (AvailableStatus)parser.readValueAs(AvailableStatus.class);
                   parser.nextToken();
                    if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                     System.debug('......cuerrent....2222.........'+parser.getCurrentToken());
System.debug('......cuerrent....2222...txt......'+parser.getText());
 if(parser.getText()== 'date'){
 parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....dt......'+parser.getText());
                 
                       dt=parser.getText();
                       parser.nextToken();
 }
 }
 if(parser.getText()== 'status'){
 parser.nextToken();
 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....st......'+parser.getText());
                 
                       st=parser.getText();
 }
 }
 
}    
AvailableStatus status=new AvailableStatus();
status.availDate=dt;
status.status=st;
                        availStatus.add(status);
                    }
 }
 
}
}
system.debug('......availStatus..........'+availStatus);
}
        return null;
    }


    public String trNo { get; set; }
    public List<AvailableStatus> availStatus { get; set; }
    public class AvailableStatus {
        
        public String availDate {get;set;}
        public String status {get;set;}
    }
}