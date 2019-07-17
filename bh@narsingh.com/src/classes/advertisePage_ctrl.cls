public class advertisePage_ctrl {

    public PageReference StoreAndSet() {
    System.debug('......pgName.................'+pgName);
    System.debug('......advPos................'+advPos);
    System.debug('.......advBlob................'+advBlob);
    System.debug('.......advName................'+advName);
        return null;
    }

    public String advPos { get; set; }

    public Blob advBlob { get; set; }

    public String advName { get; set; }

    public String pgName { get; set; }
    
    public advertisePage_ctrl()
    {
    advCountOnPage=new List<SelectOption>();
    }

    public Set<String> pos=new Set<String>();
    public PageReference GetCountOnPage() {
    pos.clear();
    if(pgName!='None')
    {
    for(advertises__c adv:[select advPosition__c from advertises__c where PageName__c=:pgName order by advPosition__c])
    {
    pos.add(adv.advPosition__c);
    }
    }
        return null;
    }


    public List<SelectOption> advCountOnPage { get; set; }

    public List<SelectOption> getGetVFPages() {
    List<SelectOption> options=new List<SelectOption>();
    options.add(new SelectOption('None','None'));
    Set<String> pgs=new Set<String>();
    for(advertises__c adv:[select PageName__c from advertises__c])
    {
    pgs.add(adv.PageName__c);
    
    }
    for(String s:pgs)
    {
    options.add(new SelectOption(s,s));
    }
        return options;
    }
    
    public List<SelectOption> getGetAdvPos() {
    List<SelectOption> options=new List<SelectOption>();
    options.add(new SelectOption('None','None'));
    for(String s:pos)
    {
    options.add(new SelectOption(s,s));
    }
        return options;
    }

}