public class flipkart_ctrl {
    public Transient String output;
    public Transient String prod;
    public flipkart_ctrl()
    {
    prod=Apexpages.currentPage().getParameters().get('prod');
    }

    public PageReference data() {
    Map<id,flipkart__c> pMap = new Map<id,flipkart__c>([select id,resourceUrl__c from flipkart__c where name=:prod limit 1]);
    System.debug('.......pMap...........................'+pMap);
    List<flipkart__c> pList = pMap.values() ;
    System.debug('.......pList..........................'+pList);
    //set<Id> prodIds=new Set<Id>();
    //Map<String,String> fkartMap=new Map<string,String>();
    System.debug('.......prod............................'+prod);
   /* for(flipkart__c fkart:[select id,resourceUrl__c from flipkart__c where name=:prod limit 1])
    {
    prodIds.add(fkart.id);
    fkartMap.put(fkart.id,fkart.resourceUrl__c);
    }
    */
   // System.debug('......prodIds..........................'+prodIds);
    List<productBaseInfo__c> pInfos=new List<productBaseInfo__c>();
    List<ProductInfo__c> prs=new List<ProductInfo__c>();
    Set<String> pIds=new Set<String>();
    Map<Id,List<productBaseInfo__c>> prBaseRecords=new Map<Id,List<productBaseInfo__c>>();
    for(flipkart__c s:pList)
    {
    
    pInfos.clear();
    prs.clear();
    pIds.clear();
    HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint(s.resourceUrl__c);
  // httpReq.setEndpoint('https://affiliate-api.flipkart.net/affiliate/feeds/narsinghb/category/reh.json?expiresAt=1447878488870&sig=25b5db27c9bb09a00301ec8f0c958c10');
    httpReq.setMethod('GET');
    httpReq.setHeader('Fk-Affiliate-Id', 'narsinghb');
     httpReq.setHeader('Fk-Affiliate-Token', '8ac150f727dc41e598716bcf53199f03');
    Http http = new Http();
    System.debug(LoggingLevel.Debug, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
    HTTPResponse res = http.send(httpReq);
     System.debug(LoggingLevel.Debug, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
     jsonOut=res.getBody();
     output=res.getBody();
    JSONParser parser = JSON.createParser(res.getBody());
      while (parser.nextToken() != null) {
       if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
         if(parser.getText()== 'productBaseInfo'){
           
           parser.nextToken();
           parser.nextToken();
           parser.nextToken();
           parser.nextToken();
           if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
           if(parser.getText()== 'productId'){
           parser.nextToken();
            
           if(parser.getText()!=null || parser.getText()!='')
           {
          
          productBaseInfo__c pInfo=new productBaseInfo__c();
                pInfo.name=prod;
                pInfo.flipkart__c=s.id;
                pInfo.Product_Id__c=parser.getText();
                pIds.add(parser.getText());
                pInfos.add(pInfo);
           }
           
           parser.nextToken(); 
           }
           }
         }
          
       }
       }
       
     prBaseRecords.put(s.id,pInfos);
     
    }
    
    /*
    set<Id> prodIds=new Set<Id>();
    Map<String,String> fkartMap=new Map<string,String>();
    for(flipkart__c fkart:[select id,resourceUrl__c from flipkart__c where name=:prod limit 1])
    {
    prodIds.add(fkart.id);
    fkartMap.put(fkart.id,fkart.resourceUrl__c);
    }
    List<productBaseInfo__c> pInfos=new List<productBaseInfo__c>();
    List<ProductInfo__c> prs=new List<ProductInfo__c>();
    Set<String> pIds=new Set<String>();
    
    for(String s:prodIds)
    {
    
    pInfos.clear();
    prs.clear();
    pIds.clear();
    HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint(fkartMap.get(s));
    httpReq.setMethod('GET');
    httpReq.setHeader('Fk-Affiliate-Id', 'narsinghb');
     httpReq.setHeader('Fk-Affiliate-Token', 'ed786eafbbf64c4d8b9af5b388b16af2');
    Http http = new Http();
    System.debug(LoggingLevel.Debug, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
     HTTPResponse res = http.send(httpReq);
     System.debug(LoggingLevel.Debug, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
     jsonOut=res.getBody();
     output=res.getBody();
    JSONParser parser = JSON.createParser(res.getBody());
    
       while (parser.nextToken() != null) {
       if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
         if(parser.getText()== 'productBaseInfo'){
           productBaseInfo__c pInfo=new productBaseInfo__c();
    pInfo.name=prod;
    pInfo.flipkart__c=s;
           parser.nextToken();
           parser.nextToken();
           parser.nextToken();
           parser.nextToken();
           if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
           if(parser.getText()== 'productId'){
           parser.nextToken();
            pInfo.Product_Id__c=parser.getText();
            pIds.add(parser.getText());
           parser.nextToken(); 
           }
           }
          
           
           pInfos.add(pInfo);
           }
          
       }
       }
     
    }
    insert pInfos;
    */
    for(Id ss:prBaseRecords.keySet())
    {
    insert (prBaseRecords.get(ss));
    }
    
    Map<String,String> prMap=new Map<String,String>();
       for(productBaseInfo__c p:[select id,Product_Id__c from productBaseInfo__c where Product_Id__c IN:pIds])
       {
       prMap.put(p.Product_Id__c,p.id);
       }
       System.debug('........prMap.....................'+prMap);
       //jsonOut=res.getBody();
       
       JSONParser parser1 = JSON.createParser(output);
    while (parser1.nextToken() != null) {
       if (parser1.getCurrentToken() == JSONToken.FIELD_NAME){
         if(parser1.getText()== 'productBaseInfo'){
           
           parser1.nextToken();
           
           parser1.nextToken();
           parser1.nextToken();
           parser1.nextToken();
           if (parser1.getCurrentToken() == JSONToken.FIELD_NAME){
           if(parser1.getText()== 'productId'){
           parser1.nextToken();
           
           if(prMap.get(parser1.getText())!=null || prMap.get(parser1.getText())!='')
           {
           ProductInfo__c pr=new ProductInfo__c();
           pr.name=prod;
            pr.productBaseInfo__c=prMap.get(parser1.getText());
           
             for(Integer i=1;i<=14;i++)
            {
             parser1.nextToken(); 
             }
             if (parser1.getCurrentToken() == JSONToken.FIELD_NAME){
             if(parser1.getText()== 'productAttributes'){
              parser1.nextToken();
               parser1.nextToken();
              if(parser1.getText()== 'title'){
              parser1.nextToken();
              pr.Product_Title__c=parser1.getText();
               parser1.nextToken(); 
              } 
              if(parser1.getText()== 'productDescription'){
              parser1.nextToken(); 
              pr.Description__c=parser1.getText(); 
              }
             }
             }
              jsonOut=parser1.getText(); 
             prs.add(pr);
            }
          
           
           }
           
           }
          
           
          
           }
          
       }
       }
    insert prs;


system.debug('...........pIds......................'+pIds);
Set<Id> proBaseIds=new Set<Id>();
Set<Id> pInfoIds=new Set<Id>();
Map<id,productBaseInfo__c> pbMap = new Map<id,productBaseInfo__c>([select id from productBaseInfo__c where Product_Id__c IN:pIds]);
/*for(productBaseInfo__c p:[select id from productBaseInfo__c where Product_Id__c IN:pIds])
    {
    proBaseIds.add(p.id);
    }
    */
    proBaseIds=pbMap.keySet();
    Map<Id,ProductInfo__c> pInfo=new Map<Id,ProductInfo__c>([select id from ProductInfo__c where productBaseInfo__c IN:proBaseIds]);
   /* for(ProductInfo__c p:[select id from ProductInfo__c where productBaseInfo__c IN:proBaseIds])
    {
    pInfoIds.add(p.id);
    }
    */
    pInfoIds=pInfo.keySet();
    System.debug('.......... prBaseRecords......................'+ prBaseRecords);
    system.debug('...........proInfoIds......................'+pInfoIds);
     System.debug('.......pMap...........................'+pMap);
   
    System.debug('.......pList..........................'+pList);
List<Product_Image__c> pImgUrls=new List<Product_Image__c>();

    for(String s:pInfoIds)
    {
    JSONParser parser2 = JSON.createParser(output);
    flipkartBatch fkartBatch=new flipkartBatch(parser2,s);
    
    /*
    pImgUrls.clear();
     
     String title;
    while (parser2.nextToken() != null) {
       if (parser2.getCurrentToken() == JSONToken.FIELD_NAME){
         if(parser2.getText()== 'productBaseInfo'){
         jsonOut=parser2.getText();
         
         
           parser2.nextToken();
           
           parser2.nextToken();
           parser2.nextToken();
           parser2.nextToken();
           if (parser2.getCurrentToken() == JSONToken.FIELD_NAME){
           if(parser2.getText()== 'productId'){
           parser2.nextToken();
           
           if(prMap.get(parser2.getText())!=null || prMap.get(parser2.getText())!='')
           {
           
           
             for(Integer i=1;i<=14;i++)
            {
             parser2.nextToken(); 
             }
              
             if (parser2.getCurrentToken() == JSONToken.FIELD_NAME){
             if(parser2.getText()== 'productAttributes'){
              parser2.nextToken();
               parser2.nextToken();
               jsonOut=parser2.getText();
              if(parser2.getText()== 'title'){
              parser2.nextToken();
              title=parser2.getText();
               parser2.nextToken(); 
              } 
              if(parser2.getText()== 'productDescription'){
              parser2.nextToken(); 
              parser2.nextToken(); 
              }
             if(parser2.getText()== 'imageUrls'){
             parser2.nextToken(); 
              if (parser2.getCurrentToken() == JSONToken.START_OBJECT) {
              while (parser2.nextToken() != null && parser2.getCurrentToken() == JSONToken.END_OBJECT) {
             
             if (parser2.getCurrentToken() == JSONToken.FIELD_NAME){
             Product_Image__c pImgUrl=new Product_Image__c();
             pImgUrl.name=title;
             pImgUrl.ProductInfo__c=s;
             pImgUrl.imageSize__c=parser2.getText();
               parser2.nextToken();
             
               if((parser2.getCurrentToken() == JSONToken.VALUE_STRING)){
               pImgUrl.ImageUrl__c=parser2.getText();
               }
              pImgUrls.add(pImgUrl);
             }
              }
              }
             
             }
             }
             }
              jsonOut=parser2.getText(); 
            
            }
          
           
           }
           
           }
          
           
          
           }
          
       }
       }
   */
    }
    System.debug('.........pImgUrls.....................'+pImgUrls);
   // insert pImgUrls; 
     
    
   /* 
    HttpRequest httpReq=new HttpRequest();
    httpReq.setEndpoint('https://affiliate-api.flipkart.net/affiliate/feeds/narsinghb/category/reh.json?expiresAt=1443038696068&sig=14d2cbd70ad04086b7530538fc00dc62');
    
    httpReq.setMethod('GET');
    httpReq.setHeader('Fk-Affiliate-Id', 'narsinghb');
     httpReq.setHeader('Fk-Affiliate-Token', 'ed786eafbbf64c4d8b9af5b388b16af2');
    Http http = new Http();
     HTTPResponse res = http.send(httpReq);
     System.debug(res.getBody());
     jsonOut=res.getBody(); 
   
     */
    
   
     
   
     
     
        return null;
    }


    public String jsonOut { get; set; }
}