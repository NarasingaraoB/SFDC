public with sharing class Sation_codes_json_ctrl {

    public String getJSON() {
    String stName;
    String stCode;
    String code = Apexpages.currentPage().getParameters().get('CodeName');
    List<CodeWrapper> wrp = new List<CodeWrapper>();
      HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('http://railpnrapi.com/test/station_by_code/code/'+code+'/partial/0/format/json/pbapikey/ee75be96cbfefc48bae4998972836f9a/pbapisign/1d934cef9f7adbb2878ed96945d765ec97664f20');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
       JSONParser parser = JSON.createParser(res.getBody());
while (parser.nextToken() != null) {
System.debug('......cuerrent....1.........'+parser.getCurrentToken());
System.debug('......cuerrent...txt....1......'+parser.getText());
   if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
   parser.nextToken();
   System.debug('......cuerrent....2.........'+parser.getCurrentToken());
   System.debug('......cuerrent...txt...2.......'+parser.getText());
    if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
    parser.nextToken();
    System.debug('......cuerrent.....3........'+parser.getCurrentToken());
    System.debug('......cuerrent...txt....3......'+parser.getText());
    if((parser.getCurrentToken() == JSONToken.VALUE_NUMBER_INT)){
    parser.nextToken();
    System.debug('......cuerrent.....4........'+parser.getCurrentToken());
    System.debug('......cuerrent...txt....4......'+parser.getText());
    if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
    parser.nextToken();
    System.debug('......cuerrent.....5........'+parser.getCurrentToken());
    System.debug('......cuerrent...txt....5......'+parser.getText());
     if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
     parser.nextToken();
     System.debug('......cuerrent.....6........'+parser.getCurrentToken());
     System.debug('......cuerrent...txt....6......'+parser.getText());
     if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
   parser.nextToken();
   System.debug('......cuerrent.......7......'+parser.getCurrentToken());
   System.debug('......cuerrent...txt....7......'+parser.getText());
   
      if(parser.getText()== 'name'){
                      parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt..........'+parser.getText());
                 
                       stName=parser.getText();
                 
                    parser.nextToken();
                    System.debug('......cuerrent.....9........'+parser.getCurrentToken());
                    System.debug('......cuerrent...txt....9......'+parser.getText());
                      }
                      if(parser.getText()== 'code'){
                      parser.nextToken();
                       if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
                 System.debug('......cuerrent...txt..........'+parser.getText());
                 
                       stCode=parser.getText();
                 
                    parser.nextToken();
                    System.debug('......cuerrent.....9........'+parser.getCurrentToken());
                    System.debug('......cuerrent...txt....9......'+parser.getText());
                      }
    }
    CodeWrapper w = new CodeWrapper(stName,stCode);
    wrp.add(w);
    }
   
   
     }
    }
    }
    
    }
   }
  } 
}
System.debug('.......wrp..........................'+wrp);
        return JSON.serialize(wrp);
    }
     public class CodeWrapper
    {
        String stName,stCode;

        public CodeWrapper(String stName, String stCode)
        {
            this.stName = stName;
            this.stCode = stCode;
            
        }
    }
}