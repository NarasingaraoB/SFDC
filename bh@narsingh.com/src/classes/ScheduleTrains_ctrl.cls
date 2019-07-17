public class ScheduleTrains_ctrl {

    public boolean btnView { get; set; }

  

   

    public PageReference saveEntryDetails() {
     System.debug('.............chooseDateList....................'+chooseDateList);
    System.debug('........CoachName............'+CoachName);
    System.debug('............CName.................................'+CName);
     System.debug('..........coachMap.......................'+coachMap);
    System.debug('...........scheduleMap......................'+scheduleMap);
     System.debug('..........coachMap.......................'+coachMap.keySet());
    System.debug('...........scheduleMap......................'+scheduleMap.keySet());
    List<ScheduleTrains__c> schdTrs=new List<ScheduleTrains__c>();
    System.debug('................chooseValues..............'+chooseValues);
    for(String schD:chooseValues)
    {
    ScheduleTrains__c schdTr=new ScheduleTrains__c();
    String[] splt=schD.split('-');
    Date schDate=date.newInstance(Integer.valueOf(splt[2]),Integer.valueOf(splt[1]),Integer.valueOf(splt[0]));
    schdTr.name=trNo;
    schdTr.SchDate__c=schDate;
    schdTrs.add(schdTr);
    }
    insert schdTrs;
    List<TrainDetail__c> trains=new List<TrainDetail__c>();
    List<String> schIds=new List<String>();
    Map<String,Date> schdMap=new Map<String,Date>();
    for(ScheduleTrains__c sch:[select id,SchDate__c from ScheduleTrains__c where name=:trNo])
    {
    schIds.add(sch.id);
    schdMap.put(sch.id,sch.SchDate__c);
    TrainDetail__c train=new TrainDetail__c();
    train.name=trNo;
    train.Train_Name__c=trName;
    train.ScheduleTrains__c=sch.id;
    trains.add(train);
    }
    insert trains;
    System.debug('...............schIds........................'+schIds);
    System.debug('..............schdMap.......................'+schdMap);
    System.debug('..............schdMap......keys.................'+schdMap.keySet());
    for(String s:schdMap.keySet())
    {
    System.debug('........maplist........................'+schdMap.get(s));
    }
    List<CoachDetails__c> cDetails=new List<CoachDetails__c>();
    Set<String> trainId=new Set<String>();
    Map<String,sheduleTrainWrapperCalss> schMap=new Map<String,sheduleTrainWrapperCalss>();
    for(TrainDetail__c tDetails:[select id,ScheduleTrains__c from TrainDetail__c where name=:trNo and Train_Name__c=:trName and ScheduleTrains__c IN:schIds])
    {
    System.debug('.....tr......schid......................'+tDetails.ScheduleTrains__c);
    Date d=schdMap.get(tDetails.ScheduleTrains__c);
    String dt=d.day()+'-'+d.month()+'-'+d.year();
    schMap=coachMap.get(dt);
    System.debug('.........schMap........................'+schMap);
    for(String s:schMap.keySet())
    {
    sheduleTrainWrapperCalss wrapper=schMap.get(s);
    System.debug('............wrapper..................'+wrapper);
    CoachDetails__c cDetail=new CoachDetails__c();
    cDetail.name=wrapper.cName;
    cDetail.Category__c=wrapper.coachType;
    cDetail.Seats__c=Integer.valueOf(wrapper.seats);
    cDetail.TrainDetail__c=tDetails.id;
    cDetails.add(cDetail);
    
    }
    System.debug('............cDetails..................'+cDetails);
    
    System.debug('...........tDetails.id...........................'+tDetails.id);
    trainId.add(tDetails.id);
    }
    insert cDetails;
    Set<String> coachIds=new Set<String>();
    Map<Id,String> coachIdsMap=new Map<Id,String>();
    List<CoachSubDivision__c> cSubs=new List<CoachSubDivision__c>();
    for(CoachDetails__c cDet:[select id,name from CoachDetails__c where TrainDetail__c IN:trainId])
    {
    System.debug('......cDet.id...............'+cDet.id);
    coachIds.add(cDet.id);
    coachIdsMap.put(cDet.id,cDet.name);
    if(schMap.containsKey(cDet.name))
    {
    sheduleTrainWrapperCalss wrapper=schMap.get(cDet.name);
    Map<String,String> subMap=wrapper.SeatsMap;
    
    for(String sub:subMap.keySet())
    {
    CoachSubDivision__c cSub=new CoachSubDivision__c();
    cSub.name=sub;
    cSub.Seats__c=subMap.get(sub);
    cSub.CoachDetails__c=cDet.id;
    cSubs.add(cSub);
    }
    }
    }
    insert cSubs;
    List<Berths__c> berths=new List<Berths__c>();
    List<SeatStatus__c> seatList=new List<SeatStatus__c>();
    for(CoachSubDivision__c cSubDiv:[select id,CoachDetails__c from CoachSubDivision__c where CoachDetails__c IN:coachIds])
    {
    System.debug('.........SubDiv..........................'+(cSubDiv.id));
    sheduleTrainWrapperCalss wrapper=schMap.get(coachIdsMap.get(cSubDiv.CoachDetails__c));
    Map<String,String> bMap=wrapper.berthMap;
    System.debug('.........bMap........................'+bMap);
    for(String b:bMap.keySet())
    {
    Berths__c berth=new Berths__c();
    berth.name=bMap.get(b);
    berth.berthNumber__c=b;
    berth.CoachSubDivision__c=cSubDiv.id;
    berths.add(berth);
    SeatStatus__c seat=new SeatStatus__c();
    seat.name='process';
    seat.CoachSubDivision__c=cSubDiv.id;
    seat.Seats__c=b;
    seat.Stations__c='0-0';
    seatList.add(seat);
    }
    }
    insert berths;
    insert seatList;
        return null;
    }


    public PageReference checkEntryDetails() {
        return null;
    }


    public boolean editView { get; set; }

    public boolean setView { get; set; }

    public PageReference EditSchDetails() {
    System.debug('.............chooseDateList....................'+chooseDateList);
    System.debug('........CoachName............'+CoachName);
    System.debug('............CName.................................'+CName);
     System.debug('..........coachMap.......................'+coachMap);
    System.debug('...........scheduleMap......................'+scheduleMap);
     System.debug('..........coachMap.......................'+coachMap.keySet());
    System.debug('...........scheduleMap......................'+scheduleMap.keySet());
    setView=true;
    editView=false;
        return null;
    }


    public PageReference SetSchDetails() {
     System.debug('.............chooseDateList....................'+chooseDateList);
    System.debug('........CoachName............'+CoachName);
    System.debug('............CName.................................'+CName);
     System.debug('..........coachMap.......................'+coachMap);
    System.debug('...........scheduleMap......................'+scheduleMap);
     System.debug('..........coachMap.......................'+coachMap.keySet());
    System.debug('...........scheduleMap......................'+scheduleMap.keySet());
    setView=false;
    editView=true;
    
    if(chooseDateList.size()==1)
    {
     if(coachMap.containsKey(chooseDateList[0]))
     {
     scheduleMap=coachMap.get(chooseDateList[0]);
     scheduleMap.put(CName,new sheduleTrainWrapperCalss(CoachName,CName,noOfSeats,coachSubList,SeatsMap,coachSeatsList,berthMap,unUsedMap,tatkalMap,coachUnUsedList,unusedListMap,unused,tatkal));
     coachMap.put(chooseDateList[0],scheduleMap);
     }
    }
    System.debug('..........coachMap.......................'+coachMap);
    System.debug('...........scheduleMap......................'+scheduleMap);
    System.debug('..........coachMap.......................'+coachMap.keySet());
    System.debug('...........scheduleMap......................'+scheduleMap.keySet());
        return null;
    }


    public PageReference GetTatkal() {
    System.debug('.........tatkalMap.........................'+tatkalMap);
    Map<String,String> tempMap=tatkal.get(SubNo);
    if(tatkalMap.get(tatkalCoach)=='true')
    {
    coachUnUsedList.add(tatkalCoach);
    tempMap.put(tatkalCoach,'true');
    coachUnUsedList.sort();
    }
    else
    {
    for(Integer i=0;i<coachUnUsedList.size();i++)
    {
    if(tatkalCoach==coachUnUsedList[i])
    {
    coachUnUsedList.remove(i);
    coachUnUsedList.sort();
    }
    }
    Set<String> temp=new Set<String>();
    temp.addAll(coachUnUsedList);
    coachUnUsedList.addAll(temp);
    }
     tatkal.put(SubNo,tempMap);
        return null;
    }


    public List<String> coachUnUsedList { get; set; }
    public Map<String,String> unusedListMap {get;set;}
    public Map<String,Map<String,String>> unused {get;set;}
    public Map<String,String> unUsedMap { get; set; }
    public Map<String,Map<String,String>> tatkal {get;set;}
    public Map<String,String> tatkalMap { get; set; }
    public String UnUsedCoach {get;set;}
    public String tatkalCoach {get;set;}
    public PageReference GetUnUsed() {
    System.debug('.........unUsedMap.........................'+unUsedMap);
    Map<String,String> tempMap=unused.get(SubNo);
    if(unUsedMap.get(UnUsedCoach)=='true')
    {
    coachUnUsedList.add(UnUsedCoach);
    tempMap.put(UnUsedCoach,'true');
    coachUnUsedList.sort();
    }
    else
    {
    for(Integer i=0;i<coachUnUsedList.size();i++)
    {
    if(UnUsedCoach==coachUnUsedList[i])
    {
    coachUnUsedList.remove(i);
    coachUnUsedList.sort();
    }
    }
    Set<String> temp=new Set<String>();
    temp.addAll(coachUnUsedList);
    coachUnUsedList.addAll(temp);
    }
     unused.put(SubNo,tempMap);
     
        return null;
    }


    public PageReference BerthView() {
    System.debug('...........SeatsMap......................'+SeatsMap);
    if((SeatsMap.get(SubBerthViemName))!='')
    {
    //SetBerthOfSeats();
    System.debug('......unused.............'+unused);
    coachSeatsList.clear();
      berthMap.clear();
     // String[] splt=SubSeats.split('-');
      String[] splt=SeatsMap.get(SubNo).split('-');
      Integer k=Integer.valueOf(splt[0]);
      Integer l=Integer.valueOf(splt[1]);
      if((l-k)<8)
      {
      Integer j=0;
      for(Integer i=k;i<=l;i++)
      {
      coachSeatsList.add(String.valueOf(i));
      berthMap.put(String.valueOf(i),berthNames[j]);
      //unUsedMap.put(String.valueOf(i),'false');
      j++;
      }
      }
      
    }
    
        return null;
    }


    public PageReference SetBerthOfSeats() {
    System.debug('..........SubNo.......................'+SubNo);
      System.debug('...........SeatsMap......................'+SeatsMap);
      if(unused.containsKey(SubNo))
      {
      unused.remove(SubNo);
      Map<String,String> temp=new Map<String,String>();
      unused.put(SubNo,temp);
      }
      if(tatkal.containsKey(SubNo))
      {
      tatkal.remove(SubNo);
      Map<String,String> temp=new Map<String,String>();
      tatkal.put(SubNo,temp);
      }
      coachSeatsList.clear();
      berthMap.clear();
     // String[] splt=SubSeats.split('-');
      String[] splt=SeatsMap.get(SubNo).split('-');
      Integer k=Integer.valueOf(splt[0]);
      Integer l=Integer.valueOf(splt[1]);
      if((l-k)<8)
      {
      Integer j=0;
      for(Integer i=k;i<=l;i++)
      {
      coachSeatsList.add(String.valueOf(i));
      berthMap.put(String.valueOf(i),berthNames[j]);
      coachSeatsListAll.add(String.valueOf(i));
      berthMapAll.put(String.valueOf(i),berthNames[j]);
      unUsedMap.put(String.valueOf(i),'false');
      tatkalMap.put(String.valueOf(i),'false');
      j++;
      }
      }
      System.debug('.......unUsedMap....................'+unUsedMap);
        return null;
    }


    public String SubSeats { get; set; }
    public String SubBerthViemName { get; set; }
    public List<String> coachSeatsList { get; set; }
    public Map<String,String> berthMap { get; set; }
    public List<String> coachSeatsListAll { get; set; }
    public Map<String,String> berthMapAll { get; set; }
    public PageReference removeSubDivision() {
    System.debug('......SeatsMap.................'+SeatsMap.keySet());
    System.debug('.....SubVal.............'+SubVal);
    System.debug('....................coachSeatsList...........................'+coachSeatsList);
    
     SeatsMap.remove(SubVal);
     for(Integer i=0;i<coachSubList.size();i++)
    {
    if(SubVal==coachSubList[i])
    {
    coachSubList.remove(i);
    }
    }
     for(Integer j=0;j<coachSeatsList.size();j++)
    {
    if(SubVal==coachSeatsList[j])
    {
    coachSeatsList.remove(j);
    }
    }
    if(berthMap.containsKey(SubVal))
      {
      berthMap.remove(SubVal);
      
      }
      if(unUsedMap.containsKey(SubVal))
      {
      unUsedMap.remove(SubVal);
      
      }
      if(tatkalMap.containsKey(SubVal))
      {
      tatkalMap.remove(SubVal);
      
      }
     if(unused.containsKey(SubVal))
      {
      unused.remove(SubVal);
      
      }
      if(tatkal.containsKey(SubVal))
      {
      tatkal.remove(SubVal);
      
      }
        return null;
    }
    public String SubVal {get;set;}
    public String SubNo {get;set;}
    public Map<String,String> SeatsMap{get;set;}
    public PageReference GetNoOfSeats() {
    
     if(noOfSeats!=null && noOfSeats!='')
      {
      
       for(Integer i=0;i<Integer.valueOf(noOfSeats);i++)
      {
      coachSubList.add(characters[i]);
      SeatsMap.put(characters[i],'');
      }
      }
        return null;
    }


    public List<String> coachSubList { get; set; }
Integer j=0;
    public PageReference addSubDivision() {
     if(j==0)
     {
     coachSubList=new List<String>();
     SeatsMap=new Map<String,String>();
     }
     coachSubList.add(characters[j]);
     SeatsMap.put(characters[j],'');
     Map<String,String> temp=new Map<String,String>();
     unused.put(characters[j],temp);
     tatkal.put(characters[j],temp);
     j++;
        return null;
    }


    public PageReference SeatsOnName() {
    System.debug('........coachNameWithSeats......................'+coachNameWithSeats);
    noOfSeats=coachNameWithSeats.get(CName);
   
    System.debug('.................chooseDateList..............'+chooseDateList);
    System.debug('.................coachMap..............'+coachMap);
    System.debug('.................scheduleMap.................'+scheduleMap);
    j=0;
    if(CName!='None')
    {
    btnView=true;
    if(scheduleMap.containsKey(CName))
    {
    sheduleTrainWrapperCalss wrapper=scheduleMap.get(CName);
    CoachName =wrapper.coachType;
    cName=wrapper.cName;
    coachSubList=wrapper.coachSubList;
    SeatsMap=wrapper.SeatsMap;
    coachSeatsList=wrapper.coachSeatsList;
    berthMap=wrapper.berthMap;
    unUsedMap=wrapper.unUsedMap;
    tatkalMap=wrapper.tatkalMap;
    coachUnUsedList=wrapper.coachUnUsedList;
    unusedListMap=wrapper.unusedListMap;
    unused=wrapper.unused;
    tatkal=wrapper.tatkal;
    setView=false;
    editView=true;
    }
    else
    {
           /* List<String> cSubList=new List<String>();
            Map<String,String> SMap=new Map<String,String>();
            List<string> cSeatsList=new List<string>();
            Map<String,String> bMap=new Map<String,String>();
            Map<string,String> uMap=new  Map<string,String>();
            Map<string,String> tMap=new Map<string,String>();
            List<string> cUnUsedList=new List<string>(); 
            Map<string,String> uListMap=new Map<string,String>();
            Map<String,Map<String,String>> uused=new Map<String,Map<String,String>>();
            Map<String,Map<String,String>> tt =new Map<String,Map<String,String>>();
    
          scheduleMap.put(CName,new sheduleTrainWrapperCalss('','',noOfSeats,cSubList,SMap,cSeatsList,bMap,uMap,tMap,cUnUsedList,uListMap,uused,tt));
    */
    coachSubList=new List<String>();
       SeatsMap=new Map<String,String>();
       coachSeatsList=new List<String>();
     berthMap =new Map<String,String>();
        coachSeatsListAll=new List<String>();
     berthMapAll =new Map<String,String>();
     unUsedMap=new Map<String,String>();
     tatkalMap=new Map<String,String>();
      coachUnUsedList= new List<String>();
    unusedListMap=new Map<String,String>();
    unused=new Map<String,Map<String,String>>();
    tatkal=new Map<String,Map<String,String>>();  
    scheduleMap.put(CName,new sheduleTrainWrapperCalss('','',noOfSeats,coachSubList,SeatsMap,coachSeatsList,berthMap,unUsedMap,tatkalMap,coachUnUsedList,unusedListMap,unused,tatkal));
    setView=true;
    editView=false;
    }
    }
    else
    {
    coachSubList=new List<String>();
       SeatsMap=new Map<String,String>();
        coachSeatsListAll=new List<String>();
     berthMapAll =new Map<String,String>();
     unUsedMap=new Map<String,String>();
     tatkalMap=new Map<String,String>();
      coachUnUsedList= new List<String>();
    unusedListMap=new Map<String,String>();
    unused=new Map<String,Map<String,String>>();
    tatkal=new Map<String,Map<String,String>>();  
    scheduleMap.put(CName,new sheduleTrainWrapperCalss('','',noOfSeats,coachSubList,SeatsMap,coachSeatsList,berthMap,unUsedMap,tatkalMap,coachUnUsedList,unusedListMap,unused,tatkal));
    }
   
        return null;
    }


    public String noOfSeats { get; set; }

    public List<SelectOption> CoachNameList { get; set; }

    public PageReference GetSeatInf() {
    
        return null;
    }


    public String CName { get; set; }
    public Map<String,String> coachNameWithSeats=new Map<String,String>();
    public PageReference CoachDataOnDate() {
     System.debug('......CoachName..........'+CoachName);
    System.debug('.........coachWrapper..............'+coachWrapper);
    CoachNameList.clear();
    System.debug('.............wrapper.............'+coachWrapper.get(CoachName));
    coachNameWithSeats.clear();
    if(CoachName!='None')
    {
    for(coachWrapperClass w:coachWrapper.get(CoachName))
    {
    coachNameWithSeats.put(w.SeatName,w.Seats);
    CoachNameList.add(new SelectOption(w.SeatName,w.SeatName));
  
    }
    }
        return null;
    }


    public List<SelectOption> getCoachList() {
    List<SelectOption> options=new List<SelectOption>();
     List<string> tempList = new List<String>();
        tempList.addAll(coachValues);
        //tempList.sort();
        for(String s : tempList)
        {
        String sText='';
        if(s=='1AC')
        {
        sText='First AC';
        }
        else if(s=='2AC')
        {
        sText='Second AC';
        }
        else if(s=='3AC')
        {
        sText='Third AC';
        }
        else if(s=='SL')
        {
        sText='Sleeper Class';
        }
        else if(s=='2S')
        {
        sText='Two Seater';
        }
        else if(s=='CC')
        {
        sText='Chair Car';
        }
            options.add(new SelectOption(s,sText));
            }
        return options;
      
     
       
    }


    public String CoachName { get; set; }
    public List<string> chooseValues {get;set;}
    public List<String> coachValues;
    public PageReference GetDates() {
    availValues.clear();
    Integer noOfDays = fromDate.daysBetween(toDate);
    for(Integer i=1;i<=noOfDays;i++)
    {
    Date newDate = fromDate.addDays(i);
    DAtetime newDateTime=datetime.newInstance(newDate.year(),newDate.month(),newDate.day());
    if(trainOnDays.contains(newDateTime.format('EEEE')))
    {
    String d=String.valueOf(newDate.day())+'-'+String.valueOf(newDate.month())+'-'+String.valueOf(newDate.year());
    availValues.add(d);
    }
    
    }
    System.debug('.....availValues...............'+availValues);
        return null;
    }

    public Map<String,sheduleTrainWrapperCalss> scheduleMap;
    public Map<String,Map<String,sheduleTrainWrapperCalss>> coachMap;
    public PageReference SetDetailsOnDate() {
    
    if(chooseDateList.size()==1)
    {
    System.debug('..........coachMap.............'+coachMap);
    System.debug('.........scheduleMap..........................'+scheduleMap);
    j=0;
    if(coachMap.containsKey(chooseDateList[0]))
    {
    scheduleMap=coachMap.get(chooseDateList[0]);
    CoachName='None';
    CName='None';
    if(CName=='None')
    {
    btnView=false;
    }
    else
    {
    btnView=true;
    }
    noOfSeats='';
    coachSubList=new List<String>();
       SeatsMap=new Map<String,String>();
        coachSeatsList=new List<String>();
     berthMap =new Map<String,String>();
        coachSeatsListAll=new List<String>();
     berthMapAll =new Map<String,String>();
     unUsedMap=new Map<String,String>();
     tatkalMap=new Map<String,String>();
      coachUnUsedList= new List<String>();
    unusedListMap=new Map<String,String>();
    unused=new Map<String,Map<String,String>>();
    tatkal=new Map<String,Map<String,String>>(); 
    setView=false;
    editView=true;
    }
    else
    {
    CoachName='None';
    CName='None';
    if(CName=='None')
    {
    btnView=false;
    }
    else
    {
    btnView=true;
    }
    noOfSeats='';
    setView=true;
    editView=false;
     coachSubList=new List<String>();
       SeatsMap=new Map<String,String>();
       coachSeatsList=new List<String>();
     berthMap =new Map<String,String>();
        coachSeatsListAll=new List<String>();
     berthMapAll =new Map<String,String>();
     unUsedMap=new Map<String,String>();
     tatkalMap=new Map<String,String>();
      coachUnUsedList= new List<String>();
    unusedListMap=new Map<String,String>();
    unused=new Map<String,Map<String,String>>();
    tatkal=new Map<String,Map<String,String>>(); 
    scheduleMap=new Map<String,sheduleTrainWrapperCalss>();
    //scheduleMap.put(CName,new sheduleTrainWrapperCalss('None','None',noOfSeats,coachSubList,SeatsMap,coachSeatsList,berthMap,unUsedMap,tatkalMap,coachUnUsedList,unusedListMap,unused,tatkal));
    
        coachMap.put(chooseDateList[0],scheduleMap);
    }
    System.debug('..........coachMap.............'+coachMap.get(chooseDateList[0]));
    System.debug('.........scheduleMap..........................'+scheduleMap);
    System.debug('..........coachMap.............'+coachMap.keySet());
    System.debug('.........scheduleMap..........................'+scheduleMap.keySet());
    }
        return null;
    }


    public  List<SelectOption> getSchdSelDates() {
    List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(chooseValues);
        //tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
      
    }


    public List<String> chooseDateList { get; set; }

    public PageReference unstclick() {
    availDates.clear();
     Set<String> temp=new Set<String>();
       temp.addAll(chooseValues);
        for(String s : chooseDateList){
            temp.remove(s);
            availValues.add(s);
            availValues.sort(); 
           
        }
        chooseValues.clear();
        chooseValues.addAll(temp);
        return null;
    }


    public PageReference stclick() {
    chooseDateList.clear();
     Set<String> temp=new Set<String>();
        temp.addAll(availValues);
     for(String s : availDates)
        {
            temp.remove(s);
            chooseValues.add(s);
            chooseValues.sort();
          
        }
        availValues.clear();
        availValues.addAll(temp);
        
        return null;
    }

    public Set<String> trainOnDays;
    public PageReference GetTrsNo() {
    if(trNo!='None')
    {
    String runsOn=[select Schedule__c from TrainByStation__c where Train_Name__c=:trName and Train_No__c=:Integer.valueOf(trNo) limit 1].Schedule__c;
     System.debug('......runsOn...................'+runsOn);
    List<String> days=runsOn.split(',');
     System.debug('........days.................'+days);
    trainOnDays.addAll(days);
    System.debug('......trainOnDays...................'+trainOnDays);
    Set<String> values=new Set<String>();
    coachValues.clear();
    coachWrapper.clear();
    for(Train_Coach_Details__c tcd:[select id,Coach_Name__c,Coache_Seats__c,Coach_Category__c from Train_Coach_Details__c where Train_No__c=:Integer.valueOf(trNo) and name=:trName])
    {
    values.add(tcd.Coach_Category__c);
    System.debug('.......fgfgfgfgfgf...............'+tcd.Coach_Category__c);
     System.debug('.......coachWrapper...........................'+coachWrapper);
    if(coachWrapper.containsKey(tcd.Coach_Category__c))
    {
    List<coachWrapperClass> temp=coachWrapper.get(tcd.Coach_Category__c);
    System.debug('.......temp..............'+temp);
    temp.add(new coachWrapperClass(tcd.id,tcd.Coach_Name__c,String.valueOf(tcd.Coache_Seats__c)));
    }
    else
    {
    List<coachWrapperClass> temp=new List<coachWrapperClass>();
    temp.add(new coachWrapperClass(tcd.id,tcd.Coach_Name__c,String.valueOf(tcd.Coache_Seats__c)));
    coachWrapper.put(tcd.Coach_Category__c,temp);
    }
    }
    coachValues.addAll(values);
    }
        return null;
    }


    public Map<String,List<coachWrapperClass>> coachWrapper {get;set;}
    public List<string> availValues = new List<string>();
    public List<SelectOption> getRunsOnDates() {
    
    List<SelectOption> options=new List<SelectOption>();
     List<string> tempList = new List<String>();
        tempList.addAll(availValues);
        for(string s : tempList)
            options.add(new SelectOption(s,s));
  
        return options;
    }


    public List<String> availDates { get; set; }

   
    public Date toDate { get; set; }

    public Date fromDate { get; set; }

    public  List<selectOption> TrNos { get; set; }

    public String trNo { get; set; }

    public PageReference chooseTrainNos() {
     TrNos.clear();
     Set<String> tNos=new Set<String>();
     for(Train__c tc:[select id,Train_No__c from Train__c where name=:trName])
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


    public String trName { get; set; }
    public List<String> characters {get;set;}
    public List<String> berthNames {get;set;}
    public ScheduleTrains_ctrl()
    {
    setView=true;
    TrNos=new List<SelectOption>();
    TrNos.add(new SelectOption('None','None'));
    availDates=new List<String>();
    fromDate=System.toDay();
    toDate=System.toDay();
    trainOnDays=new Set<String>();
    chooseDateList=new List<String>();
    chooseValues = new List<string>();
    coachValues=new List<String>();
    coachWrapper=new Map<String,List<coachWrapperClass>>();
    CoachNameList = new List<SelectOption>();
    
    characters = new List<String>{'A','B','C','D','E','F','G','H',
            'I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W',
            'X','Y','Z','1','2','3','4','5','6','7','8','9','0'
        };
    berthNames=new List<String>{'LB-LEFT','MB-LEFT','UB-LEFT','LB-RIGHT','MB-RIGHT','UB-RIGHT','LB-SIDE','UB-SIDE'};
   /* coachSubList=new List<String>();
     SeatsMap=new Map<String,String>();  
     
     unUsedMap=new Map<String,String>();
     tatkalMap=new Map<String,String>();
      coachUnUsedList= new List<String>();
    unusedListMap=new Map<String,String>();
    unused=new Map<String,Map<String,String>>();
    tatkal=new Map<String,Map<String,String>>();
    */
     coachSeatsList=new List<String>();
     berthMap =new Map<String,String>();
    scheduleMap=new Map<String,sheduleTrainWrapperCalss>();
    coachMap=new  Map<String,Map<String,sheduleTrainWrapperCalss>>();
    }
    class coachWrapperClass
    {
    public String coachId {get;set;}
    public String SeatName {get;set;}
    public String Seats {get;set;}
    public coachWrapperClass(String id,String name,String seats)
    {
    this.coachId=id;
    this.SeatName=name;
    this.Seats=seats;
    }
    }
    class sheduleTrainWrapperCalss
    {
    String coachType;
    String cName;
    String seats;
    List<String> coachSubList;
    Map<String,String> SeatsMap;
    List<String> coachSeatsList;
    Map<String,String> berthMap;
    Map<String,String> unUsedMap;
    Map<string,String> tatkalMap;
    List<string> coachUnUsedList;
    Map<string,String> unusedListMap;
    Map<String,Map<String,String>> unused;
    Map<String,Map<String,String>> tatkal;
    public sheduleTrainWrapperCalss(String cType,String cName,String seats,List<String> coachSubList,Map<String,String> SeatsMap,List<string> coachSeatsList,Map<String,String> berthMap,Map<string,String> unUsedMap,Map<string,String> tatkalMap,List<string> coachUnUsedList,Map<string,String> unusedListMap,Map<String,Map<String,String>> unused,Map<String,Map<String,String>> tatkal)
    {
    this.coachType=cType;
    this.cName=cName;
    this.seats=seats;
    this.coachSubList=coachSubList;
    this.SeatsMap=SeatsMap;
    this.coachSeatsList=coachSeatsList;
    this.berthMap=berthMap;
    this.unUsedMap=unUsedMap;
    this.tatkalMap=tatkalMap;
    this.coachUnUsedList=coachUnUsedList;
    this.unusedListMap=unusedListMap;
    this.unused=unused;
    this.tatkal=tatkal;
    }
    }
}