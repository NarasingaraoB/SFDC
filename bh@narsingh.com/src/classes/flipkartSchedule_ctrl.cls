public class flipkartSchedule_ctrl {

    public PageReference data() {
       HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('https://affiliate-api.flipkart.net/affiliate/api/narsinghb.json');
    httpReq.setMethod('GET');
     
   
     
   
     
     httpReq.setHeader('Fk-Affiliate-Id', 'narsinghb');
     httpReq.setHeader('Fk-Affiliate-Token', '8ac150f727dc41e598716bcf53199f03');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     jsonOut=res.getBody();
     
      JSONParser parser = JSON.createParser(res.getBody());
      String resName;
      String resUrl;
      String name;
      List<flipkart__c> fkarts=new List<flipkart__c>();
      while (parser.nextToken() != null) {
       if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
       if(parser.getText()== 'resourceName'){
       parser.nextToken();
     
        name=parser.getText();
       parser.nextToken();
       parser.nextToken();
       parser.nextToken();
       parser.nextToken();
       parser.nextToken(); 
       parser.nextToken(); 
       parser.nextToken(); 
      jsonOut=parser.getText();
       if(parser.getText()== 'get'){
       parser.nextToken(); 
       
       //if(parser.getText()!=null)
       //{
      boolean b=((parser.getText()).containsIgnoreCase('https://affiliate-api.flipkart.net/affiliate/feeds/rawfiles'));
      jsonOut=String.valueOf(b);
      if(!b)
      {
      
       flipkart__c fkart=new flipkart__c();
       fkart.name=name;
      
        fkart.resourceUrl__c=parser.getText();
         fkarts.add(fkart);
         if(fkarts.size()>10)
         {
         break;
         }
      }
      
     //  } 
       } 
        
       }
        
       }
      }
      System.debug('..........fkarts sizer..............'+fkarts.size());
     insert fkarts;
     
        return null;
    }


    public String jsonOut { get; set; }
}