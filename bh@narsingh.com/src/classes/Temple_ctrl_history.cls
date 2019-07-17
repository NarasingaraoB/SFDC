public class Temple_ctrl_history {

    public PageReference deleteAttach() {
        return null;
    }


    public String viewData { get; set; }
    public List<Attachment> att {get;set;}
     
    public PageReference GetDetails() {
    viewData='block';
    att=new List<Attachment>();
    for(Temple__c t:[select id,name,State__c,City__c,(SELECT Id, Name,Description  FROM Attachments) from Temple__c where name=:tName])
    {
    this.stateEdit=t.State__c;
    this.cityEdit=t.city__c;
    att=t.Attachments;
    }
    
        return null;
    }


    public String cityEdit { get; set; }

    public String stateEdit { get; set; }

    public String tName { get; set; }

    
    public String done { get; set; }

    public boolean attachBox { get; set; }
    
   

   

    public PageReference GetAttachs() {
    newAttachments.clear();
    for(Integer i=0;i<noOfAttach;i++)
    {
    newAttachments.add(new Attachment());
    }
    done='block';
        return null;
    }


    public Integer noOfAttach { get; set; }

    public Integer NUM_ATTACHMENTS_TO_ADD=1;
    
    public PageReference saveAttach() {
    system.debug('........name...............'+tmpName);
    system.debug('..........state.............'+state);
    system.debug('.........city..............'+city);
    Temple__c tmp=new Temple__c();
    tmp.name=tmpName;
    tmp.State__c=state;
    tmp.City__c=city;
    insert tmp;
    List<Attachment> toInsert=new List<Attachment>();
        for (Attachment newAtt : newAttachments)
        {
            if (newAtt.Body!=null)
            {
                newAtt.OwnerId = UserInfo.getUserId();
                newAtt.parentId=[select id from Temple__c where name=:tmpName limit 1].id;
                toInsert.add(newAtt);
            }
        }
        insert toInsert;
        newAttachments.clear();
        newAttachments.add(new Attachment());
        return null;
    }


    public PageReference attachDelete() {
    String attId='';
    System.debug('.........tName......'+tName+'........attId................'+attId);
        return null;
    }


   


    public List<Attachment> newAttachments {get; set;}

   

    public Temple_ctrl_history()
    {
     newAttachments=new List<Attachment>();
     done='none';
     viewData='none';
    }
    
    

    public String city { get; set; }

    public String state { get; set; }

    public String tmpName { get; set; }
}