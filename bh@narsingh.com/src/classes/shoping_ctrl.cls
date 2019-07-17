public class shoping_ctrl {
String prod;
public List<String> imgUrls {get;set;}
public List<priceWrapper> proDetails {get;set;}
public shoping_ctrl()
{
imgUrls=new List<String>();
proDetails=new List<priceWrapper>();
prod=Apexpages.currentPage().getParameters().get('prod');
System.debug('.......prod......................'+prod);
if(prod!=null)
{
Id fid=[select id from flipkart__c where name=:prod limit 1].id;

System.debug('.........fid....................'+fid);
Map<Id,productBaseInfo__c> pBase=new Map<Id,productBaseInfo__c>([select id from productBaseInfo__c where flipkart__c=:fid]);
Set<Id> pBaseIds=pBase.keySet();
System.debug('........pBaseIds.....................'+pBaseIds);
Map<Id,ProductInfo__c> pInfo=new Map<Id,ProductInfo__c>([select id from ProductInfo__c where productBaseInfo__c IN: pBaseIds]);
Set<Id> pInfoIds=pInfo.keySet();
System.debug('........pInfoIds.....................'+pInfoIds);

Map<id,priceWrapper> priceMap=new Map<id,priceWrapper>();
for(Product_Price__c pPrice:[select id,Prod_Name__c,Retail_Price__c,Selling_Price__c,Brand__c,Color__c,Stock__c,Prod_url__c,ProductInfo__c from Product_Price__c where ProductInfo__c IN:pInfoIds])
{
priceWrapper wrapper=new priceWrapper();
wrapper.proName=pPrice.Prod_Name__c;
wrapper.retailPrice=String.valueOf(pPrice.Retail_Price__c);
wrapper.sellingPrice=String.valueOf(pPrice.Selling_Price__c);
wrapper.color=pPrice.Color__c;
wrapper.brandName=pPrice.Brand__c;
wrapper.prodUrl=pPrice.Prod_url__c;
priceMap.put(pPrice.ProductInfo__c,wrapper);
}
for(Product_Image__c pimage:[select id,imageSize__c,ImageUrl__c,ProductInfo__c from Product_Image__c where ProductInfo__c IN:pInfoIds])
{
if((pimage.imageSize__c)!='unknown')
{
Integer size=Integer.valueOf((pimage.imageSize__c).split('x')[0]);

if(size>=180 && size<200)
{

proDetails.add(priceMap.get(pimage.ProductInfo__c));
imgUrls.add(pimage.ImageUrl__c);
}
else if(size>=200 && size<250)
{
proDetails.add(priceMap.get(pimage.ProductInfo__c));
imgUrls.add(pimage.ImageUrl__c);
}
}
}
}
}
class priceWrapper
{
public String proName {get;set;}
public String retailPrice {get;set;}
public String sellingPrice {get;set;}
public String brandName {get;set;}
public String color {get;set;}
public String prodUrl {get;set;}
}
}