global with sharing class Train_Details_control {

    public Train_Details_control() {
    
    
    }
    public Train_Details_control(ApexPages.StandardController controller) {
    wrapperInfo=new List<WrapperInfo>();
     wrapperInfo1=new List<WrapperInfo1>();
    hrs=new List<selectOption>();
    for(integer i=0;i<24;i++)
    {
    if(i<10)
    {
    hrs.add(new selectOption('0'+String.valueOf(i),'0'+String.valueOf(i)));
    }
    else
    {
    hrs.add(new selectOption(String.valueOf(i),String.valueOf(i)));
    }
    }
    mns=new List<selectOption>();
    for(integer j=0;j<60;j++)
    {
    if(j<10)
    {
    mns.add(new selectOption('0'+String.valueOf(j),'0'+String.valueOf(j)));
    }
    else
    {
    mns.add(new selectOption(String.valueOf(j),String.valueOf(j)));
    }
    }
    
    schDay = new List<String>();
    schTDay = new List<String>();
    
    leftvalues.addAll(weekDays);
   
    tList=new Map<String,String>();
    tList.put('1','');
    tList.put('2','');
    }
    public List<string> schTDay {get; set;}
    public List<string> schDay {get; set;}
    public Integer noc {get; set;}
    public Train__c train { get; set; }
    public String cdate { get; set; }
    public Integer tENos { get; set; }
    public Integer tNos { get; set; }
    public String tText { get; set; }
    public String tEText { get; set; }
    public boolean ccAdd { get; set; }
    public boolean tEdit { get; set; }
    public boolean trI { get; set; }
    public boolean info { get; set; }
    public boolean tED { get; set; }
    public boolean alot { get; set; }
    public String type { get; set; }
    public String speed { get; set; }
    public String Tmins { get; set; }
    public String Thours { get; set; }
    public String Dmins { get; set; }
    public String Dhours { get; set; }
    public String Amins { get; set; }
    public String Ahours { get; set; }
    public String selectedVal { get; set; }
    
    public List<selectOption> hrs { get; set; }
    public List<selectOption> mns { get; set; }
    public String tTTime { get; set; }
    public Integer tDist { get; set; }
    public String tArrv { get; set; }
    public String tDep { get; set; }
    public String fromText { get; set; }
    public String toText { get; set; }
    public Integer tNo { get; set; }
    public String tName { get; set; }
    public String coachCount { get; set; }
    public Map<String,String> M { get; set; } 
    public Map<String,String> N { get; set; }  
    public Map<String,String> L { get; set; } 
    public Map<String,String> MM { get; set; } 
    public Map<String,String> NN { get; set; }  
    public Map<String,String> LL { get; set; } 
    public Map<String,String> DD { get; set; }              
    public List<String> coachCountList { get; set; }
    public List<String> coachCountList1 { get; set; }
    public Map<String,String> tList {get; set;}
    public List<WrapperInfo1> wrapperInfo1 { get; set; }
    public List<WrapperInfo> wrapperInfo { get; set; }
    public List<String> weekDays= new List<String>{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'};
    public List<String> displayFieldLst= new List<String>{'tName', 'tNo', 'from1', 'dep', 'to','arr','distKm','tt'}; 
    public list<String> labelFieldLst= new list<String>{'Name', 'No', 'From', 'Departure', 'To','Arrival','Distance(KM)','Travel Time'};
    Date[] names = new Date[0];
    Set<string> leftvalues = new Set<string>();
    Set<string> rightvalues = new Set<string>();  
       public Component.Apex.TabPanel getTabPanel() 
       {
      List<Train__c> infs=new List<Train__c>();
      wrapperInfo.clear();
      if(tText!=null && tNoS==0)
      {
      infs=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c from Train__c where name=:tText];
      }
      else if(tNoS!=null)
      {
      infs=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c from Train__c where Train_No__c=:tNoS];
      }
        for(Train__c inf:infs)
        {
        Map<String,Integer> tcD=new Map<String,Integer>();
    for(Train_Coach_Details__c tcDetails:[select Coach_Category__c from Train_Coach_Details__c where name=:inf.name])
    {Integer i=1;
    if(tcD.containsKey(tcDetails.Coach_Category__c))
    {
    Integer j=tcD.get(tcDetails.Coach_Category__c)+1;
    tcD.put(tcDetails.Coach_Category__c,j);
    }
    else
    {
    tcD.put(tcDetails.Coach_Category__c,i);
    }
    }
        wrapperInfo.add(new WrapperInfo(Integer.valueOf(inf.Train_No__c),inf.name,inf.From__c,inf.Departure__c,inf.To__c,inf.Arrival__c,Integer.valueOf(inf.Distance_KM__c),inf.Travel_Time__c,tcD));
        }
      
     System.debug('......wrapperInfo...................'+wrapperInfo);
        Component.Apex.TabPanel panel = new Component.Apex.TabPanel();
        panel.switchType = 'client';
        for(integer idx = 0; idx < names.size(); idx++) {
            Component.Apex.Tab tab = new Component.Apex.Tab();
            tab.id = 'tab'+string.valueof(idx);
            
            String lbl=String.valueOf(names[idx].day())+'-'+String.valueOf(names[idx].month()+'-'+String.valueOf(names[idx].year()));
            tab.label = lbl;
            Component.Apex.PageBlockTable pbTable = new Component.Apex.PageBlockTable(var='tr');
            pbTable.expressions.value = '{!wrapperInfo}';
            Component.Apex.Column column;  
            Component.Apex.OutputText outputText;  
            for(Integer index=0;index<displayFieldLst.size();index++)  
            {  
            column = new Component.Apex.Column(headerValue= '' + labelFieldLst.get(index) + '');  
            outputText = new Component.Apex.OutputText();  
            outputText.expressions.value = '{!tr.' + displayFieldLst.get(index) + '}';  
            column.childComponents.add(outputText);  
            pbTable.childComponents.add(column);  
            }  
             tab.childComponents.add(pbTable);
         
           /* Component.Apex.CommandButton command = new Component.Apex.CommandButton();
            command.value='Save';
            command.expressions.action='{!save}';
            tab.childComponents.add(command);
    
            Component.Apex.outputText f = new Component.Apex.outputText();
            f.value = 'Description';
            tab.childComponents.add(f);

            Component.Apex.InputText t = new Component.Apex.InputText();
            t.expressions.value ='{!c.status}' ;
            tab.childComponents.add(t);
            */
            panel.childComponents.add(tab);
        }
        return panel;
       }
    public List<SelectOption> getunschDayvalues()
    {
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(leftvalues);
        //tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }
    public List<SelectOption> getschDayvalues(){
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(rightvalues);
        //tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
    }
    Public PageReference selectclick(){
        schTDay.clear();
        for(String s : schDay){
            leftvalues.remove(s);
            rightvalues.add(s);
        }
        return null;
    }
    public PageReference unselectclick(){
        schDay.clear();
        for(String s : schTDay){
            rightvalues.remove(s);
            leftvalues.add(s);
        }
        return null;
    }   
    Public Pagereference delCoaches()
    {
    //string mapV = Apexpages.currentPage().getParameters().get('mapV');
    string mapV = Apexpages.currentPage().getParameters().get('selectedI');
    System.debug('.......mapV..............'+mapV);
    System.debug('....mm...mapV.....load.........'+MM);
    System.debug('....nn...mapV.....load.........'+NN);
    System.debug('....ll...mapV.....load.........'+LL);
    Train_Coach_Details__c tcd=[select id from Train_Coach_Details__c where id=:selectedVal];
   delete tcd;
   // MM.remove(mapV);
   // NN.remove(mapV);
   // LL.remove(mapV);
    return null;
    }
     public Integer inc=0;
     Public Pagereference addCoaches()
    {
   inc++;
   String incS=String.valueOf(inc); 
        ccAdd=true;
   coachCountList1.add(incS);
    MM.put(incS,'');
    NN.put(incS,'');
    LL.put(incS,'');
    DD.put(incS,'Delete');
    noc++;
    return null;
    }   
       
    Public Pagereference Save()
    {
    Train_Coach_Details__c tcd =new Train_Coach_Details__c();
    
    for(String v:MM.keySet())
    {
    if(v.length()<15)
    {
    
    tcd.name=tEText;
    tcd.Coach_Name__c=MM.get(v);
    tcd.Coach_Category__c=NN.get(v);
    tcd.Coache_Seats__c=Integer.valueOf(LL.get(v));
   
    }
    else
    {
    tcd=[select name,Coach_Category__c,Coache_Seats__c,Coach_Name__c from Train_Coach_Details__c where id=:v];
    
    tcd.Coach_Name__c=MM.get(v);
    tcd.Coach_Category__c=NN.get(v);
    tcd.Coache_Seats__c=Integer.valueOf(LL.get(v));
    }
     upsert tcd;
    }
   
    
    
    upsert train;
    
    return null;
    }
      
     
     
      
     
      public PageReference GetEdtInfo() {
      noc=0;
      tED=true;
      train=new Train__c();
     wrapperInfo1.clear();
      train=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c from Train__c where name=:tEText limit 1];
      MM=new Map<String,String>();
      NN=new Map<String,String>();
      LL=new Map<String,String>();
      DD=new Map<String,String>();
      coachCountList1=new List<String>();
      
      for(Train_Coach_Details__c tc:[select id from Train_Coach_Details__c where name=:tEText])
      {
      //String s=String.valueOf(tc.id);
      coachCountList1.add(tc.id);
      noc++;
      }
     
      Integer i=0;
      for(Train_Coach_Details__c tcd:[select id,name,Coach_Category__c,Coache_Seats__c,Coach_Name__c from Train_Coach_Details__c where name=:tEText])
      {
      i++;
      if(tcd.Coach_Name__c!=null)
      {
       MM.put(tcd.id,tcd.Coach_Name__c);
      NN.put(tcd.id,tcd.Coach_Category__c);
      LL.put(tcd.id,String.valueOf(tcd.Coache_Seats__c));
      DD.put(tcd.id,'Delete');
       wrapperInfo1.add(new  wrapperInfo1(tcd.Coach_Name__c,tcd.Coach_Category__c,Integer.valueOf(tcd.Coache_Seats__c)));
     }
      }
     
      return null;
      }
      public PageReference GetTrsInfo() {
       names.clear();
      tList=new Map<String,String>();
     
      trI=true;
     Date today=System.today();
     
     
     Date newD;
     Integer numberOfDays = Date.daysInMonth(today.year(), today.month());
     Integer d=today.day();
     Integer m=today.month();
     Integer y=today.year();
     
     if(d>7 && numberOfDays>d)
     {
     newD=Date.newInstance(d-7,m,y);
     }
     if(d<=7)
     {
     
     Integer numberOfDays1 = Date.daysInMonth(today.year(), (today.month())-1);
     Integer b=numberOfDays1+(d-7);
     
     newD=Date.newInstance(y,(today.month())-1,b);
     }
    
   System.debug('.......newD............'+newD);
     for(Integer x=1,a=newD.day();x<=8;x++)
     {
     Integer v= Date.daysInMonth(newD.year(), newD.month());
     
     if(a<=v)
     {
     Date dd=date.newInstance(newD.year(),newD.month(),a);
     names.add(dd);
     
     }
     else
     {
     Integer z=a-Date.daysInMonth(newD.year(), newD.month());
     Date dd=date.newInstance(newD.year(),(newD.month()+1),z);
     names.add(dd);
      
     }
     a++;
     }
   
      return null;
      }  
      public PageReference GetInfoSec() {
      info=true;
      alot=false;
      tEdit=false;
      return null;
      }  
      public PageReference GetAlotSec() {
      alot=true;
      info=false;
      trI=false;
      tEdit=false;
      return null;
      } 
      public PageReference GetEditSec() {
      info=false;
      alot=false;
      tEdit=true;
      return null;
      } 
      public PageReference GetCoachCnt() {
      System.debug('.....chs....chs....'+coachCount);
      M=new Map<String,String>();
      N=new Map<String,String>();
      L=new Map<String,String>();
      coachCountList=new List<String>();
      if(coachCount!=null)
      {
      for(Integer i=Integer.valueOf(coachCount);i>0;i--)
      {
      String s=String.valueOf(i);
      coachCountList.add(s);
      M.put(s,'');
      N.put(s,'');
      L.put(s,'');
      }
      } 
      return null;
      }
      public PageReference resetDetails() {
      tName='';
      tNo=0;
      fromText='';
      toText='';
      Dhours='';
      Dmins='';
      Ahours='';
      Amins='';
      Thours='';
      Tmins='';
      tDist=0;
      coachCount='';
      coachCountList.clear();
      return null;
      }
      public PageReference saveDetails() {
      
      String Coaches=',';
      for(String c:M.keySet())
      {
      Coaches+=M.get(c)+',';
      
      }
      Coaches=Coaches.substring(1,(Coaches.length()-1));
      
      String Category=',';
      for(String c:N.keySet())
      {
      Category+=N.get(c)+',';
      
      }
      Category=Category.substring(1,(Category.length()-1));
      
      String Seats=',';
      for(String c:L.keySet())
      {
      Seats+=L.get(c)+',';
      
      }
      Seats=Seats.substring(1,(Seats.length()-1));
      //Train timings
      tDep=Dhours+':'+Dmins;
      tArrv=Ahours+':'+Amins;
      tTTime=Thours+':'+Tmins;
      //Train Schedule
      String schd=',';
      for(String s:rightvalues )
      {
      schd+=s+',';
      }
      schd=schd.substring(1,(schd.length()-1));
      Train__c td=new  Train__c();
      td.name=tName;
      td.Train_No__c=tNo;
      td.From__c=fromText;
      td.To__c=toText;
      td.Departure__c=tDep;
      td.Arrival__c=tArrv;
      td.Distance_KM__c=tDist;
      td.Travel_Time__c=tTTime;
      td.Schedule__c=schd;
      
      insert td;
     
      for(String t:M.keySet())
      {
       Train_Coach_Details__c tc=new Train_Coach_Details__c();
      tc.name=tName;
      tc.Coach_Name__c=M.get(t);
      tc.Coach_Category__c=N.get(t);
      tc.Coache_Seats__c=Integer.ValueOf(L.get(t));
      insert tc;
      }
       PageReference entryPage = new PageReference('https://c.ap2.visual.force.com/apex/test1');
    entryPage.setRedirect(true);
      return entryPage;
      } 
      
       @RemoteAction
    global static SObject[] findSObjects(string obj, string qry, string addFields, string profilename) 
    {
        /* More than one field can be passed in the addFields parameter
           Split it into an array for later use */
        List<String> fieldList=new List<String>();
        if (addFields != '')  
        fieldList = addFields.split(',');
        
        /* Check whether the object passed is valid */
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sot = gd.get(obj);
        if (sot == null) 
        {
            return null;
        }
        
        /* Creating the filter text */
        String filter = ' like \'%' + String.escapeSingleQuotes(qry) + '%\'';
        
        /* Begin building the dynamic soql query */
        String soql = 'SELECT Name';
        
        /* If any additional field was passed, adding it to the soql */
        if (fieldList.size()>0) 
        {
            for (String s : fieldList) 
            {
                soql += ', ' + s;
            }
        }
        
        /* Adding the object and filter by name to the soql */
        soql += ' from ' + obj + ' where name' + filter;
        
        if(profilename!='')
        {
            //profile name and the System Administrator are allowed
            soql += ' and Profile.Name like \'%' + String.escapeSingleQuotes(profilename) + '%\'';
            system.debug('Profile:'+profilename+' and SOQL:'+soql);
        }
        
        /* Adding the filter for additional fields to the soql */
        if (fieldList != null) 
        {
            for (String s : fieldList) 
            {
                soql += ' or ' + s + filter;
            }
        }
        
        soql += ' order by Name limit 20';
        
        system.debug('Qry: '+soql);
        
        List<sObject> L = new List<sObject>();
        try 
        {
            L = Database.query(soql);
        }
        catch (QueryException e) 
        {
            system.debug('Query Exception:'+e.getMessage());
            return null;
        }
        return L;
   }
   class WrapperInfo
        {
        public Integer tNo { get; set; }
        public Integer distKm { get; set; }
        public String tName { get; set; }
        public String from1 { get; set; }
        public String dep { get; set; }
        public String to{ get; set; }
        public String arr { get; set; }
        public String tt { get; set; }
        public Map<String,Integer> tcD { get; set; }
        
        public WrapperInfo(Integer tNo,String tName,String from1,String dep,String to,String arr,Integer distKm,String tt,Map<String,Integer> tcD)
        {
        this.tNo=tNo;
        this.tName=tName;
        this.from1=from1;
        this.dep=dep;
        this.to=to;
        this.arr=arr;
        this.distKm=distKm;
        this.tt=tt;
        this.tcD=tcD;
        }
        }   
    class WrapperInfo1
        {
        public String cName { get; set; }
        public String category { get; set; }
        public Integer seats { get; set; }
        
        
        public WrapperInfo1(String cName,String category,Integer seats)
        {
        this.cName=cName;
        this.category=category;
        this.seats=seats;
        }
        }   
}