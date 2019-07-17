public class TelicomDetails_ctrl {

    
    public PageReference getData() {
      HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('http://api.dataweave.in/v1/telecom_data/listByCircle/?api_key=96e9d96ca6406fafe6fb43749b9b3d07d2cc9fc4&operator='+CON+'&circle='+area+'&page=1&per_page=10');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     jsonoutput=res.getBody();
     JSONParser parser = JSON.createParser(res.getBody());
     rData=new List<rechargeData>();
     while (parser.nextToken() != null) {

 if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
  if(parser.getText()== 'data'){
  parser.nextToken();
  if((parser.getCurrentToken() == JSONToken.START_ARRAY)){
  while (parser.nextToken() != null) {
  System.debug('......cuerrent....1.........'+parser.getCurrentToken());
System.debug('......cuerrent....1...txt......'+parser.getText());
if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
rechargeData r=new rechargeData();
while (parser.nextToken() != null && parser.getCurrentToken() != JSONToken.END_OBJECT) {

            if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                 if(parser.getText()== 'recharge_value'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....2......'+parser.getText());
                 
                 r.rValue=parser.getText();
                 
                 }
                 }
                 if(parser.getText()== 'recharge_talktime'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rTalktime=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'recharge_validity'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rValidity=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'recharge_short_description'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rDescriptionShort=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'recharge_description'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rDescription=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'recharge_description_more'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rDescriptionMore=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'product_type'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rProduct=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'circle_master'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  circle=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'operator_master'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rOperator=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'recharge_master'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rMaster=parser.getText(); 
                 }
                 }
                 if(parser.getText()== 'is_prepaid'){
                 parser.nextToken();
                 if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt....3......'+parser.getText());
                  r.rConnection=parser.getText(); 
                 }
                 }
            }

}
 rData.add(r);   
}

}
}
  }


}
}
 System.debug('........rData.................'+rData);
        return null;
       
    }
    
    public String circle {get;set;}
    public List<rechargeData> rData{get;set;}
    public String con { get; set; }
    public String area { get; set; }
    public String jsonoutput { get; set; }
    public TelicomDetails_ctrl()
    {
    con=Apexpages.currentpage().getparameters().get('conType');
    area=Apexpages.currentpage().getparameters().get('circle');
    }
    class rechargeData
    {
    public String rValue{get;set;}
    public String rTalktime{get;set;}
    public String rValidity{get;set;}
    public String rDescriptionShort{get;set;}
    public String rDescription{get;set;}
    public String rDescriptionMore{get;set;}
    public String rProduct{get;set;}
    //public String rCircle{get;set;}
    public String rOperator{get;set;}
    public String rMaster{get;set;}
    public String rConnection{get;set;}
    public rechargeData()
    {
    }
    }
}