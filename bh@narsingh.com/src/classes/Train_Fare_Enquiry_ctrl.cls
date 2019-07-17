public class Train_Fare_Enquiry_ctrl {

    public Train_Fare_Enquiry_ctrl()
    {
     viewD='none';
    viewB='block';
    }

    public String viewD { get; set; }

    public String age { get; set; }

    public PageReference getReset() {
        return null;
    }


    public PageReference getFareDetails() {
    viewD='block';
    viewB='none';
    String tempJsonCode='{'
  +'"response_code": 200,'
  +'"train_number": "12721",'
  +'"source_station_code": "JHS",'
  +'"dest_station_code": "NZM",'
  +'"class": "2A",'
  +'"age_code": "AD",'
  +'"quota": "GN",'
  +'"fare": "990"'
+'}';
JSONParser parser = JSON.createParser(tempJsonCode);
while (parser.nextToken() != null) {
System.debug('......cuerrent....1.........'+parser.getCurrentToken());
System.debug('......cuerrent....1...txt......'+parser.getText());
if(parser.getText()== 'train_number'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       trNo=parser.getText();
}
}
else if(parser.getText()== 'source_station_code'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       srcCode=parser.getText();
}
}
else if(parser.getText()== 'dest_station_code'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       destCode=parser.getText();
}
}
else if(parser.getText()== 'class'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       selClass=parser.getText();
}
}
else if(parser.getText()== 'age_code'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       age=parser.getText();
}
}
else if(parser.getText()== 'quota'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       quota=parser.getText();
}
}
else if(parser.getText()== 'fare'){
System.debug('......cuerrent....2.........'+parser.getCurrentToken());
System.debug('......cuerrent....2...txt......'+parser.getText());
 parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                 
                       fare=parser.getText();
}
}
}
        return null;
    }


    public String quota { get; set; }

    public String selClass { get; set; }

    public String destCode { get; set; }

    public String srcCode { get; set; }

    public String trNo { get; set; }

    public String viewB { get; set; }
    
    public String fare { get; set; }
}