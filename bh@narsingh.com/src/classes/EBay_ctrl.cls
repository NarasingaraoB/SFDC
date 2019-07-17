public class EBay_ctrl {

    public String jout { get; set; }

    public EBay_ctrl()
    {
    tokens=new List<string>();
    }

    public PageReference getGetItems() {
    HttpRequest httpReq=new HttpRequest();
     httpReq.setEndpoint('http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&SECURITY-APPNAME=findnayt-9aa3-4674-8f30-fb852f224e83&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD&keywords=harry%20potter%20phoenix');
    //httpReq.setEndpoint('http://svcs.sandbox.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&SECURITY-APPNAME=findnayt-e763-43ab-8e47-f7492808b46c&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD&keywords=mobile%20phones');
  // httpReq.setEndpoint('http://open.api.ebay.com/shopping?callname=FindPopularItems&responseencoding=JSON&appid=findnayt-9aa3-4674-8f30-fb852f224e83&siteid=0&QueryKeywords=dog&version=713');
    httpReq.setMethod('GET');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     jout=res.getBody();
   // System.debug(res.getBody());
   dInfo=new List<dataInfo>();
     JSONParser parser = JSON.createParser(res.getBody());
  /*   while (parser.nextToken() != null) {
if((parser.getCurrentToken() == JSONToken.START_ARRAY)){
  while (parser.nextToken() != null && parser.getCurrentToken() != JSONToken.END_ARRAY) {
  if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 
  if(parser.getText()== 'ItemID'){
  parser.nextToken();
  jout=parser.getText();
  }
  }
  if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 
  if(parser.getText()== 'ViewItemURLForNaturalSearch'){
  parser.nextToken();
  jout=parser.getText();
  }
  }if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 
  if(parser.getText()== 'GalleryURL'){
  parser.nextToken();
  jout=parser.getText();
  }
  }
  if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 
  if(parser.getText()== 'ConvertedCurrentPrice'){
  parser.nextToken();
  if((parser.getCurrentToken() == JSONToken.START_OBJECT)){
  parser.nextToken();
  if(parser.getText()== 'VALUE'){
  parser.nextToken();
  jout=parser.getText();
  parser.nextToken();
  }
  if(parser.getText()== 'CurrencyID'){
  parser.nextToken();
  jout=parser.getText();
  parser.nextToken();
  }
  }
  }
  }
  if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 
  if(parser.getText()== 'Title'){
  parser.nextToken();
  jout=parser.getText();
  }
  }
  if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 
  if(parser.getText()== 'ConvertedCurrentPrice'){
  parser.nextToken();
  jout=parser.getText();
  }
  }
  }
  }
}
*/
/*
 if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
 
  if(parser.getText()== 'title'){
  dataInfo d=new dataInfo();
  parser.nextToken();
  
  if((parser.getCurrentToken() == JSONToken.START_ARRAY)){
  while (parser.nextToken() != null && parser.getCurrentToken() != JSONToken.END_ARRAY) {
  d.product=parser.getText();
  //tokens.add(parser.getText());
  
  }
  
  }
  parser.nextToken();
   

  if(parser.getText()== 'globalId'){
  
  parser.nextToken();
  
  if((parser.getCurrentToken() == JSONToken.START_ARRAY)){
  while (parser.nextToken() != null && parser.getCurrentToken() != JSONToken.END_ARRAY) {
  //d.productImg=parser.getText();
  //tokens.add(parser.getText());
  
  }
  }
  parser.nextToken();
  }
  
  if(parser.getText()== 'primaryCategory'){
  
  parser.nextToken();
  
  if((parser.getCurrentToken() == JSONToken.START_ARRAY)){
  if((parser.getCurrentToken() == JSONToken.START_OBJECT)){
  while (parser.nextToken() != null) {
  //d.productImg=parser.getText();
  tokens.add(parser.getText());
  
  }
  }
  }
  parser.nextToken();
  }
  //tokens.add(parser.getText());
  if(parser.getText()== 'galleryURL'){
  
  parser.nextToken();
  
  if((parser.getCurrentToken() == JSONToken.START_ARRAY)){
  while (parser.nextToken() != null && parser.getCurrentToken() != JSONToken.END_ARRAY) {
  d.productImg=parser.getText();
  //tokens.add(parser.getText());
  
  }
  }
  parser.nextToken();
  }
  
  dInfo.add(d);
  }
  
  }
  
  }
  */
        return null;
    }
public List<String> tokens{get;set;}
public List<dataInfo> dInfo{get;set;}
class dataInfo{
public String product {get;set;}
public String productImg {get;set;}
public dataInfo()
{
}
}
}