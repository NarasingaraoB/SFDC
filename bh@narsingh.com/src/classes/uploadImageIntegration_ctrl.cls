public class uploadImageIntegration_ctrl {

    public PageReference GETImage() {
    HttpRequest req = new HttpRequest();
     req.setEndpoint(urlImage);
     req.setMethod('GET');
     
     // Specify the required user name and password to access the endpoint
     // As well as the header and header information
 
     String username = 'myname';
     String password = 'mypwd';
  
     Blob headerValue = Blob.valueOf(username + ':' + password);
     String authorizationHeader = 'BASIC ' +
     EncodingUtil.base64Encode(headerValue);
     req.setHeader('Authorization', authorizationHeader);
   
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
  
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
     blob image = res.getBodyAsBlob();
    
Attachment n = new Attachment();

n.ParentId = '00128000003ipMD';
n.Name = 'IntegrationImage.jpg';
n.Body = image;

n.contentType = 'image/jpeg';
insert n;

//Not that by simply inserting into ContentVersion that the actual ContentDocument entry will be created for you
ContentVersion cv = new ContentVersion();
cv.VersionData = image;  //This is our blob
cv.title = 'MyImageName';
cv.Description = 'MyImageDescription';
//cv.FirstPublishLocationId = '058E00000000RIg';  //This is the library
cv.TagCsv = 'Tag1';
cv.PathOnClient = 'http://www.myDomain.com/myImage.jpg';
cv.ReasonForChange = ''; // If we update an image then we may have to set this
//cv.ContentDocumentID = ''; //If we are inserting a revision to a document then we need this.  May have to query for it first
//When testing this remember that it takes a few seconds for a document to show up in the library
insert cv;
        return null;
    }


    public String urlImage { get; set; }
}