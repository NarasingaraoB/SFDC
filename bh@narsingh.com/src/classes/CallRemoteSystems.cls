public class CallRemoteSystems {

    public boolean successfullSaveNewCust {get;set;}
    public String BillingCountry { get; set; }
    public String BillingPostalCode { get; set; }
    public String BillingState { get; set; }
    public String BillingCity { get; set; }
    public String BillingStreet { get; set; }
    public String Customer_ID { get; set; }
    public String AccountNumber { get; set; }
    public String Name { get; set; }
    public boolean successAuth { get; set; }
    public String loginURL { get; set; }
    public String loginURL1 { get; set; }
    public boolean acces_token=false;
    public billingInfoJson billingInfo {get;set;}
    public billingInfoErrorJson billingErrorInfo {get;set;}
    public final String clientId='3MVG9d8..z.hDcPL0CEwH3hW3TA0o6vrMe3QeRAXGdRcs7p7Clcnx61ka0yw_iKwTGttz0Svg63lF2ow.8lzE';//narsing@sfdc.com org--SFDCIntegration APP
    public final String clientSecret='E872143F32BC7CD9115AEADF156CB46C9BB79BD8EACA880F5FCEDD3ABFD14446';
    public String redirectURI='https%3A%2F%2Fscjmn-dev-ed--c.ap6.visual.force.com%2Fapex%2FGetCustomerInfoFromRemoteSystems';
    public String authorizeCode;
    public String accessToken;
    public String customerId { get; set; }

    public void editCustomer() {
        String AccountN=apexpages.currentpage().getparameters().get('AccountN');
        system.debug('..##AccountN'+AccountN);
        String endPoint = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account/Customer_ID__c/'+customerId+'?_HttpMethod=PATCH';        
        Map<String,Object> newAcc=new Map<String,Object>();
        newAcc.put('Name',Name);
        newAcc.put('AccountNumber',AccountN);


        String reqbody=JSON.Serialize(newAcc);
        system.debug('..##reqbody'+reqbody);
        Http h2 = new Http();
        HttpResponse res1;
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization','Bearer ' + accessToken);
        req1.setHeader('Content-Type','application/json');
        req1.setHeader('accept','application/json');
        req1.setEndpoint(endPoint);
        req1.setBody(reqbody);
        req1.setMethod('POST');
        try {
        res1 = h2.send(req1);
        }
        catch(System.CalloutException e) {
        System.debug('Callout error: '+ e);
        System.debug(res1.toString());
        }

        System.debug('......res2............'+res1);
        System.debug('......res2...body.........'+res1.getBody());
    }


    public void CustomerModifyInfo() 
    {
        system.debug('..customerId..'+customerId);
        if(successAuth)
        {
            //Get Field Values from a Standard Object Record
            // String endPoint = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account/0017F00001bgSaG?fields=BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Customer_ID__c';
            //Get Field Values from an External Object Record by Using the Salesforce ID
            // String endPoint = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account__c/0017F00001bgSaG?fields=BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Customer_ID__c';
            //Retrieve a Record Using an External ID
            //create new custom field and set as true to ExternalID checkbox
            String endPoint = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account/Customer_ID__c/'+customerId+'?fields=Name,AccountNumber,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Customer_ID__c';        
            Http h2 = new Http();
            HttpResponse res1;
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setHeader('Content-Length', '0');
            req1.setTimeout(60000);
            req1.setEndpoint(endPoint);
            req1.setMethod('GET');
            req1.setCompressed(true);   
            System.debug('......req2............'+req1);
            try {
            res1 = h2.send(req1);
            }
            catch(System.CalloutException e) 
            {
            System.debug('Callout error: '+ e);
            System.debug(res1.toString());
            }

            System.debug('......res2............'+res1);
            System.debug('......res2...body.........'+res1.getBody());
            String jsonResponse =res1.getBody();
            jsonResponse = jsonResponse.replace('"Customer_ID__c":', '"CustomerID":');
            System.debug('......res2...jsonResponse .........'+jsonResponse);
            if(res1.getStatus()=='OK' && res1.getStatusCode()==200)
            {
            billingInfoJson billingInfo1= (billingInfoJson)JSON.deserialize(jsonResponse,billingInfoJson.class);
            System.debug('......billingInfo1............'+billingInfo1);
            billingErrorInfo=null;
            Name=billingInfo1.Name;
            AccountNumber=billingInfo1.AccountNumber;
            Customer_ID=customerId;
            }
            else if(res1.getStatusCode()==404)
            {
            //response.statusCode = 404
            // billingInfoErrorJson [] errs = new billingInfoErrorJson []{ 
            //new billingInfoErrorJson ('NOT_FOUND', 'Requested customer id not found')};
            billingErrorInfo =new billingInfoErrorJson ('NOT_FOUND', 'Requested customer id not found');
            }

            system.debug('.billingErrorInfo..'+billingErrorInfo);


        }




    }


    public void saveCustomer() 
    {
        String endPoint='https://ap5.salesforce.com/services/data/v20.0/sobjects/Account';
        Map<String,Object> newAcc=new Map<String,Object>();
        newAcc.put('Name',Name);
        newAcc.put('AccountNumber',AccountNumber);
        newAcc.put('Customer_ID__c',Customer_ID);

        String reqbody=JSON.Serialize(newAcc);

        Http h2 = new Http();
        HttpResponse res1;
        HttpRequest req1 = new HttpRequest();
        req1.setHeader('Authorization','Bearer ' + accessToken);
        req1.setHeader('Content-Type','application/json');
        req1.setHeader('accept','application/json');
        req1.setEndpoint(endPoint);
        req1.setBody(reqbody);
        req1.setMethod('POST');
         try {
          
          res1 = h2.send(req1);
         
        }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res1.toString());
        }
        successfullSaveNewCust =true;
        successAuth=false;
    }

    

    public CallRemoteSystems ()
    {
        loginURL ='https://ap5.salesforce.com/services/oauth2/authorize?response_type=code&client_id='+clientId+'&redirect_uri='+redirectURI;
        loginURL1 ='/apex/LoginWithUserAgentflowAuth';
        String code=apexpages.currentpage().getparameters().get('code');
        String access_token=apexpages.currentpage().getparameters().get('access_token');
        system.debug('##Code'+code);
        system.debug('##access_token'+access_token);
        system.debug('##host '+ApexPages.currentPage().getHeaders());
    if(code!=null)
    {
        String reqbody = 'grant_type=authorization_code&code='+code+'&client_id='+clientId+'&client_secret='+clientSecret+'&redirect_uri='+redirectURI;

        Http h=new Http();
        HttpRequest req=new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://ap5.salesforce.com/services/oauth2/token');
        HttpResponse res = h.send(req);
        System.debug('......res............'+res);
        System.debug('......res............'+res.getBody());
        deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
        System.debug('......res............'+resp1);
        System.debug('......res............'+resp1.access_token);
        System.debug('......res............'+res.getStatus());
        System.debug('......res............'+res.getStatusCode());
        if(res.getStatus()=='OK' && res.getStatusCode()==200 && !String.isEmpty(code))
        {
        successAuth =true;
        accessToken=resp1.access_token;
        }
        else
        {
        successAuth=false;
        }
    }
    
    
}    
   
    
    
  
    public void CustomerBillingInfo() 
    {
        system.debug('..customerId..'+customerId);
        if(successAuth)
        {

            //Get Field Values from a Standard Object Record
            // String endPoint = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account/0017F00001bgSaG?fields=BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Customer_ID__c';
            //Get Field Values from an External Object Record by Using the Salesforce ID
            // String endPoint = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account__c/0017F00001bgSaG?fields=BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Customer_ID__c';
            //Retrieve a Record Using an External ID
            //create new custom field and set as true to ExternalID checkbox
            String endPoint = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account/Customer_ID__c/'+customerId+'?fields=BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Customer_ID__c';        
            Http h2 = new Http();
            HttpResponse res1;
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setHeader('Content-Length', '0');
            req1.setTimeout(60000);

            //req1.setBody(jsonstr);

            req1.setEndpoint(endPoint);
            req1.setMethod('GET');

            req1.setCompressed(true);   
            System.debug('......req2............'+req1);
            try {

            res1 = h2.send(req1);

            }
            catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res1.toString());
            }

            System.debug('......res2............'+res1);
            System.debug('......res2...body.........'+res1.getBody());
            String jsonResponse =res1.getBody();
            jsonResponse = jsonResponse.replace('"Customer_ID__c":', '"CustomerID":');
            System.debug('......res2...jsonResponse .........'+jsonResponse);
            if(res1.getStatus()=='OK' && res1.getStatusCode()==200)
            {

            billingInfo= (billingInfoJson)JSON.deserialize(jsonResponse,billingInfoJson.class);
            System.debug('......billingInfo............'+billingInfo);
            billingErrorInfo=null;
            }
            else if(res1.getStatusCode()==404)
            {
            //response.statusCode = 404
            // billingInfoErrorJson [] errs = new billingInfoErrorJson []{ 
            //new billingInfoErrorJson ('NOT_FOUND', 'Requested customer id not found')};
            billingErrorInfo =new billingInfoErrorJson ('NOT_FOUND', 'Requested customer id not found');
            }

            system.debug('.billingErrorInfo..'+billingErrorInfo);


        }
       
    }


 
    
  
    
   
    class deserializeResponse
    {
        public String id;
        public String access_token;

        }

        class billingInfoJson 
        {
        public String Name {get;set;}
        public String AccountNumber {get;set;}
        public String CustomerID {get;set;}
        public String BillingStreet {get;set;}
        public String BillingCity {get;set;}
        public String BillingState {get;set;}
        public String BillingPostalCode {get;set;}
        public String BillingCountry {get;set;}
        }
        class billingInfoErrorJson 
        {
        public String errorCode{get;set;}
        public String message{get;set;}
        public billingInfoErrorJson(String errorCode,String message)
        {
        this.errorCode=errorCode;
        this.message=message;
        }
    }
}