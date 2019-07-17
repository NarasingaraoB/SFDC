public class train_view_ctrl {

    
    public String arrTime { get; set; }

    public String depTime { get; set; }

    public List<SelectOption> arrTs { get; set; }

    public List<SelectOption> depTs { get; set; }

    public PageReference GetTimings() {
    depTs.clear();
    arrTs.clear();
    depTs.add(new SelectOption('AnyTime','AnyTime'));
    arrTs.add(new SelectOption('AnyTime','AnyTime'));
    for(Train__c t:[select Arrival__c,Departure__c from Train__c where From__c=:srcText and To__c=:destText])
    {
    depTs.add(new SelectOption(t.Departure__c,t.Departure__c));
    arrTs.add(new SelectOption(t.Arrival__c,t.Arrival__c));
    }
        return null;
    }


   

    public String trainName { get; set; }
    public String trainNo { get; set; }
    public String trainSrc { get; set; }
    public String selectedValue { get; set; }
    public Map<String,String> categoryMap {get;set;}
    public List<String> runsOn { get; set; }

    public PageReference GetsheduleTrain() {
   
    runsOn.clear();
    wrapperTrainInfo.clear();
    if(selectedValue!='')
    {
     sdInfoView='none';
    tnInfoView='block';
    String[] sts=selectedValue.split('/');
    
    String sTNo=sts[0];
    String sTName=sts[1];
    String sTSource=sts[2];
    String category=sts[3];
    TrsInfo(sTName,sTNo);
    if(category=='0')
    {
    
    }
    }
    else
    {
     sdInfoView='block';
    tnInfoView='none';
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select radio button on train'));
    }
        return null;
    }


    public String styleWidth1 { get; set; }

    public String styleWidth { get; set; }

    public Map<Integer,String> tcd {get;set;}
    public Map<Integer,String> tcd1 {get;set;}
    public boolean validateDetails()
    {
    boolean valid=false;
     if(srcText=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose Source'));
    }
    else if(destText=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose Destination'));
    }
    else if(dat=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose Journey Date'));
    }
    else
    {
    valid=true;
    }
    return valid;
    }
    public PageReference BySrcDest() {
    if(validateDetails())
    {
    selectedValue='';
    System.debug('...........selClass..................'+selClass);
    Set<Decimal> trainNos=new Set<Decimal>();
    Set<Decimal> trainWithIds=new Set<Decimal>();
    for(Train__c t:[select id,name,Train_No__c from Train__c where From__c=:srcText and To__c=:destText])
    {
    
    trainWithIds.add(t.Train_No__c);
    }
    System.debug('............trainWithIds......................'+trainWithIds);
    if(selClass=='ALL')
    {
    trainNos.clear();
    for(Train__c t:[select id,name,Train_No__c from Train__c where From__c=:srcText and To__c=:destText])
    {
    trainNos.add(t.Train_No__c);
    }
    styleWidth='100%';
    styleWidth1='100%';
    }
    else
    {
    trainNos.clear();
    for(Train_Coach_Details__c tcd:[select Train_No__c from Train_Coach_Details__c where Train_No__c IN:trainWithIds and Coach_Category__c=:selClass])
    {
    trainNos.add(tcd.Train_No__c);
    }
    styleWidth='100px';
    styleWidth1='87%';
    }
    
    sdInfoView='block';
    tnInfoView='none';
    wrapperTrainsInfo.clear();
     Map<Integer,String> tcD;
     List<Train__c> trs=new List<Train__c>();
     if(depTime=='AnyTime' && arrTime=='AnyTime')
     {
     trs=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Schedule__c from Train__c where Train_No__c IN:trainNos and From__c=:srcText and To__c=:destText];
     }
     else if(depTime!='AnyTime' && arrTime=='AnyTime')
     {
     trs=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Schedule__c from Train__c where Train_No__c IN:trainNos and From__c=:srcText and To__c=:destText and Departure__c=:depTime];
     }
     else if(depTime=='AnyTime' && arrTime!='AnyTime')
     {
     trs=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Schedule__c from Train__c where Train_No__c IN:trainNos and From__c=:srcText and To__c=:destText and Arrival__c=:arrTime];
     }
     else
     {
     trs=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Schedule__c from Train__c where Train_No__c IN:trainNos and From__c=:srcText and To__c=:destText and Departure__c=:depTime and Arrival__c=:arrTime];
     }
   // for(Train__c INF:[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Schedule__c from Train__c where Train_No__c IN:trainNos and From__c=:srcText and To__c=:destText])
    for(Train__c INF:trs)
    {
    tcD=new Map<Integer,String>();
    tcD.put(1,'N');tcD.put(2,'N');tcD.put(3,'N');tcD.put(4,'N');tcD.put(5,'N');tcD.put(6,'N');tcD.put(7,'N');
    String sch=inf.Schedule__c;
    String[] schs = sch.split(',');
    if(schs.size()>0 || schs!=null){
    for(Integer i=0;i<schs.size();i++)
    {
    if(schs[i]=='Monday')
    {
    tcD.put(1,'Y');
    }else if(schs[i]=='Tuesday')
    {tcD.put(2,'Y');
    }else if(schs[i]=='Wednesday')
    {tcD.put(3,'Y');
    }else if(schs[i]=='Thursday')
    {tcD.put(4,'Y');
    }else if(schs[i]=='Friday')
    {tcD.put(5,'Y');
    }else if(schs[i]=='Staurday')
    {tcD.put(6,'Y');
    }else if(schs[i]=='Sunday')
    {tcD.put(7,'Y');
    }
    }
    }
    tcD1=new Map<Integer,String>();
    tcD1.put(1,'0');tcD1.put(2,'0');tcD1.put(3,'0');tcD1.put(4,'0');tcD1.put(5,'0');tcD1.put(6,'0');

    for(Train_Coach_Details__c tcDet:[select Coach_Category__c from Train_Coach_Details__c where name=:inf.name])
    {
   
    if(tcDet.Coach_Category__c=='1AC')
    {
    tcD1.put(1,(tcDet.Coach_Category__c));
    }
    else if(tcDet.Coach_Category__c=='2AC')
    {
    tcD1.put(2,(tcDet.Coach_Category__c));
    }
    else if(tcDet.Coach_Category__c=='3AC')
    {
    tcD1.put(3,(tcDet.Coach_Category__c));
    }
    else if(tcDet.Coach_Category__c=='CC')
    {
    tcD1.put(4,(tcDet.Coach_Category__c));
    }
    else if(tcDet.Coach_Category__c=='SL')
    {
    tcD1.put(5,(tcDet.Coach_Category__c));
    }
    else if(tcDet.Coach_Category__c=='2S')
    {
    tcD1.put(6,(tcDet.Coach_Category__c));
    }
    }
     wrapperTrainsInfo.add(new WrapperTrainsInfo(Integer.valueOf(inf.Train_No__c),inf.name,inf.From__c,inf.Departure__c,inf.To__c,inf.Arrival__c,Integer.valueOf(inf.Distance_KM__c),inf.Travel_Time__c,tcD,tcD1));
    
    }
    }
        return null;
    }

    public void TrsInfo(String tName,String tNo)
    {
    runsOn.clear();
    String schd='';
     List<TrainByStation__c> tbysInfo=[select Train_Name__c,Train_No__c,Station_Code__c,Station_Name__c,Route_No__c,Arrival__c,Departure__c,Halt_Time__c,Distance_Km__c,Day_Count__c,Schedule__c from TrainByStation__c where Train_Name__c=:tName and Train_No__c=:Integer.valueOf(tNo) order by Distance_Km__c];
       if(tbysInfo!=null && tbysInfo.size()>0)
       {
       for(TrainByStation__c tbys:tbysInfo)
       {
       trainName=tbys.Train_Name__c;
       trainNo=String.valueOf(tbys.Train_No__c);
       if(tbys.Arrival__c=='00:00')
       {
       trainSrc=tbys.Station_Name__c;
       }
       schd=tbys.Schedule__c;
       wrapperTrainInfo.add(new WrapperTrainInfo(tbys.Station_Code__c,tbys.Station_Name__c,tbys.Route_No__c,tbys.Arrival__c,tbys.Departure__c,tbys.Halt_Time__c,Integer.valueOf(tbys.Distance_KM__c),Integer.valueOf(tbys.Day_Count__c)));
       }
       List<String> sch=schd.split(',');
       runsOn.addAll(sch);
       }
    }
    public PageReference GetTrsInfo() {
    tnInfoView='block';
    sdInfoView='none';
    wrapperTrainInfo.clear();
    if(tNoS!='None')
    {
    TrsInfo(tText,tNos);
   
    }
        return null;
    }


    public String tnInfoView { get; set; }

    public String sdInfoView { get; set; }

    public List<WrapperTrainInfo> wrapperTrainInfo { get; set; }

   
   

    public String tnDisplay { get; set; }

    public String sdDisplay { get; set; }

    public List<WrapperTrainsInfo> wrapperTrainsInfo { get; set; }
    public List<selectOption> TrNos { get; set; }

    public String tNoS { get; set; }

    public PageReference chooseTrainNos() {
    sdDisplay='none';
    tnDisplay='block';
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

    public String destText { get; set; }

    public String srcText { get; set; }
    
    public train_view_ctrl()
    {
   
    TrNos=new List<SelectOption>();
    TrNos.add(new SelectOption('None','None'));
    wrapperTrainsInfo=new List<WrapperTrainsInfo>();
    wrapperTrainInfo=new List<WrapperTrainInfo>();
    categoryMap=new Map<String,String>();
    categoryMap.put('1','1AC');
     categoryMap.put('2','2AC');
     categoryMap.put('3','3AC');
     categoryMap.put('4','CC');
     categoryMap.put('5','SL');
     categoryMap.put('6','2S');
     runsOn=new List<String>();
     depTs=new List<SelectOption>();
     arrTs=new List<SelectOption>();
    String know=Apexpages.currentPage().getParameters().get('know');
    String diplay=Apexpages.currentPage().getParameters().get('display');
    String tName=Apexpages.currentPage().getParameters().get('tName');
    String tNo=Apexpages.currentPage().getParameters().get('tNo');
    String sText=Apexpages.currentPage().getParameters().get('srcText');
    String dText=Apexpages.currentPage().getParameters().get('destText');
    String sClass=Apexpages.currentPage().getParameters().get('selClass');
    String d=Apexpages.currentPage().getParameters().get('dat');
    
    System.debug('.........know.......................'+know);
    if(know!=null)
    {
    
    if(know=='1')
    {
    knw=know;
    sdDisplay='block';
    tnDisplay='none';
    srcText=sText;
    destText=dText;
    selClass=sClass;
    dat=d;
    depTs.clear();
    arrTs.clear();
    depTs.add(new SelectOption('AnyTime','AnyTime'));
    arrTs.add(new SelectOption('AnyTime','AnyTime'));
    depTime='AnyTime';
    arrTime='AnyTime';
    BySrcDest();
    
    System.debug('.........know.......................'+know);
    }
    else if(know=='2')
    {
    knw=know;
    tnDisplay='block';
    sdDisplay='none';
     tnInfoView='block';
     this.tText=tName;
    chooseTrainNos();
    tNoS=tNo;
    GetTrsInfo();
    }
    
    
    }
    else
    {
    sdDisplay='none';
     tnDisplay='none';
      tnInfoView='none';
    sdInfoView='none';
    }
     
     
     
    
     
     
     
    }

    public PageReference knowsSDTN() {
    sdInfoView='none';
    tnInfoView='none';
     if(knw=='1')
    {
    sdDisplay='block';
     tnDisplay='none';
     
    }
     if(knw=='2')
    {
    sdDisplay='none';
    tnDisplay='block';
    }
        return null;
    }


    public String knw { get; set; }
    
    class WrapperTrainsInfo
        {
        public Integer tNo { get; set; }
        public Integer distKm { get; set; }
        public String tName { get; set; }
        public String from1 { get; set; }
        public String dep { get; set; }
        public String to{ get; set; }
        public String arr { get; set; }
        public String tt { get; set; }
        public Map<Integer,String> tcD { get; set; }
        public Map<Integer,String> tcD1 { get; set; }
        public WrapperTrainsInfo(Integer tNo,String tName,String from1,String dep,String to,String arr,Integer distKm,String tt,Map<Integer,String> tcD,Map<Integer,String> tcD1)
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
        this.tcD1=tcD1;
        }
        } 
         class WrapperTrainInfo
        {
        public String stC { get; set; }
        public Integer distKm { get; set; }
        public String stName { get; set; }
        public String rtNo { get; set; }
        public String arr { get; set; }
        public String dep{ get; set; }
        public String hat { get; set; }
        public Integer dCnt { get; set; }
        
        
        public WrapperTrainInfo(String stC,String stName,String rtNo,String arr,String dep,String hat,Integer distKm,Integer dCnt)
        {
        this.stC=stC;
        this.stName=stName;
        this.rtNo=rtNo;
        this.arr=arr;
        this.dep=dep;
        this.hat=hat;
        this.distKm=distKm;
        this.dCnt=dCnt;
        
        }
        }   
}