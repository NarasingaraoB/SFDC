@RestResource(urlMapping='/Account/*')  
global with sharing class callAccount {  
   @HttpPost  
   global static String doPost() {  
    //Returns the RestRequest object for our Apex REST method.  
     RestRequest request = RestContext.request;  
     //Returns the RestResponse for our Apex REST method.  
     RestResponse response = RestContext.response;  
     //Access the request body with input data coming in the JSON format  
     String jSONRequestBody=request.requestBody.toString().trim();  
     //Deserializes the input JSON string into an Account object  
     Account accObj = (Account)JSON.deserializeStrict(jSONRequestBody,Account.class);  
     //insert the account object and return the account ID   
     insert accObj;  
     return accObj.Id;  
   }
    @HttpGet  
   global static Account doGet() {  
   /*  
       RestContext Class - Allows us to access the RestRequest and RestResponse objects in your Apex REST methods.   
       RestRequest class - Allows us to pass request data into our Apex RESTful Web service method.  
       RestReponse class - Allows us to pass or send back response data from our Apex RESTful web service method  
     */  
     //Returns the RestRequest object for our Apex REST method.  
     RestRequest request = RestContext.request;  
     //Returns the RestResponse for our Apex REST method.  
     RestResponse response = RestContext.response;  
     //Retrieve the parameter sent in the URL  
     String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);  
     //query the account on the basis of id sent and return the record  
     Account acc= [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];  
     return acc;  
   } 
   @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    } 
}