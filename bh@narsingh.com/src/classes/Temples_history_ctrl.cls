public class Temples_history_ctrl {

ApexPages.StandardController sController;  
public List<selectOption> tmpList{get;set;}
public Temple__c templeObj;
    public Temples_history_ctrl(ApexPages.StandardController controller) {
    sController = controller;  
templeObj=(Temple__c)controller.getRecord();
tmpList=new List<SelectOption>();
    tmpList.add(new SelectOption('None','None'));
    tmplImgUrl=new List<String>();
    tmplDesc=new List<String>();
    newAttachments=new List<Attachment>{new Attachment()};
    
    }
    
    public PageReference templeList() {
    tmpList.clear();
    tmpList.add(new SelectOption('None','None'));
    Set<String> nms=new Set<String>();
    for(Temple__c t:[select id,name from Temple__c where State__c=:state and City__c=:city])
    {
    nms.add(t.name);
    
    }
    for(String s:nms)
    {
    tmpList.add(new SelectOption(s,s));
    }
    return null;
    
    }
    public List<String> tmplImgUrl{get;set;}
    public List<String> tmplDesc{get;set;}
     public PageReference templeInfo() {
     String fileId;
     tmplImgUrl.clear();
     Set<id> tmplIds=new Set<Id>();
     for(Temple__c t:[select id from Temple__c where name=:tmpName])
     {
     tmplids.add(t.id);
     }
     /* List<Attachment> attachedFiles = [select id,description from Attachment where parentId IN:tmplIds];
      if( attachedFiles != null && attachedFiles.size() > 0 ) {
            fileId = attachedFiles[0].Id;
         tmpDescp  =attachedFiles[0].description;
        }
        */
        for(Attachment at:[select id,description from Attachment where parentId IN:tmplIds])
        {
        //tmplImgUrl.add('url(https://c.ap2.content.force.com/servlet/servlet.FileDownload?file='+at.id+')');
        tmplImgUrl.add('https://c.ap2.content.force.com/servlet/servlet.FileDownload?file='+at.id);
        tmplDesc.add(at.description);
        }
        //tmpImageUrl='url(https://c.ap2.content.force.com/servlet/servlet.FileDownload?file='+fileId+')';
        //System.debug('..........tmpImageUrl......................'+tmpImageUrl);
     return null;
     }
   
    public PageReference saveRec() {
    insert templeObj;
    return null;
    }
    public PageReference editRec() {
    
    return null;
    }
    public PageReference upload() {
    insert templeObj;
    System.debug('.......id................'+templeObj.id);
       attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId = templeObj.id; // the record the file is attached to
    //attachment.IsPrivate = true;

    try {
      insert attachment;
      
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    
     
        return null;  
  
    }
    public List<Attachment> newAttachments {get; set;}
    public Integer NUM_ATTACHMENTS_TO_ADD=1;
     public PageReference attachMore() {
      NUM_ATTACHMENTS_TO_ADD++;
      newAttachments.add(new Attachment());
        
     return null;
     }
    public PageReference attachDelete() {
    Integer j=newAttachments.size();
    newAttachments.remove(j-1);
      NUM_ATTACHMENTS_TO_ADD=newAttachments.size();
      
        
     return null;
     }
    public void saveAttach()
    {
    insert templeObj;
     
        List<Attachment> toInsert=new List<Attachment>();
        for (Attachment newAtt : newAttachments)
        {
            if (newAtt.Body!=null)
            {
                newAtt.OwnerId = UserInfo.getUserId();
                newAtt.parentId=templeObj.id;
                toInsert.add(newAtt);
            }
        }
        insert toInsert;
        newAttachments.clear();
        newAttachments.add(new Attachment());
        
        // null the list of existing attachments - this will be rebuilt when the page is refreshed
       
    }    

     public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }


    public String tmpDescp { get; set; }
    public String tmpName { get; set; }
    
    public String view { get; set; }

    public String Note { get; set; }
    
    public String tmpImageUrl { get; set; }

    public String city { get; set; }

    public String state { get; set; }
    public Temples_history_ctrl()
    {
    Note='Type Description here';
    
    }
    
}