public class f_any_controller {

    public String fname {get;set;}
    public String lname {get;set;}
    public String email {get;set;}
    public String uname {get;set;}
 public String logoURL{get;set;}

    public f_any_controller(ApexPages.StandardController controller) {
     logoURL='/servlet/servlet.FileDownload?file=';
    List< document > documentList=[select name from document where 
                                    Name='logo'];
   
    if(documentList.size()>0)
    {
      logoURL=logoURL+documentList[0].id;
    }
  

    }
 public PageReference registration()
 {
 
 return null;
 }
}