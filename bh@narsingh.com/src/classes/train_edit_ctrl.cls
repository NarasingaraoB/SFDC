public class train_edit_ctrl {
    public Map<String,String> chooseMap=new Map<String,String>();
    public Set<String> stations=new Set<String>();
    public Map<String,Set<Id>> fromstationIds=new Map<String,Set<Id>>();
    public void updateByDelete(Map<String,String> frmSt,Set<Id> trIds)
    {
    
    Set<String> chooseVal=new Set<String>();
    Set<Id> delTbysIds=new Set<Id>();
    Set<Id> delTrIds=new Set<Id>();
    chooseVal.addAll(chooseValues);
    for(String key:frmSt.keySet())
    {
    if(!chooseVal.contains(key))
    {
    delTbysIds.add(frmSt.get(key));
    for(Train__c t:[select id from Train__c where From__c=:key or To__c=:key])
    {
    delTrIds.add(t.id);
    }
    }
    }
    for(TrainByStation__c tbys:[select id from TrainByStation__c where id IN:delTbysIds])
    {
    delete tbys;
    }
    System.debug('.....delTrIds...............'+delTrIds);
    for(Train__c tr:[select id from Train__c where id IN:delTrIds])
    {
    delete tr;
    }
    }
    public PageReference updateDetails() {
    System.debug('............chooseValues..........'+chooseValues);
    Set<id> trIds=new Set<id>();
    Map<String,String> frmSt=new Map<String,String>();
    for(Train__c tr:[select id from Train__c])
    {
    trIds.add(tr.id);
    }
    for(TrainByStation__c tbys:[select id,Station_Name__c from TrainByStation__c where Train_Name__c=:trName and Train_No__c=:Integer.valueOf(trNo)])
    {
    frmSt.put(tbys.Station_Name__c,tbys.id);
    }
    updateByDelete(frmSt,trIds);
    Set<String> temp=new Set<String>();
    temp.addAll(chooseValues);
    List<String> chValues=new List<String>();
    chValues.addAll(chooseValues);
    Set<id> updateTbysIds=new Set<id>();
    Set<String> insertTbysNames=new Set<String>();
    List<Train__c> trains=new List<Train__c>();
    for(Integer i=0;i<chooseValues.size();i++)
    {
    temp.remove(chooseValues.get(i));
      List<String> toList=new List<String>();
      System.debug('.........fromstationIds............................'+fromstationIds);
    if(fromstationIds.containsKey(chooseValues[i]))
    {
    updateTbysIds.add(frmSt.get(chooseValues[i]));
    //TrainByStation(chooseValues[i],'update');
    updateExisting(fromstationIds.get(chooseValues[i]));
    }
    else
    {
    for(Integer k=0;k<chValues.size();k++)
    {
    if(chValues[k]==chooseValues[i])
    {
    System.debug('......chooseValues......'+chooseValues[i]+'................chValues.....'+chValues[k]);
    break;
    }
    else
    {
    Integer size=chooseValues.size();
    if(chooseValues[i]!=chooseValues[size-1])
    {
    trains.add(saveEntryDetails(chValues[k],chooseValues[i]));
    System.debug('..else....chooseValues......'+chooseValues[i]+'................chValues.....'+chValues[k]);
    }
    }
    }
    for(String tList:temp)
    {
    toList.add(tList);
    
    //TrainByStation(chooseValues[i],'insert');
    trains.add(saveEntryDetails(chooseValues[i],tList));
    }
    if(chooseValues[i]!=destSet)
    {
    insertTbysNames.add(chooseValues[i]);
    }
    }
    System.debug('.......from....'+chooseValues[i]+'...................................'+toList);
    }
    updateTBys(updateTbysIds);
    insertTBys(insertTbysNames);
    insert trains;
    Set<Id> tcdIds =new Set<Id>();
    for(Train_Coach_Details__c tcd:[select id from Train_Coach_Details__c where name=:trName and Train_No__c=:Integer.valueOf(trNo)])
    {
    tcdIds.add(tcd.id);
    }
    updateTcd(tcdIds);
    insertTcd();
    PageReference home =new PageReference('https://c.ap2.visual.force.com/apex/IndianRailway');
        return home;
    }
    public void updateTcd(set<id> tcdIds)
    {
    for(Train_Coach_Details__c tcd:[select id,Coach_Name__c,Coach_Category__c,Coache_Seats__c from Train_Coach_Details__c where id IN:tcdIds])
    {
    if(tcd.id!=null && M.containsKey(tcd.id))
    {
    tcd.Coach_Name__c=M.get(tcd.id);
    tcd.Coach_Category__c=N.get(tcd.id);
    tcd.Coache_Seats__c=Integer.valueOf(L.get(tcd.id));
    update tcd;
    }
    else if(tcd.id!=null)
    {
    delete tcd;
    }
    }
    }
    public void insertTcd()
    {
    List<Train_Coach_Details__c> tcds=new List<Train_Coach_Details__c>();
    for(String cList:coachCountList)
    {
    if(cList.length()<15)
    {
    Train_Coach_Details__c tcd=new Train_Coach_Details__c();
    tcd.name=trName;
    tcd.Train_No__c=Integer.valueOf(trNo);
    tcd.Coach_Name__c=M.get(cList);
    tcd.Coach_Category__c=N.get(cList);
    tcd.Coache_Seats__c=Integer.valueOf(L.get(cList));
    tcds.add(tcd);
    }
    }
    insert tcds;
    }
    public void updateTBys(Set<id> tbysIds)
    {
    for(TrainByStation__c tBYs:[select id,Train_Name__c,Train_No__c,Station_Code__c,Station_Name__c,Route_No__c,Arrival__c,Departure__c,Halt_Time__c,Distance_Km__c,Day_Count__c from TrainByStation__c where Train_Name__c=:trName and Train_No__c=:Integer.valueOf(trNo) and Station_Name__c IN:tbysIds])
    {
    System.debug('........tBYs.Station_Name__c.........................'+tBYs.Station_Name__c);
    System.debug('......chooseMap...........................'+chooseMap);
    if(tBYs.id!=null && chooseMap.containsKey(tBYs.Station_Name__c))
    {
    StationDetailsClass sdc=stationDetails.get(tBYs.Station_Name__c);
    tBYs.Station_Code__c=sdc.stCode;
    tBys.Arrival__c=sdc.arrTime;
    tBys.Departure__c=sdc.depTime;
    tBys.Halt_Time__c=sdc.haltTime;
    String schd='';
     for(String dy:runsMap.keySet())
    {
    if((runsMap.get(dy))=='true')
    {
    schd+=dy+',';
    }
    }
    tBys.Schedule__c=schd.substring(0,(schd.length()-1));
    tBys.Distance_Km__c=Integer.valueOf(sdc.dist);
    tBys.Route_No__c=sdc.rtNo;
    update tBys;
    }
    else if(tBYs.id!=null)
    {
    
    delete tBYs;
    }
    }
    }
    public void insertTBys(Set<String> tbysNames)
    {
    for(String tbysName:tbysNames)
    {
    TrainByStation__c tBys=new TrainByStation__c();
    tBys.Train_Name__c=trName;
    tBys.Train_No__c=Integer.valueOf(trNo);
    tBys.Station_Name__c=tbysName;
    StationDetailsClass sdc=stationDetails.get(tbysName);
    tBYs.Station_Code__c=sdc.stCode;
    tBys.Arrival__c=sdc.arrTime;
    tBys.Departure__c=sdc.depTime;
    tBys.Halt_Time__c=sdc.haltTime;
    String schd='';
     for(String dy:runsMap.keySet())
    {
    if((runsMap.get(dy))=='true')
    {
    schd+=dy+',';
    }
    }
    tBys.Schedule__c=schd.substring(0,(schd.length()-1));
    tBys.Distance_Km__c=Integer.valueOf(sdc.dist);
    tBys.Route_No__c=sdc.rtNo;
    insert tBys;
    }
    }
    public void TrainByStation(String station,String choose)
    {
    TrainByStation__c tBys;
    if(choose=='update')
    {
    tBys=[select id from TrainByStation__c where Train_Name__c=:trName and Train_No__c=:Integer.valueOf(trNo) and Station_Name__c=:station];
    }
    else if(choose=='insert')
    {
    tBys=new TrainByStation__c();
    tBys.Train_Name__c=trName;
    tBys.Train_No__c=Integer.valueOf(trNo);
    tBys.Station_Name__c=station;
    }
    StationDetailsClass sdc=stationDetails.get(station);
    tBYs.Station_Code__c=sdc.stCode;
    tBys.Arrival__c=sdc.arrTime;
    tBys.Departure__c=sdc.depTime;
    tBys.Halt_Time__c=sdc.haltTime;
    String schd='';
     for(String dy:runsMap.keySet())
    {
    if((runsMap.get(dy))=='true')
    {
    schd+=dy+',';
    }
    }
    tBys.Schedule__c=schd.substring(0,(schd.length()-1));
    tBys.Distance_Km__c=Integer.valueOf(sdc.dist);
    tBys.Route_No__c=sdc.rtNo;
    upsert tBys;
    }
    public void updateExisting(Set<Id> trIds)
    {
    for(Train__c t:[select id,From__c,To__c from Train__c where id IN:trIds])
    {
    if(t.id!=null && stationDetails.containsKey(t.From__c))
    {
    String schd='';
     for(String dy:runsMap.keySet())
    {
    if((runsMap.get(dy))=='true')
    {
    schd+=dy+',';
    }
    }
   System.debug('.............stationDetails...................'+stationDetails);
    StationDetailsClass sdcF=stationDetails.get(t.From__c);
    StationDetailsClass sdcT=stationDetails.get(t.To__c);
    t.Station_Code__c=sdcF.stCode;
    t.Arrival__c=sdcT.arrTime;
    t.Departure__c=sdcF.depTime;
    t.Halt_Time__c=sdcF.haltTime;
    t.Distance_KM__c=Integer.valueOf(sdcT.dist)-Integer.valueOf(sdcF.dist);
    t.Route__c=sdcF.rtNo;
    t.Source__c=srcSet;
    t.Destination__c=destSet;
    t.Schedule__c=schd.substring(0,(schd.length()-1));
    update t;
    }
    else if(t.id!=null)
    {
    delete t;
    }
    }
    }
    public String halTIME;
    public String getHalTime()
    {
    return halTIME;
    }
    public Train__c saveEntryDetails(String frm,String to) {
    
    String schd='';
    for(String dy:runsMap.keySet())
    {
    if((runsMap.get(dy))=='true')
    {
    schd+=dy+',';
    }
    }
    String stCode=stationCode.get(frm);
    StationDetailsClass sdcF=stationDetails.get(frm);
    StationDetailsClass sdcT=stationDetails.get(to);
    Train__c t=new Train__c();
    t.name=trName;
    t.Train_No__c=Integer.valueOf(trNo);
    t.From__c=frm;
    t.To__c=to;
    t.Arrival__c=sdcT.arrTime;
    t.Departure__c=sdcF.depTime;
    String[] arrT=(sdcT.arrTime).split(':');
    String[] depT=(sdcF.depTime).split(':');
    
    t.Halt_Time__c=sdcF.haltTime;
    
    String arrH1=(arrT[0]).substring(0);
    if(arrH1.substring(0,1)=='0')
    {
    arrH1=arrH1.substring(1);
    }
    
    String arrH2=(arrT[1]).substring(0);
    if(arrH2.substring(0,1)=='0')
    {
    arrH2=arrH2.substring(1);
    }
   
    String depH1=(depT[0]).substring(0);
    if(depH1.substring(0,1)=='0')
    {
    depH1=depH1.substring(1);
    
     System.debug('.......fdfdfdfdfd......'+depH1.substring(1));
    }
    String depH2=(depT[1]).substring(0);
    System.debug('.......sub.............................'+depH2.substring(0,1));
    if(depH2.substring(0,1)=='0')
    {
   
     System.debug('.......sub.......dfdfd......................'+depH2.substring(1));
    depH2=depH2.substring(1);
    }
     
    Integer arr=(Integer.valueOf(arrH1)*60)+Integer.valueOf(arrH2);
    Integer dep=(Integer.valueOf(depH1)*60)+Integer.valueOf(depH2);
    Integer trv1=arr-dep;
    Integer trvH=0;
    Integer trvM=trv1;
    if(trv1>59)
    {
    Integer tmp=trv1/60;
    
    
    Integer trv2=trv1-(tmp*60);
   
    trvH=trv1/60;
    
    trvM=trv2;
    
    }
    if((trvH*60)<1440)
    {
    t.Day_Count__c=1;
    }
    else if((trvH*60)>1440 && (trvH*60)<2880)
    {
    t.Day_Count__c=2;
    }
    else
    {
    t.Day_Count__c=3;
    }
    String trvHr='';
    String trvMin='';
    if(trvH>9)
    {trvHr=String.valueOf(trvH);}else{trvHr='0'+String.valueOf(trvH);}
    if(trvM>9)
    {trvMin=String.valueOf(trvM);}else{trvMin='0'+String.valueOf(trvM);}
    t.Travel_Time__c=trvHr+':'+trvMin;
    t.Distance_KM__c=Integer.valueOf(sdcT.dist)-Integer.valueOf(sdcF.dist);
    t.Route__c=sdcF.rtNo;
    
    t.Source__c=srcSet;
    t.Destination__c=destSet;
    
    t.Station_Code__c=stCode;
    
    t.Schedule__c=schd.substring(0,(schd.length()-1));
    
    return t;
    }

    
    public PageReference closeCheckDetails() {
     displayView=false;
        return null;
    }


    public boolean displayView { get; set; }

    public PageReference checkEntryDetails() {
    if(chooseValues.size()==stationDetails.size())
    {
    displayView=true;
    }
    else
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please set all time details'));
    }
        return null;
    }


    public Map<String,String> M { get; set; }    
    public Map<String,String> N { get; set; }    
    public Map<String,String> L { get; set; }
    public String coachVal {get;set;}
    public Map<String,StationDetailsClass> stationDetails { get; set; }
    public PageReference removeCoach() {
    M.remove(coachVal);
    N.remove(coachVal);
    L.remove(coachVal);
    for(Integer i=0;i<coachCountList.size();i++)
    {
    if(coachVal==coachCountList[i])
    {
    coachCountList.remove(i);
    }
    }
    coachCount=String.valueOf(coachCountList.size());
        return null;
    }


     public List<String> coachCountList { get; set; }

    public PageReference addCoach() {
    /*Integer j=0;
    for(String s:coachCountList)
    {
    
    Integer i=Integer.valueOf(s);
    if(i>j)
    {
    j=i;
    }
    
    }
    Integer k=j+1;
    coachCountList.add(String.valueOf(k));
    M.put(String.valueOf(k),'');
    N.put(String.valueOf(k),'');
    L.put(String.valueOf(k),'');
    coachCount=String.valueOf(coachCountList.size());
    */
    
    Integer j=coachCountList.size()-1;
    coachCountList.add(String.valueOf(j));
    M.put(String.valueOf(j),'');
    N.put(String.valueOf(j),'');
    L.put(String.valueOf(j),'');
    coachCount=String.valueOf(coachCountList.size());
        return null;
    }


    public PageReference GetCoachCnt() {
        return null;
    }


    public String coachCount { get; set; }

    public String routeNo { get; set; }

     public boolean editView{ get; set; }
     public boolean setView { get; set; }

    public PageReference EditTimeDetails() {
     if(chooseList.size()==1)
    {
    SetHaltTime();
    
    if(stationDetails.containsKey(chooseList[0]))
    {
    StationDetailsClass stClass=stationDetails.get(chooseList[0]);
    stClass.arrTime=hrA+':'+minA;
    stClass.depTime=hrD+':'+minD;
    stClass.haltTime=hrH+':'+minH;
    stClass.dist=dist;
    }
    }
        return null;
    }


    public String dist { get; set; }

    public String minD { get; set; }

    public String hrD { get; set; }

    public String minA { get; set; }

    public String hrA { get; set; }
    public String hrH { get; set; }
    public String minH { get; set; }
    public void SetHaltTime() {
    
    if(hrA!='' && minA!='' && hrD!='' && minD!='')
    {
   System.debug('................hrAT..................'+hrA);
   System.debug('...............minAT...................'+minA);
   System.debug('................hrDT..................'+hrD);
   System.debug('............... minDT...................'+ minD);
   
    String arrH1=hrA.substring(0);
     
    if(arrH1.substring(0,1)=='0')
    {
    arrH1=arrH1.substring(1);
     
    }
    
    String arrH2=minA.substring(0);
     
    if(arrH2.substring(0,1)=='0')
    {
    arrH2=arrH2.substring(1);
     
    }
   
    String depH1=hrD.substring(0);
     
    if(depH1.substring(0,1)=='0')
    {
    depH1=depH1.substring(1);
    
    }
    String depH2=minD.substring(0);
    
    if(depH2.substring(0,1)=='0')
    {
    depH2=depH2.substring(1);
     
    }
    Integer arr=(Integer.valueOf(arrH1)*60)+Integer.valueOf(arrH2);
    Integer dep=(Integer.valueOf(depH1)*60)+Integer.valueOf(depH2);
    Integer hal1=dep-arr;
    Integer halH=0;
    Integer halM=hal1;
    if(hal1>59)
    {
    Integer tmp=hal1/60;
    Integer hal2=hal1-(tmp*60);
    halH=hal1/60;
    halM=hal2;
    }
    
    String halHr='';
    String halMin='';
    if(halH>9)
    {halHr=String.valueOf(halH);}else{halHr='0'+String.valueOf(halH);}
    if(halM>9)
    {halMin=String.valueOf(halM);}else{halMin='0'+String.valueOf(halM);}
    hrH=halHr;
    minH=halMin;
   
    
    }
    
        //return null;
    }

    

    public PageReference SetTimeDetails() {
     if(chooseList.size()==1)
    {
    SetHaltTime();
    String stCode=[select Code__c from City__c where name=:(chooseList[0]) limit 1].Code__c;
    if(hrA!=null && hrD!=null && hrH!=null && minA!=null && minD!=null && minH!=null && dist!=null)
    {
    
    String arrT=hrA+':'+minA;
    String depT=hrD+':'+minD;
    String haltT=hrH+':'+minH;
    stationDetails.put(chooseList[0],new StationDetailsClass(stCode,arrT,depT,haltT,dist,routeNo));
    setView=false;
    editView=true;
    }
    }
        return null;
    }


    public PageReference downStationName() {
     String s=chooseList.get(0);
       
       if(chooseList.size()==1)
       {
       List<String> temp=new List<String>();
       temp.addAll(chooseValues);
       for(Integer i=0;i<chooseValues.size();i++)
       {
       if(chooseValues[i]==chooseList[0])
       {
       Integer j=i;
       if((j+1)==chooseValues.size())
       {
       chooseValues.set(i,temp.get(0));
       chooseValues.set(0,temp.get(i));
       }
       else
       {
       chooseValues.set(i,temp.get(i+1));
       chooseValues.set(i+1,temp.get(i));
       }
       break;
       }
       }
       }
        return null;
    }


    public PageReference upStationName() {
      if(chooseList.size()==1)
       {
       List<String> temp=new List<String>();
       temp.addAll(chooseValues);
       for(Integer i=0;i<chooseValues.size();i++)
       {
       if(chooseValues[i]==chooseList[0])
       {
       if(i==0)
       {
       chooseValues.set(0,temp.get(chooseValues.size()-1));
       chooseValues.set((chooseValues.size()-1),chooseList[0]);
       }
       else
       {
       chooseValues.set(i-1,chooseList[0]);
       chooseValues.set(i,temp.get(i-1));
       }
       break;
       }
       }
       }
       system.debug('.....chooseValues.......l.................'+chooseValues);
        return null;
    }


    public String availVal { get; set; }

    public PageReference SetStationDetails() {
     if(chooseList.size()==1)
    {
     src=chooseList[0];
    dest=chooseList[0];
    String s=chooseList[0];
    if(stationDetails.containsKey(s))
    {
    StationDetailsClass sdc=stationDetails.get(s);
    String arrT=sdc.arrTime;
    String depT=sdc.depTime;
    String[] aT=arrT.split(':');
    String[] dT=depT.split(':');
    hrA=aT[0];minA=aT[1];
    hrD=dT[0];minD=dT[1];
    dist=sdc.dist;
    routeNo=sdc.rtNo;
    setView=false;
    editView=true;
    }
    else
    {
    hrA='';minA='';hrD='';minD='';dist='';
    setView=true;
    editView=false;
    }
    }
        return null;
    }


    public List<SelectOption> getChooseSelValues() {
   
         List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(chooseValues);
        //tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
    }


    public List<String> chooseList { get; set; }
    public List<string> chooseValues {get; set;}
    public PageReference unstclick() {
    
     
       
       for(String s : chooseList){
           for(Integer i=0;i<chooseValues.size();i++)
           {
           if(chooseValues[i]==s)
           {
           chooseValues.remove(i);
           chooseMap.remove(chooseValues[i]);
           }
           }
        }
        return null;
    }


    public PageReference stclick() {
    
     System.debug('........availList............'+availList);
      System.debug('...chooseValues.................'+chooseValues);
         for(String s : availList)
        {
        boolean add=false;
        for(Integer i=0;i<chooseValues.size();i++)
           {
           if(chooseValues[i]==s)
           {
           add=true;
           }
           }
        if(!add)
            {
            chooseValues.add(s);
            chooseMap.put(s,s);
            }
           
        }
         System.debug('.....chooseValues....final...........'+chooseValues);
      
        //availValues.sort();
        
        return null;
    }


    public List<SelectOption> getAvailSelValues() {
    List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(availValues);
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
        return null;
    }

    public void GetCityFromStates() {
    Set<id> states=new Set<id>();
    List<String> cities=new List<String>();
     for(String key:stateListMap.keySet())
       {
        id stId=[select id from State__c where name=:(stateListMap.get(key)) limit 1].id;
       states.add(stId);
       }
       List<City__c> cts=[select id,name from City__c where StateName__c IN:states];
       for(City__c city:cts)
       {
       cities.add(city.name);
       }
       cities.sort();
       availValues.clear();
       availValues.addAll(cities);
        
    }
    public Map<String,Map<String,String>> stationListMap { get; set; }
    public List<String> availList { get; set; }
    public List<string> availValues = new List<string>();
    public Integer stateCnt { get; set; }
    public List<String> stateList { get; set; }
    public Map<String,String> stateListMap { get; set; }
    public PageReference GetTrainInfo() {
    dayNames.clear();
    runsMap.clear();
    stateList.clear();
    stateListMap.clear();
    for(Integer i=0;i<weekDays.size();i++)
            {
            dayNames.add(weekDays[i]);
            runsMap.put(weekDays[i],'');
            }
    if(trNo!='None')
    {
    Train__c t=[select id,Train_No__c,Schedule__c,Source__c,Destination__c from Train__c where name=:trName and Train_No__c=:Integer.valueOf(trNo) limit 1];
    List<String> schd=(t.Schedule__c).split(',');
    for(String sch:schd)
    {
    runsMap.put(sch,'true');
    }
    src=t.Source__c;
    srcSet=t.Source__c;
    dest=t.Destination__c;
    destSet=t.Destination__c;
    Set<String> cities=new Set<String>();
    for(Train__c tr:[select id,From__c,To__c from Train__c where name=:trName and Train_No__c=:Integer.valueOf(trNo)])
    {
    if(!fromStationIds.containsKey(tr.From__c))
    {
    Set<id> fId=new Set<Id>();
    fId.add(tr.id);
    fromStationIds.put(tr.From__c,fId);
    }
    else
    {
    Set<Id> fId=fromStationIds.get(tr.From__c);
    fId.add(tr.id);
    fromStationIds.put(tr.From__c,fId);
    }
    stations.add(tr.From__c);
    Map<String,String> fromTo=new Map<String,String>();
    fromTo.put(tr.From__c,tr.To__c);
    stationListMap.put(tr.id,fromTo);
     
    
    cities.add(tr.From__c);
    } 
    Set<id> cityIds=new Set<id>();
    for(City__c s:[select StateName__c from City__c where name IN:cities])
    {
    cityIds.add(s.StateName__c);
    }
    Set<String> states=new Set<String>();
    for(State__c st:[select name from State__c where id IN:cityIds])
    {
    states.add(st.name);
    }
    stateCnt=states.size();
    for(String stat:states)
    {
    stateListMap.put(stat,stat);
    }
    GetCityFromStates();
    Integer k=0;
    for(Train_Coach_Details__c tcd:[select id,Coach_Name__c,Coach_Category__c,Coache_Seats__c from Train_Coach_Details__c where name=:trName and Train_No__c=:Integer.valueOf(trNo) order by Coach_Name__c])
    {
   /* k++;
    
    coachCountList.add(String.valueOf(k);
    M.put(String.valueOf(k),tcd.Coach_Name__c);
    N.put(String.valueOf(k),tcd.Coach_Category__c);
    L.put(String.valueOf(k),String.valueOf(tcd.Coache_Seats__c));
   */
    coachCountList.add(tcd.id);
    M.put(tcd.id,tcd.Coach_Name__c);
    N.put(tcd.id,tcd.Coach_Category__c);
    L.put(tcd.id,String.valueOf(tcd.Coache_Seats__c));
    }
     coachCount=String.valueOf(coachCountList.size());
    for(TrainByStation__c tBys:[select Station_Name__c,Station_Code__c,Arrival__c,Departure__c,Halt_Time__c,Route_No__c,Distance_Km__c from TrainByStation__c where Train_Name__c=:trName and Train_No__c=:Integer.valueOf(trNo) order by Distance_Km__c])
    {
    chooseMap.put(tBys.Station_Name__c,tBys.Station_Name__c);
    chooseValues.add(tBys.Station_Name__c);
    stationDetails.put(tBys.Station_Name__c,new StationDetailsClass(tBys.Station_Code__c,tBys.Arrival__c,tBys.Departure__c,tBys.Halt_Time__c,String.valueOf(tBys.Distance_Km__c),tBys.Route_No__c));
    }
    }
    System.debug('..........stationListMap................'+stationListMap);
   System.debug('..........stations................'+stations);
   System.debug('..........fromStationIds..............'+fromStationIds);
        return null;
    }


    public PageReference GetTrainNos() {
    Set<String> trNos=new Set<String>();
    for(Train__c t:[select id,Train_No__c from Train__c where name=:trName])
    {
    trNos.add(String.valueOf(t.Train_No__c));
    }
    for(String tNo:trNos)
    {
    trainNos.add(new SelectOption(tNo,tNo));
    }
        return null;
    }


    

    public PageReference chooseTrainNos() {
        return null;
    }


    public List<String> weekDays= new List<String>{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'};
    public Map<String,String> runsMap { get; set; }
    public List<String> dayNames { get; set; }
    public String trNo { get; set; }
    public String trName { get; set; }
    public String dest { get; set; }
    public String destSet { get; set; }
    public String src { get; set; }
    public String srcSet { get; set; }
    public List<SelectOption> trainNos { get; set; }
    public String setSrcVal {get; set;}
    public String editSrcVal {get; set;}
    public String setSrcVal1 {get; set;}
    public String editSrcVal1 {get; set;}
    public PageReference SrcDestEdit() {
     if(editSrcVal=='0')
       {
       src='';
       srcSet='';
       editSrcVal='';
       }
       if(editSrcVal1=='1')
       {
       dest='';
       destSet='';
       editSrcVal1='';
       }
        return null;
    }


    public PageReference SrcDestSet() {
     if(src!=null)
       {
       if(setSrcVal=='0')
       {
       if(src.contains('-'))
       {
       String[] sr=src.split('-');
       srcSet=sr[0];
       }
       else
       {
       srcSet=src;
       }
       setSrcVal='';
       }
       }
       if(src!=null)
       {
       if(setSrcVal1=='1')
       {
       if(dest.contains('-'))
       {
       String[] ds=dest.split('-');
       destSet=ds[0];
       }
       else
       {
       destSet=dest;
       }
       setSrcVal1='';
       }
       }
    
        return null;
    }


    Map<String,String> stationCode=new Map<String,String>();

    public train_edit_ctrl()
    {
           
            trainNos=new List<SelectOption>();
            trainNos.add(new SelectOption('None','None'));
            dayNames=new List<String>();
            runsMap=new Map<String,String>();
            stateList=new List<String>();
            stateListMap=new Map<String,String>();
            stationListMap=new Map<String,Map<String,String>>();
            chooseList=new List<String>();
            chooseValues=new List<String>();
            availList=new List<String>();
            coachCountList=new List<String>();
            M=new Map<String,String>();
            N=new Map<String,String>();
            L=new Map<String,String>();
            stationDetails=new Map<String,StationDetailsClass>();
            for(City__c ct:[select name,Code__c from City__c])
            {
            stationCode.put(ct.name,ct.Code__c);
            }
            
            
    }
    class StationDetailsClass
    {
    public String stCode {get;set;}
    public String arrTime {get; set;}
    public String depTime {get; set;}
    public String haltTime {get; set;}
    public String dist {get; set;}
    public String rtNo  {get; set;}
    
    public StationDetailsClass(String stCode,String arrTime,String depTime,String haltTime,String dist,String rtNo)
    {
    this.stCode=stCode;
    this.arrTime=arrTime;
    this.depTime=depTime;
    this.haltTime=haltTime;
    this.dist=dist;
    this.rtNo=rtNo;
    }
    }
}