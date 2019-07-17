public class flipkart_deserialize {
    public  String output;
    public  String prod;
    public flipkart_deserialize()
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
    //System.debug(LoggingLevel.Debug, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
    HTTPResponse res = http.send(httpReq);
    // System.debug(LoggingLevel.Debug, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
     jsonOut=res.getBody();
     output=res.getBody();
    JSONParser parser = JSON.createParser(res.getBody());
    
    wrapperList=new List<fKartWrapper>();
    
      while (parser.nextToken() != null) {
       if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
         if(parser.getText()== 'productBaseInfo'){
         fKartWrapper  wrapper=new fKartWrapper();
         parser.nextToken();
           parser.nextToken();
           parser.nextToken();
           parser.nextToken();
           if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
            if(parser.getText()== 'productId'){
           parser.nextToken();
            
           if(parser.getText()!=null || parser.getText()!='')
           {
          wrapper.name=prod;
          
                
                wrapper.prodId=parser.getText();
               
           }
            for(Integer i=1;i<=14;i++)
            {
             parser.nextToken(); 
             }
           if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
             if(parser.getText()== 'productAttributes'){
              parser.nextToken();
               parser.nextToken();
              if(parser.getText()== 'title'){
              parser.nextToken();
              wrapper.title=parser.getText();
               parser.nextToken(); 
              } 
              if(parser.getText()== 'productDescription'){
              parser.nextToken(); 
              wrapper.descp=parser.getText(); 
               parser.nextToken(); 
              
              }
              if(parser.getText()== 'imageUrls'){
             parser.nextToken(); 
              
              if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
              List<imgWrapper> imgs=new List<imgWrapper>();
              while (parser.nextToken() != null && parser.getCurrentToken() != JSONToken.END_OBJECT) {
             imgWrapper img=new imgWrapper();
             if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
             
            
             img.size=parser.getText();
               parser.nextToken();
             
               if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
              
               img.url=parser.getText();
               }
              
             }
             imgs.add(img);
              }
              wrapper.images=imgs;
              }
              parser.nextToken(); 
             
             }
              if(parser.getText()== 'maximumRetailPrice'){
              parser.nextToken(); 
              parser.nextToken();
              parser.nextToken(); 
              wrapper.retailPrice=Decimal.valueOf(parser.getText());
               parser.nextToken(); 
                parser.nextToken(); 
                 parser.nextToken(); 
                  parser.nextToken(); 
                     
             }
             if(parser.getText()== 'sellingPrice'){
             
              parser.nextToken(); 
              parser.nextToken(); 
              parser.nextToken();
             
              
              wrapper.sellingPrice=Decimal.valueOf(parser.getText());
               parser.nextToken(); 
               parser.nextToken(); 
               parser.nextToken(); 
               parser.nextToken(); 
                    
             }
             if(parser.getText()== 'productUrl'){
             if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
              parser.nextToken(); 
               if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
               wrapper.prodUrl=parser.getText();
               parser.nextToken(); 
               }
               }
             }
             if(parser.getText()== 'productBrand'){
             if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
              parser.nextToken(); 
               if((parser.getCurrentToken() == JSONToken.VALUE_STRING)){
               wrapper.brand=parser.getText();
               parser.nextToken(); 
               
               }
               }
             }
             if(parser.getText()== 'inStock'){
             
              parser.nextToken(); 
             
               wrapper.stock=Boolean.valueOf(parser.getText());
               parser.nextToken(); 
                  
             }
             if(parser.getText()== 'codAvailable'){
            
              parser.nextToken(); 
              
               wrapper.codAvail=Boolean.valueOf(parser.getText());
               parser.nextToken(); 
               
             }
             if(parser.getText()== 'emiAvailable'){
            
              parser.nextToken(); 
              
               wrapper.emiAvail=parser.getText();
               parser.nextToken(); 
              
             }
             if(parser.getText()== 'discountPercentage'){
             
              parser.nextToken(); 
              
               wrapper.discount=Decimal.valueOf(parser.getText());
               parser.nextToken(); 
              
             }
             if(parser.getText()== 'cashBack'){
            
              parser.nextToken(); 
               
               wrapper.cashBack=parser.getText();
               parser.nextToken();
               parser.nextToken(); 
               parser.nextToken();  
               parser.nextToken(); 
              jsonOut=parser.getText();
             }
             if(parser.getText()== 'size'){
             
              parser.nextToken(); 
              
               wrapper.size=parser.getText();
               parser.nextToken(); 
              
             }
             if(parser.getText()== 'color'){
             
              parser.nextToken(); 
               
               wrapper.color=parser.getText();
               parser.nextToken(); 
               
             }
             }
             }
           }
           
           wrapperList.add(wrapper);
           if(wrapperList.size()>20)
           {
           break;
           }
           }
         
         }
         }
         }
        // System.debug('...........wrapperList..............'+wrapperList);
         RecordInsertion(s);
    }
    
    return null;

    }
    public void RecordInsertion(flipkart__c s)
    {
    List<productBaseInfo__c> pInfos=new List<productBaseInfo__c>();
    Set<String> pIds=new Set<String>();
    for(fKartWrapper fkart:wrapperList)
    {
     productBaseInfo__c pInfo=new productBaseInfo__c();
                pInfo.name=prod;
                pInfo.flipkart__c=s.id;
                pInfo.Product_Id__c=fkart.prodId;
                pIds.add(fkart.prodId);
               pInfos.add(pInfo); 
              
    }
    insert pInfos;
     Map<String,String> prMap=new Map<String,String>();
       for(productBaseInfo__c p:[select id,Product_Id__c from productBaseInfo__c where Product_Id__c IN:pIds])
       {
       prMap.put(p.Product_Id__c,p.id);
       }
       System.debug('........prMap.....................'+prMap);
       List<ProductInfo__c> prs=new List<ProductInfo__c>();
    for(fKartWrapper fkart:wrapperList)
    {
    ProductInfo__c pr=new ProductInfo__c();
           pr.name=prod;
            pr.productBaseInfo__c=prMap.get(fkart.prodId);
             pr.Product_Title__c=fkart.title;
             pr.Description__c=fkart.descp; 
             prs.add(pr);
    }
    insert prs;
    Set<Id> proBaseIds=new Set<Id>();
Set<Id> pInfoIds=new Set<Id>();
Map<id,productBaseInfo__c> pbMap = new Map<id,productBaseInfo__c>([select id,Product_Id__c from productBaseInfo__c where Product_Id__c IN:pIds]);
proBaseIds=pbMap.keySet();
    Map<Id,ProductInfo__c> pInfo=new Map<Id,ProductInfo__c>([select id,productBaseInfo__c from ProductInfo__c where productBaseInfo__c IN:proBaseIds]);   
    pInfoIds=pInfo.keySet();
   System.debug('.........pInfoIds........................'+pInfoIds);
List<Product_Image__c> pImgUrls=new List<Product_Image__c>(); 
List<Product_Price__c> pPrices=new List<Product_Price__c>(); 
for(Id a:pInfoIds)
{
String prodId=(pbMap.get(pInfo.get(a).productBaseInfo__c)).Product_Id__c;

for(fKartWrapper fkart:wrapperList)
    {
    if(fkart.prodId==prodId)
    {
    String title=fkart.title;
    for(imgWrapper imgs:fkart.images)
    {
     if((imgs.size)!='unknown')
{
Integer size=Integer.valueOf((imgs.size).split('x')[0]);
jsonOut=String.valueOf(size);
if(size>=180 && size<200)
{

    Product_Image__c pImgUrl=new Product_Image__c();
    pImgUrl.Prod_Title_Name__c=title;
             pImgUrl.ProductInfo__c=a;
             pImgUrl.imageSize__c=imgs.size;
             pImgUrl.ImageUrl__c=imgs.url;
             pImgUrls.add(pImgUrl);
}
else if(size>=200 && size<250)
{
jsonOut=imgs.url;
 Product_Image__c pImgUrl=new Product_Image__c();
    pImgUrl.Prod_Title_Name__c=title;
             pImgUrl.ProductInfo__c=a;
             pImgUrl.imageSize__c=imgs.size;
             pImgUrl.ImageUrl__c=imgs.url;
             pImgUrls.add(pImgUrl);
}
}
            
    }
    Product_Price__c pPrice=new Product_Price__c();
    pPrice.Prod_Name__c=title;
    pPrice.Retail_Price__c=fkart.retailPrice;
    pPrice.Selling_Price__c=fkart.sellingPrice;
    pPrice.Brand__c=fkart.brand;
    pPrice.CashBack__c=fkart.cashBack;
    pPrice.Cod_Available__c=fkart.codAvail;
    pPrice.Color__c=fkart.color;
    pPrice.Discount__c=fkart.discount;
    pPrice.EMI_Available__c=fkart.emiAvail;
    pPrice.Prod_url__c=fkart.prodUrl;
    pPrice.ProductInfo__c=a;
    pPrice.Size__c=fkart.size;
    pPrice.Stock__c=fkart.stock;
    pPrices.add(pPrice);
    }
    }
}
insert pImgUrls;
insert pPrices;
    }
    class imgWrapper
    {
    String size;
    String url;
    }
    class fKartWrapper 
    {
    String name;
    String prodId;
    String title;
    String descp;
    String imgUrl;
    String imgSize;
    Decimal retailPrice;
    Decimal sellingPrice;
    String prodUrl;
    String brand;
    boolean stock;
    boolean codAvail;
    String emiAvail;
    Decimal discount;
    String cashBack;
    String size;
    String color;
    List<imgWrapper> images;
   /* public fKartWrapper(String name,String prodId)
    {
    this.name=name;
    this.prodId=prodId;
    }*/
    }
    public List<fKartWrapper> wrapperList { get; set; }
    public Map<String, Object> m { get; set; }
    public String jsonOut { get; set; }
}