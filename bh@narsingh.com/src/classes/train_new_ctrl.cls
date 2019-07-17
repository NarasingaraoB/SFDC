global class train_new_ctrl {

    public List<SelectOption> cType { get; set; }

    public PageReference getCoachesOnFare() {
    cType.clear();
    cType.add(new SelectOption('None','None'));
    for(String s:N.keySet())
    {
    cType.add(new SelectOption(N.get(s),N.get(s)));
    }
        return null;
    }


    public String stationNo { get; set; }

    public String TrainDistance { get; set; }

   

   public Set<String> selectedCoachValues=new Set<String>();
    public boolean editfareBtnView { get; set; }
    public boolean setfareBtnView { get; set; }
    public String ServiceTax { get; set; }

    public String OtherCharges { get; set; }

    public String SuperfastCharges { get; set; }

    public String ReservationCharges { get; set; }

    public String BaseFare { get; set; }

    public boolean fareTxtView { get; set; }
    public Map<String,fareClass> coachFareWrapper{get;set;}
    public fareClass fareWrapper {get;set;}
    public String CoachAlot { get; set; }

    public String oCharges { get; set; }

    public String sCharges { get; set; }

    public String rCharges { get; set; }
    
    public String coachVal {get;set;}
    public Map<String,checkDetailsCalss> checkDetails {get;set;}
    public boolean displayView {get; set;}
    public boolean setView{ get; set; }
    public boolean editView{ get; set; }
    public String dest { get; set; }
    public String destSet { get; set; }
    public String src { get; set; }
    public String srcSet { get; set; }
    public String trNo { get; set; }
    public String trName { get; set; }
    public Map<String,stationListCalss> stListMap {get; set;}
    public Map<String,String> M { get; set; }    
    public Map<String,String> N { get; set; }    
    public Map<String,String> L { get; set; }
    public String coachCount { get; set; }    
    public List<String> coachCountList { get; set; }
    public String routeNo { get; set; }
    public String dist { get; set; }
    public String minH { get; set; }
    public String hrH { get; set; }
    public String minD { get; set; }
    public String hrD { get; set; }
    public String minA { get; set; }
    public String hrA { get; set; } 
    public List<String> chooseList { get; set; }
    public List<string> chooseValues {get;set;}
    public List<String> availList { get; set; }
    public Map<Integer,String> stateBoxMap { get; set; }
    public  List<Integer> stateBoxes { get; set; }
    public Integer stateCnt { get; set; }
    public List<String> weekDays= new List<String>{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'};
    public Map<String,String> runsMap { get; set; }
    public List<String> dayNames { get; set; }
    public String setSrcVal {get; set;}
    public String editSrcVal {get; set;}
    public String setSrcVal1 {get; set;}
    public String editSrcVal1 {get; set;}
    
    public train_new_ctrl()
    {
     dayNames=new List<String>();
     runsMap=new Map<String,String>();
     stateBoxes=new List<Integer>();
     stateBoxMap=new Map<Integer,String>();
     availList=new List<String>();
     chooseList=new List<String>();
     chooseValues = new List<string>();
     coachCountList=new List<String>();
     stListMap=new Map<string,stationListCalss>();
     checkDetails=new Map<String,checkDetailsCalss>();
     setView=true;
       for(Integer i=0;i<weekDays.size();i++)
       {
         dayNames.add(weekDays[i]);
         runsMap.put(weekDays[i],'');
       }
     stateCnt=0;
     fareTxtView=true;
     setfareBtnView=false;
     editfareBtnView=false;
     
    
    coachFareWrapper=new Map<String,fareClass>();
    fareWrapper = new fareClass('','','','','');
    N=new Map<String,String>();
    cType=new List<SelectOption>();
    cType.add(new SelectOption('None','None'));
    }
    
    public PageReference addCoach() {
    Integer j=0;
    for(String s:coachCountList)
    {
    
    Integer i=Integer.valueOf(s);
    if(i>j)
    {
    j=i;
    }
    
    }
    Integer k=j+1;
    System.debug('.......k.........k...........k...........'+k);
    if(k==1)
    {
    M=new Map<String,String>();
     L=new Map<String,String>();
     N=new Map<String,String>();
     }
    coachCountList.add(String.valueOf(k));
    M.put(String.valueOf(k),'');
    N.put(String.valueOf(k),'');
    L.put(String.valueOf(k),'');
    coachCount=String.valueOf(coachCountList.size());
        return null;
    }


    
    public PageReference removeCoach() {
    System.debug('.....M.......'+M);
    System.debug('.......coachVal...............'+coachVal);
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


    public void SetHaltTime() {
    if(hrA!='' && minA!='' && hrD!='' && minD!='')
    {
    if(hrA!='00' && minA!='00' && hrD!='00' && minD!='00')
    {
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
    String depH2=(minD).substring(0);
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
    else
    {
    hrH='00';
    minH='00';
    }
    }
    
        //return null;
    }
    
    public boolean validateDetails()
    {
    Integer i=0;
    for(String ky:runsMap.keySet())
    {
    if(runsMap.get(ky)=='true')
    {
    i=1;
    }
    }
    System.debug('....trName....'+trName+'.......trNo.....'+trNo+'.....runsMap.....'+runsMap+'......src.......'+srcSet+'.....dest........'+destSet);
       System.debug('...........chooseValues.......'+chooseValues+'....s.......'+chooseValues.size()+'....coachCountList............'+coachCountList+'...s......'+coachCountList.size());
    boolean valid=false;
    if(trName=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter train name'));
    }
    else if(trNo=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter train no'));
    }
    else if(i==0)
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose atleast one day in Runs On'));
    }
    else if(chooseValues.size()==0)
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please set station'));
    }
    else if(srcSet==null)
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please set source station'));
    }
    else if(destSet==null)
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please set destination station'));
    }
    else if(coachCountList.size()==0)
    {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter coach details'));
    }
    else if(stListMap.size()==0)
    {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please set timings to stations'));
    }
    else if(stListMap.size()!=chooseValues.size())
    {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check and set timings to all stations'));
    }
    else
    {
    valid=true;
    }
    return valid;
    }

    public PageReference saveEntryDetails() {
    if(validateDetails())
    {
    Map<String,List<String>> fromToMap=new Map<String,List<String>>();
    
    Set<String> temp=new Set<String>();
    temp.addAll(chooseValues);
    for(Integer i=0;i<chooseValues.size();i++)
    {
    String schd='';
    for(String dy:runsMap.keySet())
    {
    if((runsMap.get(dy))=='true')
    {
    schd+=dy+',';
    }
    }
    String stCode=[select Code__c from City__c where name=:(chooseValues[i]) limit 1].Code__c;
    stationListCalss stClass=stListMap.get(chooseValues[i]);
    String  aTime=stClass.arrHr+':'+stClass.arrMin;
    String  depTime=stClass.depHr+':'+stClass.depMin;
    String  haltTime=stClass.halHr+':'+stClass.halMin;
    
    TrainByStation__c tBys=new TrainByStation__c();
    tBys.Train_Name__c=trName;
    tBys.Train_No__c=Integer.valueOf(trNo);
    tBys.Station_Name__c=chooseValues[i];
    tBYs.Station_Code__c=stCode;
    tBys.Arrival__c=aTime;
    tBys.Departure__c=depTime;
    tBys.Halt_Time__c=haltTime;
    tBys.Schedule__c=schd.substring(0,(schd.length()-1));
    tBys.Distance_Km__c=Integer.valueOf(stClass.dist);
    tBys.Station_No__c=stClass.stationNo;
    tBys.Route_No__c=routeNo;
    insert tBys;
    temp.remove(chooseValues.get(i));
    List<String> toList=new List<String>();
    for(String tList:temp)
    {
    System.debug('..........stListMap..........................'+stListMap);
    stationListCalss stClassD=stListMap.get(chooseValues[i]);
    stationListCalss stClassA=stListMap.get(tList);
    String  arrTime=stClassA.arrHr+':'+stClassA.arrMin;
    String  dist=String.valueOf(Integer.ValueOf(stClassA.dist)-Integer.valueOf(stClassD.dist));
    toList.add(tList);
   
    Train__c t=new Train__c();
    t.name=trName;
    t.Train_No__c=Integer.valueOf(trNo);
    t.From__c=chooseValues[i];
    t.To__c=tList;
    //t.OrderByStations__c=i;
    
    t.Arrival__c=arrTime;
    t.Departure__c=depTime;
    t.Halt_Time__c=haltTime;
    
    String arrH1=(stClassA.arrHr).substring(0);
    if(arrH1.substring(0,1)=='0')
    {
    arrH1=arrH1.substring(1);
    }
    
    String arrH2=(stClassA.arrMin).substring(0);
    if(arrH2.substring(0,1)=='0')
    {
    arrH2=arrH2.substring(1);
    }
    System.debug('..from...arrH1........arrH2...................'+arrH1+','+arrH2+','+chooseValues[i]);
    String depH1=(stClassD.depHr).substring(0);
    if(depH1.substring(0,1)=='0')
    {
    depH1=depH1.substring(1);
    
     System.debug('.......fdfdfdfdfd......'+depH1.substring(1));
    }
    String depH2=(stClassD.depMin).substring(0);
    System.debug('.......sub.............................'+depH2.substring(0,1));
    if(depH2.substring(0,1)=='0')
    {
   
     System.debug('.......sub.......dfdfd......................'+depH2.substring(1));
    depH2=depH2.substring(1);
    }
     System.debug('..from...depH1........depH2...................'+depH1+','+depH2+','+chooseValues[i]);
     if(Integer.valueOf(arrH1)<Integer.valueOf(depH1))
     {
     Integer arH1=Integer.valueOf(arrH1);
     arH1=arH1+12;
     arrH1=String.valueOf(arH1);
     Integer deH1=Integer.valueOf(depH1);
     deH1=deH1-12;
     depH1=String.valueOf(deH1);
     }
    Integer arr=(Integer.valueOf(arrH1)*60)+Integer.valueOf(arrH2);
    Integer dep=(Integer.valueOf(depH1)*60)+Integer.valueOf(depH2);
    Integer trv1=arr-dep;
    
    Integer trvH=0;
    Integer trvM=trv1;
    if(trv1>59)
    {
    Integer tmp=trv1/60;
    System.debug('.............from............'+chooseValues[i]+'.........................tmp.................'+tmp);
    System.debug('.............from............'+chooseValues[i]+'.........................trv1................'+trv1);
    Integer trv2=trv1-(tmp*60);
    System.debug('.............from............'+chooseValues[i]+'.........................trv2................'+trv2);
    trvH=trv1/60;
    System.debug('.............from............'+chooseValues[i]+'.........................trvH................'+trvH);
    trvM=trv2;
    System.debug('.............from............'+chooseValues[i]+'.........................trvM................'+trvM);
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
    t.Distance_KM__c=Integer.valueOf(dist);
    t.Route__c=routeNo;
    
    t.Source__c=srcSet;
    t.Destination__c=destSet;
    
    t.Station_Code__c=stCode;
    
    t.Schedule__c=schd.substring(0,(schd.length()-1));
    insert t;
    
    }
    
    
     fromToMap.put(chooseValues[i],toList);
   
   
    }
   
    
    
    System.debug('.......fromToMap.....................'+fromToMap);
    System.debug('.......coachCountList.........'+coachCountList);
    for(String cnt:coachCountList)
    {
    Train_Coach_Details__c tcd=new Train_Coach_Details__c();
    tcd.name=trName;
    tcd.Train_No__c=Integer.valueOf(trNo);
    tcd.Coach_Name__c=M.get(cnt);
    tcd.Coach_Category__c=N.get(cnt);
    tcd.Coache_Seats__c=Integer.valueOf(L.get(cnt));
    insert tcd;
    }
    Date currentDate=System.today();
    for(Integer i=0;i<6;i++)
    { 
    Date addDate;
    if(i==0)
    {
    addDate=currentDate;
    }
    else
    {
    addDate=currentDate.addDays(i);
    }
    DateByTrain__c dbt=new DateByTrain__c();
    dbt.Train_Number__c=Integer.valueOf(trNo);
    dbt.Train_Name__c=trName;
    dbt.SheduleDate__c=addDate;
    Integer a1=0;
    Integer a2=0;
    Integer a3=0;
    Integer sl=0;
    Integer cc=0;
    Integer s2=0;
    for(String cnt:coachCountList)
    {
    if(N.get(cnt)=='1AC')
    {
    if(L.get(cnt)!=null)
    {
    a1=a1+Integer.valueOf(L.get(cnt));
    }
    }
    else if(N.get(cnt)=='2AC')
    {
    if(L.get(cnt)!=null)
    {
    a2=a2+Integer.valueOf(L.get(cnt));
    }
    }
    else if(N.get(cnt)=='3AC')
    {
    if(L.get(cnt)!=null)
    {
    a3=a3+Integer.valueOf(L.get(cnt));
    }
    }
    else if(N.get(cnt)=='SL')
    {
    if(L.get(cnt)!=null)
    {
    sl=sl+Integer.valueOf(L.get(cnt));
    }
    }
    else if(N.get(cnt)=='2S')
    {
    if(L.get(cnt)!=null)
    {
    s2=s2+Integer.valueOf(L.get(cnt));
    }
    }
    else if(N.get(cnt)=='CC')
    {
    if(L.get(cnt)!=null)
    {
    cc=cc+Integer.valueOf(L.get(cnt));
    }
    }
    }
    dbt.X1AC__c=String.valueOf(a1);
    dbt.X2AC__c=String.valueOf(a2);
    dbt.X3AC__c=String.valueOf(a3);
    dbt.SL__c=String.valueOf(sl);
    dbt.X2S__c=String.valueOf(s2);
    dbt.CC__c=String.valueOf(cc);
    insert dbt;
    }
    List<TrainFare__c> tFareList=new List<TrainFare__c>();
    for(String coachName:CoachFareWrapper.keySet())
    {
    TrainFare__c tFare=new TrainFare__c();
    tFare.name=trName;
    tFare.Train_No__c=Integer.valueOf(trNo);
    tFare.Class__c=coachName;
    fareClass fareC=CoachFareWrapper.get(coachName);
    tFare.Base_Fare__c=fareC.BaseFare;
    tFare.Reservation_Charges__c=fareC.ReservationCharges;
    tFare.Superfast_Charges__c=fareC.SuperfastCharges;
    tFare.Service_Tax_Charges__c=fareC.ServiceTax;
    tFare.Other_Charges__c=fareC.OtherCharges;
    tFare.Distance_Km__c=Integer.valueOf(TrainDistance);
    tFareList.add(tFare);
    }
    
    insert tFareList;
     PageReference home =new PageReference('https://c.ap2.visual.force.com/apex/IndianRailway');
        return home;
 
        }
        return null;
    }


    public PageReference closeCheckDetails() {
    displayView=false;
        return null;
    }

    
    
    
    public PageReference checkEntryDetails() {
     displayView=true;
     System.debug('.......stListMap...............'+stListMap);
     for(String key:checkDetails.keySet())
     {
      String stCode=[select Code__c from City__c where name=:key limit 1].Code__c;
      System.debug('............stCode..........'+stCode);
      //checkDetails.put(key,new checkDetailsCalss(stCode,'','','','','',''));
      
      if(stListMap!=null)
      {
      String arrTime='';
      String depTime='';
      String haltTime='';
      String dist='';
      String stNo='';
      if(stListMap.containsKey(key))
      {
      stationListCalss stClass=stListMap.get(key);
      arrTime=stClass.arrHr+':'+stClass.arrMin;
      depTime=stClass.depHr+':'+stClass.depMin;
      haltTime=stClass.halHr+':'+stClass.halMin;
      dist=stClass.dist;
      stNo=stClass.stationNo;
      }
    checkDetails.put(key,new checkDetailsCalss(stCode,key,routeNo,arrTime,depTime,haltTime,dist,stNo));
     }
     else
     {
     checkDetails.put(key,new checkDetailsCalss('','','','','','','',''));
     }
     }
     
     System.debug('......checkDetails................'+checkDetails);
        return null;
    }


    public PageReference EditTimeDetails() {
    if(chooseList.size()==1)
    {
    SetHaltTime();
    if(stListMap.containsKey(chooseList[0]))
    {
    stationListCalss stClass=stListMap.get(chooseList[0]);
    stClass.arrHr=hrA;
    stClass.depHr=hrD;
    stClass.halHr=hrH;
    stClass.arrMin=minA;
    stClass.depMin=minD;
    stClass.halMin=minH;
    stClass.dist=dist;
    stClass.stationNo=stationNo;
    }
    }
        return null;
    }

   

    public PageReference SetTimeDetails() {
    if(chooseList.size()==1)
    {
    SetHaltTime();
    if(hrA!=null && hrD!=null && hrH!=null && minA!=null && minD!=null && minH!=null && dist!=null && stationNo!=null)
    {
    stListMap.put(chooseList[0],new stationListCalss(hrA,hrD,hrH,minA,minD,minH,dist,stationNo));
    setView=false;
    editView=true;
    }
    }
    
        return null;
    }


   

    public PageReference SetStationDetails() {
    if(chooseList.size()==1)
    {
    src=chooseList[0];
    dest=chooseList[0];
    if(stListMap.containsKey(chooseList[0]))
    {
    stationListCalss stClass=stListMap.get(chooseList[0]);
    hrA=stClass.arrHr;
    hrD=stClass.depHr;
    hrH=stClass.halHr;
    minA=stClass.arrMin;
    minD=stClass.depMin;
    minH=stClass.halMin;
    dist=stClass.dist;
    stationNo=stClass.stationNo;
    editView=true;
    setView=false;
    }
    else
    {
    hrA='';hrD='';hrH='';minA='';minD='';minH='';dist='';stationNo='';
    setView=true;
    editView=false;
    }
    }
        return null;
    }


    public PageReference GetCoachCnt() {
     M=new Map<String,String>();
     L=new Map<String,String>();
     N=new Map<String,String>();
    coachCountList=new List<String>();
    if(coachCount!=null && coachCount!='')
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
      else
      {
      String s='0';
      coachCountList.add(s);
      M.put(s,'');
      N.put(s,'');
      L.put(s,'');
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
    system.debug('........chooseList.....................'+chooseList);
    system.debug('........choseValues......f...............'+chooseValues);
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


    public List<SelectOption> getChooseSelValues() {
    List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(chooseValues);
        //tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
       
    }


   
    public PageReference unstclick() {
    availList.clear();
     Set<String> temp=new Set<String>();
       temp.addAll(chooseValues);
       for(String s : chooseList){
            temp.remove(s);
            availValues.add(s);
            availValues.sort();
           checkDetails.remove(s);
           stListMap.remove(s);
        }
        chooseValues.clear();
        chooseValues.addAll(temp);
        return null;
    }


    public PageReference stclick() {
    chooseList.clear();
     Set<String> temp=new Set<String>();
        temp.addAll(availValues);
         for(String s : availList)
        {
            temp.remove(s);
            chooseValues.add(s);
            chooseValues.sort();
           checkDetails.put(s,new checkDetailsCalss('','','','','','','',''));
        }
        availValues.clear();
        availValues.addAll(temp);
        //availValues.sort();
        
        return null;
    }


    public  List<SelectOption> getAvailSelValues() {
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(availValues);
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }


   
    public List<string> availValues = new List<string>();
    public PageReference GetCityFromStates() {
    Set<id> states=new Set<id>();
    List<String> cities=new List<String>();
     for(Integer key:stateBoxMap.keySet())
       {
        id stId=[select id from State__c where name=:(stateBoxMap.get(key)) limit 1].id;
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
        return null;
    }

    

    public PageReference GetStateBoxs() 
    {
    stateBoxes.clear();
    stateBoxMap.clear();
    for(Integer i=1;i<=stateCnt;i++)
       {
       stateBoxes.add(i);
       stateBoxMap.put(i,'');
       }
       
        return null;
    }

    

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
    public PageReference GetCoachInfo() 
    {
    if(CoachAlot=='none')
    {
    fareTxtView=true;
    editfareBtnView=false;
    setfareBtnView=false;
    }
    else
    {
    System.debug('......CoachAlot...................'+CoachAlot);
    
   
    
    
    if(CoachFareWrapper.containsKey(CoachAlot))
    {
    setfareBtnView=false;
     editfareBtnView=true;
     fareTxtView=true;
    fareClass fareW=CoachFareWrapper.get(CoachAlot);
    ServiceTax=fareW.ServiceTax;
    OtherCharges=fareW.OtherCharges;
    SuperfastCharges=fareW.SuperfastCharges;
    ReservationCharges=fareW.ReservationCharges;
    BaseFare=fareW.BaseFare;
     System.debug('........fareWrapper.........................'+fareWrapper);
    }
    else
    {
    setfareBtnView=true;
     editfareBtnView=false;
     fareTxtView=false;
     ServiceTax='';
    OtherCharges='';
    SuperfastCharges='';
    ReservationCharges='';
    BaseFare='';
    CoachFareWrapper.put(CoachAlot,new fareClass('','','','',''));
    System.debug('......CoachFareWrapper....................'+CoachFareWrapper);
    }
    }
    return null;
    }
    public PageReference SetFareValues() {
    System.debug('......CoachAlot...................'+CoachAlot);
    
    setfareBtnView=false;
     editfareBtnView=true;
     fareTxtView=true;
   
    CoachFareWrapper.put(CoachAlot,new fareClass(ServiceTax,OtherCharges,SuperfastCharges,ReservationCharges,BaseFare));
    
    System.debug('......CoachFareWrapper....................'+CoachFareWrapper);
        return null;
    }
    public PageReference EditFareValues() 
    {
    setfareBtnView=true;
     editfareBtnView=false;
     fareTxtView=false;
    return null;
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
        List<sObject> M = new List<sObject>();
        Map<String,String> mm=new Map<String,String>();
        Set<String> N = new Set<String>();
        try 
        {
            L = Database.query(soql);
            for(sObject s:L)
            {
            String Name = (String) s.get('Name');
           
           if(!mm.containsKey(Name))
           {
           M.add(s);
           
           mm.put(Name,Name);
           
           
           }
           
            }
           
        }
        catch (QueryException e) 
        {
            system.debug('Query Exception:'+e.getMessage());
            return null;
        }
        
        return M;
   }
   class stationListCalss
   {
   public String arrHr {get; set;}
   public String depHr {get; set;}
   public String halHr {get; set;}
   public String arrMin {get; set;}
   public String depMin {get; set;}
   public String halMin {get; set;}
   public String dist {get; set;}
   public String stationNo {get;set;}
   public stationListCalss(String arrHr,String depHr,String halHr,String arrMin,String depMin,String halMin,String dist,String stationNo)
   {
   this.arrHr=arrHr;
   this.depHr=depHr;
   this.halHr=halHr;
   this.arrMin=arrMin;
   this.depMin=depMin;
   this.halMin=halMin;
   this.dist=dist;
   this.stationNo=stationNo;
   }
   }
   class checkDetailsCalss
   {
   public String stCode {get;set;}
   public String stName {get;set;}
   public String rtNo {get;set;}
   public String arrTime {get;set;}
   public String depTime {get;set;}
   public String haltTime {get;set;}
   public String distance {get;set;}
   public String stationNo {get;set;}
   public checkDetailsCalss(String stCode,String stName,String rtNo,String arrTime,String depTime,String haltTime,String distance,String stationNo)
   {
   this.stCode=stCode;
   this.stName=stName;
   this.rtNo=rtNo;
   this.arrTime=arrTime;
   this.depTime=depTime;
   this.haltTime=haltTime;
   this.distance=distance;
   this.stationNo=stationNo;
   }
   } 
   class fareClass
   {
   public String ServiceTax { get; set; }

    public String OtherCharges { get; set; }

    public String SuperfastCharges { get; set; }

    public String ReservationCharges { get; set; }

    public String BaseFare { get; set; }

   public fareClass(String sTax,String oCharges,String sCharges,String rCharges,String bFare)
   {
   this.ServiceTax=sTax;
   this.OtherCharges=oCharges;
   this.SuperfastCharges=sCharges;
   this.ReservationCharges=rCharges;
   this.BaseFare=bFare;
   
   }
   } 
}