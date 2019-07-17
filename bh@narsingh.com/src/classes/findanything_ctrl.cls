public class findanything_ctrl
{
 String LOGIN_DOMAIN = 'www';
 public String pwd='developer1';
    public String userNm='bh@narsingh.com';
    public PageReference setInitialSession() {
    System.debug('........sess..............');
    
        //-----------------------------------
        // Login via SOAP/XML web service api
        //-----------------------------------
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://' + LOGIN_DOMAIN + '.salesforce.com/services/Soap/u/33.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        request.setHeader('SOAPAction', '""');
        request.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + userNm+ '</username><password>' + pwd+ '</password></login></Body></Envelope>');
       /* Dom.XmlNode resultElmt = (new Http()).send(request).getBodyDocument().getRootElement().getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/').getChildElement('loginResponse', 'urn:partner.soap.sforce.com').getChildElement('result', 'urn:partner.soap.sforce.com');
        final String SERVER_URL = resultElmt.getChildElement('serverUrl', 'urn:partner.soap.sforce.com') .getText().split('/services')[0];
        final String SESSION_ID = resultElmt.getChildElement('sessionId', 'urn:partner.soap.sforce.com') .getText();
         final PageReference theUrl = new PageReference(SERVER_URL + '/services/data/v22.0/query/');
        theUrl.getParameters().put('q','Select a.Phone, a.Name, a.CreatedBy.FirstName, a.CreatedById From Account a limit 10');
        request = new HttpRequest();
        request.setEndpoint(theUrl.getUrl());
        request.setMethod('GET');
        request.setHeader('Authorization', 'OAuth ' + SESSION_ID);
        System.debug('...........session..............'+SESSION_ID);
        
        System.debug('.......request.................'+((new Http()).send(request).getBodyDocument()));
       */
        return null;
    }


    public String gender { get; set; }

    

    public String accType { get; set; }

    public String loginError { get; set; }

    public String errorReg { get; set; }

    public boolean nullregValues { get; set; }
    public findanything_ctrl()
    {
    characters = new List<String>{'a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p','q','r','s','t','u','v','w',
            'x','y','z','1','2','3','4','5','6','7','8','9','0'
        };
    }
    public boolean nullEmail { get; set; }

    public PageReference loginPage() {
    if(userName!='' && vfCode!='')
    {
    List<contact> existEmail=[select id from contact where email=:userName limit 1];
    if(existEmail!=null && existEmail.size()>0)
    {
    contact existCode=[select id, verification_code__c from contact where id=:existEmail[0].id limit 1];
    if(existCode.verification_code__c!='')
    {
    if(existCode.verification_code__c==vfCode)
    {
     PageReference pg=new PageReference('/apex/welcome');
    pg.getParameters().put('conid',existCode.id);
        return pg;
    }
    else
    {
    nullEmail=true;
    loginError='Your verification code is not match'; 
    }
    }
    else
    {
    nullEmail=true;
    loginError='Your verification code is expired get new one'; 
    }
    }
    else
    {
    nullEmail=true;
    loginError='Your email is not registered'; 
    }
    
    }
    else if(userName!='' && vfCode=='')
    {
    nullEmail=true;
    loginError='please enter verifivation code'; 
    }
    else if(userName=='' && vfCode!='')
    {
    nullEmail=true;
    loginError='please enter email'; 
    }
    else if(userName=='' && vfCode=='')
    {
    nullEmail=true;
    loginError='please enter email and verification code'; 
    }
    return null;
    }


    public PageReference validateAndGetCode() {
    if(userName!='')
    {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<contact> con=[select email from contact where email=:userName limit 1];
    System.debug('.........con.............'+con);
    if(con!=null && con.size()>0)
    {
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    List<String> sendTo = new List<String>();
      sendTo.add(con[0].Email);
    mail.setToAddresses(sendTo);
    mail.setReplyTo('narsingh.bh@gmail.com');
      mail.setSenderDisplayName('Find@nything Support Team');
      mail.setSubject('Verification code for login for 24 hours');
      String body='verfication code for login is:0000';
      mail.setHtmlBody(body);
      mails.add(mail);
      Messaging.sendEmail(mails);
    }
    else
    {
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    List<String> sendTo = new List<String>();
      sendTo.add(userName);
    mail.setToAddresses(sendTo);
    mail.setReplyTo('narsingh.bh@gmail.com');
      mail.setSenderDisplayName('Find@nything Support Team');
      mail.setSubject('Your email is not registered');
      String body='please click below link to register';
      mail.setHtmlBody(body);
      mails.add(mail);
      Messaging.sendEmail(mails);
      nullEmail=true;
    loginError='Your email is not registered'; 
    }
    }
    else
    {
    nullEmail=true;
    loginError='Please enter email'; 
    }
        return null;
    }


    public Integer mobNo { get; set; }

    public String email { get; set; }

    public String lname { get; set; }

    public String fname { get; set; }

    public PageReference registerData() {
    
    System.debug('....fname....'+fname+'.......lname............'+lname);
     List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    if(accType=='')
    {
      nullregValues=true;
      errorReg='Please choose account type';
      
    }
   else if(fname=='')
    {
      nullregValues=true;
      errorReg='Please enter first name';
      
    }
    else if(lname=='')
    {
      nullregValues=true;
      errorReg='Please enter last name';
      
    }
    else if(email=='')
    {
      nullregValues=true;
      errorReg='Please enter email id';
      
    }
    else
    {
    nullregValues=false;
    
    if(email.contains('@') && email.contains('.com'))
    {
    String accName=fname+' '+lname;
    Account acc=new Account();
    acc.name=accName;
    insert acc;
    Contact con=new Contact();
    con.AccountId=[select id from account where name=:accName].id;
    con.firstname=fname;
    con.lastname=lname;
    con.email=email;
    con.mobile_no__c=mobNo;
    String vfCode=getGetVFcode();
    con.verification_code__c=vfCode;
    con.accountType__c=accType;
    con.gender__c=gender;
    insert con;
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    List<String> sendTo = new List<String>();
      sendTo.add(email);
    mail.setToAddresses(sendTo);
    mail.setReplyTo('narsingh.bh@gmail.com');
      mail.setSenderDisplayName('Find@nything Support Team');
      mail.setSubject('Welcome to find@nyting');
      String body='You login information:verifaction code for login is:'+vfCode;
      mail.setHtmlBody(body);
      mails.add(mail);
      Messaging.sendEmail(mails);
      PageReference pg=new PageReference('/apex/regSuccess');
      return pg;
    }
    else
    {
     nullregValues=true;
      errorReg='Please enter valid email id';
    }
    }
    
        return null;
    }

    public String vfCode { get; set; }
    public String userName { get; set; }
    
    public String getGetVFcode() {
    String vfCode='';
    vfCode+=(getChar1()+getChar2()+getChar3()+getChar4()+getChar5()+getChar1());
    
        return vfCode;
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
}