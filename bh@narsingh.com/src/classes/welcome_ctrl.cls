global class welcome_ctrl {

    public PageReference veriByCodeSendMsg() {
    Id accId=[select id from Account where name='findAccount'].id;
    String vfC=[select id,verification_code__c from contact where AccountId=:accId and email=:userMail].verification_code__c;
    if(vfCode==vfC)
    {
    smsClass sms=new smsClass(recipient,message);
    }
        return null;
    }


public String randomCode;
public String getVfCode() {
    String code='Code:';
    code+=(getChar1()+getChar2()+getChar3()+getChar4()+getChar5()+getChar1());
    randomCode=code;
    
        return code;
    }
    List<String> characters;   
 public Integer randomNumber(){
        Integer random = Math.Round(Math.Random() * characters.Size());
        if(random == characters.size()){
            random--;
        }
        return random;
    }
    public String getChar1(){
        
        return characters[randomNumber()];
    }
    public String getChar2(){
        return characters[randomNumber()];
    }
    public String getChar3(){
        return characters[randomNumber()];
    }
    public String getChar4(){
        return characters[randomNumber()];
    }
    public String getChar5(){
        return characters[randomNumber()];
    }
    public String getChar6(){
        return characters[randomNumber()];
    }

    public PageReference sendVfCode() {
    String vfcode;
    OrgWideEmailAddress owa = [select id, DisplayName, Address from OrgWideEmailAddress limit 1];
   // EmailTemplate template=[select id from EmailTemplate where name='Email Subscription'];
   // List<Messaging.SingleEmailMessage> mails=new List<Messaging.SingleEmailMessage>();
    Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
   // mail.setTemplateID(template.id);
    mail.setOrgWideEmailAddressId(owa.id);
    mail.setSaveAsActivity(false); 
    List<String> sendTo=new List<String>();
    sendTo.add(userMail);
    mail.setToAddresses(sendTo);
  //  mail.setReplyTo('narsingbh@gmail.com');
   // mail.setSenderDisplayName('find@nything.com');
      mail.setSubject('Your verification code');
      vfcode=getVfCode();
      String body = 'Code:'+vfcode;
      
      mail.setHtmlBody(body);
  //  mails.add(mail);
  
    List<Messaging.SendEmailResult> results=Messaging.sendEmail(new Messaging.Email[]{mail});
    if(results.get(0).isSuccess())
    {
    Id accId=[select id from Account where name='findAccount'].id;
    Contact c=new Contact();
    c.accountID=accId;
    c.lastname=userMail;
    c.Email=userMail;
    c.verification_code__c=vfcode;
    insert c;
    }
    else
    {
     System.StatusCode statusCode = results.get(0).getErrors()[0].getStatusCode();
    String errorMessage = results.get(0).getErrors()[0].getMessage();
    }
        return null;
    }


    public String vfCode { get; set; }

    public String userMail { get; set; }

    public String message { get; set; }

    public String recipient { get; set; }

public Map<String,String> shopingLinks {get;set;}
    public PageReference data() {
    
    for(flipkart__c fkart:[select id,name from flipkart__c])
    {
    String link='/apex/shoping?prod='+fkart.name;
    shopingLinks.put(fkart.name,link);
    }
        return null;
    }


    

    public PageReference GoLink() {
        PageReference pg=new PageReference('/apex/welcome');
        return pg;
    }


    public PageReference rightContentDisplay() {
    rightView=Apexpages.currentPage().getParameters().get('rightMenu');
        return null;
    }

    public String leftView{get;set;}
    public String rightView{get;set;}
    public PageReference leftcontentDisplay() {
    contentView='';
    leftView=Apexpages.currentPage().getParameters().get('leftMenu');
        return null;
    }

    
    public String contentView{get;set;}
    public PageReference Submit() {
    PageReference pg=new PageReference('/apex/book_train');
    
        return pg;
    }


    public String jrDat { get; set; }

    public String BookDesText { get; set; }

    public String BookSrcText { get; set; }

   

  

    

    public PageReference BySrcDest() {
    PageReference pg=new PageReference('/apex/train_view');
    pg.getParameters().put('know','1');
    pg.getParameters().put('srcText',srcText);
    pg.getParameters().put('destText',destText);
    pg.getParameters().put('selClass',selClass);
    pg.getParameters().put('dat',dat);
        return pg;
       
    }


    public PageReference GetTrsInfo() {
    PageReference pg=new PageReference('/apex/train_view');
    pg.getParameters().put('know','2');
    pg.getParameters().put('tName',tText);
    pg.getParameters().put('tNo',tNoS);
        return pg;
    }


    public List<selectOption> TrNos { get; set; }

    public String tNoS { get; set; }

    public PageReference chooseTrainNos() {
    TrNos.clear();
    Set<String> tNos=new Set<String>();
     for(Train__c tc:[select id,Train_No__c from Train__c where name=:tText])
       {
       tNos.add(String.valueOf(tc.Train_no__c));
      
       }
       TrNos.add(new SelectOption('None','None'));
    for(String tNo:tNos)
    {
     TrNos.add(new SelectOption(tNo,tNo));
    }
        return null;
    }


    public String tText { get; set; }

  

    public String dat { get; set; }

    public String selClass { get; set; }

    public PageReference GetTimings() {
        return null;
    }


    public String destText { get; set; }

    public String srcText { get; set; }

    public welcome_ctrl()
    {
     characters = new List<String>{'a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p','q','r','s','t','u','v','w',
            'x','y','z','1','2','3','4','5','6','7','8','9','0'
        };
    shopingLinks=new Map<String,String>();
    for(flipkart__c fkart:[select id,name from flipkart__c])
    {
    String link='/apex/shoping?prod='+fkart.name;
    shopingLinks.put(fkart.name,link);
    }
    leftView='main';
    rightView='main';
    contentView=Apexpages.currentPage().getParameters().get('show');
     System.debug('......contentView..................'+contentView);
    TrNos=new List<SelectOption>();
     TrNos.add(new SelectOption('None','None'));
    }
    public boolean travelView{get;set;}
    public boolean shopingView{get;set;}
    public boolean mainView{get;set;}
    public boolean show{get;set;}
    public PageReference viewPage() {
    String pgName=Apexpages.currentPage().getParameters().get('pgName');
    System.debug('......pageName.....................'+pgName);
     if(pgName=='Travel')
    {
    show=true;
    travelView=true;
    shopingView=false;
    mainView=false;
    }
    else if(pgName=='Shoping')
    {
    travelView=false;
    shopingView=true;
    mainView=false;
    }
    else
    {
    travelView=false;
    shopingView=false;
    mainView=true;
    }
     System.debug('......travelView...'+travelView+'.....shopingView....'+shopingView+'.......mainView...............'+mainView);
    return null;
  
    /* PageReference pg=new PageReference('/apex/welcome');
      pg.getParameters().put('show',pgName);
        return pg;
        */
    }
    @RemoteAction
    global static List<String> pageContentView(String nms) {
    System.debug('........nms..................'+nms);
     List<String> details=new List<String>();
     if(nms=='Travel')
     {
     details.add('BUS');
     details.add('TRAIN');
     details.add('CAR');
     details.add('FLIGHT');
     }
     else if(nms=='Shoping')
     {
     details.add('CLOTHES');
     details.add('JEWELERY');
     details.add('ELECTRONIC PRODUCTS');
     details.add('FOOD');
     }
     
    return details;
    }
}