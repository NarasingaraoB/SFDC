global class book_train {

    public boolean ticketsView { get; set; }
//jQuery('[id$=tCoachInfo]').val(tNo+'/'+Coach);
    public PageReference addTInfoToTab() {
        return null;
    }
    public Map<String,String> testMap {get;set;}
    public List<String> datList {get; set;}
    public Integer seats {get; set;}
    public PageReference GetCoachInfo() {
    ticketsView=true;
        return null;
    }

    List<String> tabNames =new List<String>();
    public String TByCoachInfo {get; set;}
    public Component.Apex.TabPanel getTabPanel() {
    System.debug('.........TByCoachInfo....................'+TByCoachInfo);
    
    tabNames.add(TByCoachInfo);
    Component.Apex.TabPanel panel = new Component.Apex.TabPanel();
     panel.switchType = 'client';
     panel.width='70%';
       for(integer index = 0; index < tabNames.size(); index++) {
            Component.Apex.Tab tab = new Component.Apex.Tab();
            tab.id = 'tab'+string.valueof(index);
            tab.label = tabNames[index];
            panel.childComponents.add(tab);
            }
             
        return panel;
    }


    public String toStaion { get; set; }

    public String fromStaion { get; set; }

    public String handicap { get; set; }
    public List<String> categoryList {get;set;}
    public Map<String,boolean> categoryMap {get;set;}
    public List<String> tTypeList {get;set;}
    public Map<String,boolean> tTypeMap {get;set;}
    public List<String> fareList{get;set;}
    public book_train()
    {
    categoryList=new List<String>();
    categoryMap=new Map<string,boolean>();
    categoryList.add('1A');
    categoryMap.put('1A',true);
    categoryList.add('2A');
    categoryMap.put('2A',true);
    categoryList.add('3A');
    categoryMap.put('3A',true);
    categoryList.add('CC');
    categoryMap.put('CC',true);
    categoryList.add('SL');
    categoryMap.put('SL',true);
    categoryList.add('2S');
    categoryMap.put('2S',true);
    tTypeList=new List<String>();
    tTypeMap=new Map<string,boolean>();
    tTypeList.add('OTHERS');
    tTypeMap.put('OTHERS',true);
    tTypeList.add('GARIB RATH');
    tTypeMap.put('GARIB RATH',true);
    mainView=true;
    trList=new List<String>();
    wrapperTrains=new Map<String,wrapperTrains>();
    dayList=new List<String>();
    dayList.addAll(weekDays);
    datList=new List<String>();
    datList.add('1');
    datList.add('2');
    datList.add('3');
    testMap=new Map<String,String>();
    testMap.put('1','2');
    //srcText='VISHAKHAPATNAM';
    //desText='SECUNDERABAD';
    fareList=new List<String>();
    fareList.add('Base Fare');
    fareList.add('Reservation Charge');
    fareList.add('Superfast Charge    ');
    fareList.add('Other Chages');
    fareList.add('Tatkal Charge');
    fareList.add('Service Tax');
    fareList.add('Total Fare');
    String pg=Apexpages.currentPage().getParameters().get('pg');
    String sText=Apexpages.currentPage().getParameters().get('srcText');
    String dText=Apexpages.currentPage().getParameters().get('destText');
    String d=Apexpages.currentPage().getParameters().get('dat');
    new updateTByD();
    }
    @RemoteAction
    global static List<String> getFareDetails(String tNo,String tName,String Cls,String subDate) {
    List<String> details=new List<String>();
    for(TrainFare__c tf:[select Distance_Km__c,Base_Fare__c,Reservation_Charges__c,Superfast_Charges__c,Other_Charges__c,Service_Tax_Charges__c from TrainFare__c where name=:tName and Train_No__c=:Integer.valueOf(tNo) and Class__c =: Cls limit 1])
    {
    details.add(tf.Base_Fare__c);
    details.add(tf.Reservation_Charges__c);
    details.add(tf.Superfast_Charges__c);
    details.add(tf.Other_Charges__c);
    details.add('0');
    details.add(tf.Service_Tax_Charges__c);
    Integer total=Integer.valueOf(tf.Base_Fare__c)+Integer.valueOf(tf.Reservation_Charges__c)+Integer.valueOf(tf.Superfast_Charges__c)+Integer.valueOf(tf.Other_Charges__c)+Integer.valueOf(tf.Service_Tax_Charges__c);
    details.add(String.valueOf(total));
    }
    System.debug('......details.........'+details);
     return details;
    }
    @RemoteAction
    global static Map<String,String> getCoachDetails(String tNo,String tName,String Coach,String subDate,String frm,String to) {
    System.debug('...........tNo..............'+tNo);
     System.debug('.........tName................'+tName);
      System.debug('...........Coach..............'+Coach);
       System.debug('.........subDate................'+subDate);
        System.debug('............frm......................'+frm);
   System.debug('............to...........................'+to);
        List<String> details=new List<String>();
        Map<String,String> mapDetails=new Map<String,String>();
       Integer seats=0;
   /* for(Train_Coach_Details__c tcd:[select Coache_Seats__c from Train_Coach_Details__c where Train_No__c=:Integer.valueOf(tNo) and name=:tName and Coach_Category__c=:Coach])
    {
    seats=seats+Integer.valueOf(tcd.Coache_Seats__c);
    }
        for(Integer i=0;i<6;i++)
        {
        details.add(String.valueOf(seats));
        }
        */
      String[] datS=subDate.split('-');
        
        DateTime submitDate = datetime.newInstance(Integer.valueOf(dats[0]),Integer.valueOf(dats[1]),Integer.valueOf(dats[2]));
          Set<Date> dateTimeList=new Set<Date>();
          
        for(Integer i=0;i<6;i++)
        {
        DateTime nextDate;
        if(i==0)
        {
        nextDate = submitDate;
        }
        else
        {
        nextDate = submitDate.addDays(i);
        }
        String nextD = nextDate.format('dd-MM-yyyy');
        Date schDate = date.newinstance(nextDate.year(), nextDate.month(), nextDate.day());
       /* for(DateByTrain__c dbt:[select X1AC__c,X2AC__c,X3AC__c,X2S__c,CC__c,SL__c from DateByTrain__c where Train_Name__c=:tName and Train_Number__c=:Integer.valueOf(tNo) and SheduleDate__c=:schDate])
        {
        if(Coach=='1AC')
        {
        details.add(String.valueOf(dbt.X1AC__c));
        mapDetails.put(nextD,String.valueOf(dbt.X1AC__c));
        }
        else if(Coach=='2AC')
        {
        details.add(String.valueOf(dbt.X2AC__c));
         mapDetails.put(nextD,String.valueOf(dbt.X2AC__c));
        }
        else if(Coach=='3AC')
        {
        details.add(String.valueOf(dbt.X3AC__c));
        mapDetails.put(nextD,String.valueOf(dbt.X3AC__c));
        }
        else if(Coach=='2S')
        {
        details.add(String.valueOf(dbt.X2S__c));
        mapDetails.put(nextD,String.valueOf(dbt.X2S__c));
        }
        else if(Coach=='CC')
        {
        details.add(String.valueOf(dbt.CC__c));
        mapDetails.put(nextD,String.valueOf(dbt.CC__c));
        }
        else if(Coach=='SL')
        {
        details.add(String.valueOf(dbt.SL__c));
        mapDetails.put(nextD,String.valueOf(dbt.SL__c));
        }
        }
        */
        System.debug('...........schDate....................'+schDate);
        Set<String> schTrainIds=new Set<String>();
        Set<String> trainIds=new Set<String>();
        Set<String> coachIds=new Set<String>();
        for(ScheduleTrains__c schTrs:[select id from ScheduleTrains__c where SchDate__c =:schDate])
        {
        schTrainIds.add(schTrs.id);
        }
        System.debug('.......schTrainIds.......................'+schTrainIds);
        for(TrainDetail__c tDetails:[select id,name from TrainDetail__c where ScheduleTrains__c IN:schTrainIds and Train_Name__c=:tName])
        {
        trainIds.add(tDetails.id);
        }
        System.debug('.......trainIds................'+trainIds);
        for(CoachDetails__c cDetails:[select id,Category__c,Seats__c from CoachDetails__c where TrainDetail__c IN:trainIds])
        {
        if(Coach==cDetails.Category__c)
        {
        coachIds.add(cDetails.id);
        //details.add(String.valueOf(cDetails.Seats__c));
       // mapDetails.put(nextD,String.valueOf(cDetails.Seats__c));
        }
        
        }
        System.debug('........coachIds............'+coachIds);
        System.debug('........trainIds............'+trainIds);
        Integer seatCount=0;
        String seatName='0';
        Integer seatsExist=0;
        /*for(CoachSubDivision__c cSub:[select id,Seats__c from CoachSubDivision__c where CoachDetails__c IN:coachIds])
        {
        
        String seatNo=cSub.Seats__c;
        System.debug('......seatNo.......seatNo...............'+seatNo);
        String[] spltS=seatNo.split('-');
        if(spltS[1]!='0')
        {
        seatsExist=1;
        seatCount=seatCount+(Integer.valueOf(spltS[1])-Integer.valueOf(spltS[0]))+1;
        seatName=String.valueOf(seatCount);
        }
        else
        {
        if(seatsExist!=1)
        {
        //seatCount=-1;
        for(TrainWaitingList__c trainWl:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c IN:trainIds])
        {
        if(trainWl.name=='RAC')
        {
        Integer racCnt=Integer.valueOf(trainWl.waitingCount__c);
        if(racCnt<3)
        {
        seatCount=racCnt;
        seatName='RAC'+String.valueOf(seatCount);
        }
        }
        else if(trainWl.name=='WL')
        {
        if(seatCount==0)
        {
        Integer wlCnt=Integer.valueOf(trainWl.waitingCount__c);
        seatCount=wlCnt;
        seatName='WL'+String.valueOf(seatCount);
        }
        }
        }
        }
        }
        }*/
        
        String srcNo=[select Station_No__c from TrainByStation__c where Train_Name__c=:tName and Train_No__c=:Integer.valueOf(tNo) and Station_Name__c=:frm limit 1].Station_No__c;
        String destNo=[select Station_No__c from TrainByStation__c where Train_Name__c=:tName and Train_No__c=:Integer.valueOf(tNo) and Station_Name__c=:to limit 1].Station_No__c;
        System.debug('...........srcNo..............'+srcNo);
        Set<String> coachSubIds=new Set<String>();
        for(CoachSubDivision__c cSub:[select id,Seats__c from CoachSubDivision__c where CoachDetails__c IN:coachIds])
        {
        coachSubIds.add(cSub.id);
        }
        System.debug('.......coachSubIds.............'+coachSubIds);
        for(SeatStatus__c stat:[select id,name,Stations__c from SeatStatus__c where CoachSubDivision__c IN:coachSubIds])
        {
        System.debug('.........stat.id...........................'+stat.id);
        if(stat.name=='process')
        {
System.debug('.........stat.Stations__c...................'+stat.Stations__c);
        if(stat.Stations__c=='0-0')
        {
        seatCount=seatCount+1;
        System.debug('..........seatCount...........................'+seatCount);
        }
        else
        {
        String[] splt=stat.Stations__c.split('-');
        
        if((Integer.valueOf(splt[0])>Integer.valueOf(srcNo) && splt[0]==destNo) || (Integer.valueOf(splt[0])>Integer.valueOf(srcNo) && Integer.valueOf(splt[0])>Integer.valueOf(destNo)))
        {
        seatCount=seatCount+1;
        System.debug('..........seatCount...........................'+seatCount);
        }
        else if(Integer.valueOf(splt[1])==Integer.valueOf(srcNo))
        {
        seatCount=seatCount+1;
        System.debug('..........seatCount...........................'+seatCount);
        }
        }
       
        seatName=String.valueOf(seatCount);
        }
        }
        if(seatName=='0')
        {
        for(TrainWaitingList__c trainWl:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c IN:trainIds])
        {
        if(trainWl.name=='RAC')
        {
        Integer racCnt=Integer.valueOf(trainWl.waitingCount__c);
        if(racCnt<3)
        {
        seatCount=racCnt;
        seatName='RAC'+String.valueOf(seatCount);
        }
        }
        else if(trainWl.name=='WL')
        {
        if(seatCount==0)
        {
        Integer wlCnt=Integer.valueOf(trainWl.waitingCount__c);
        seatCount=wlCnt;
        seatName='WL'+String.valueOf(seatCount);
        }
        }
        }
        }
        details.add(seatName);
        mapDetails.put(nextD,seatName);
        System.debug('.......seatName.....'+seatName+'......details.....'+details+'........mapDetails.............'+mapDetails);
        //details.add(String.valueOf(seatCount));
        //mapDetails.put(nextD,String.valueOf(seatCount));
        }
       
        return mapDetails;
    }
    
    public boolean validateDetails()
    {
     boolean valid=false;
     if(dat==null)
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose Journey Date'));
    }
    else if(srcText=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose Source'));
    }
    else if(desText=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose Destination'));
    }
    else
    {
    valid=true;
    }
     return valid;
    }
    public PageReference Submit() {
    if(validateDetails())
    {
     System.debug('..............date..................'+dat);
    bookView=true;
    mainView=false;
    tabNames.clear();
    trList.clear();
    wrapperTrains.clear();
    Map<String,String> tsh;
    for(Train__c t:[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Schedule__c from Train__c where From__c=:SrcText and To__c=:DesText])
    {
    tsh=new Map<String,String>();
    tsh.put('Monday','N');tsh.put('Tuesday','N');tsh.put('Wednesday','N');tsh.put('Thursday','N');tsh.put('Friday','N');tsh.put('Saturday','N');tsh.put('Sunday','N');
    String sch=t.Schedule__c;
    String[] schs = sch.split(',');
    if(schs.size()>0 || schs!=null){
    for(Integer i=0;i<schs.size();i++)
    {
    if(schs[i]=='Monday')
    {
    tsh.put('Monday','Y');
    }else if(schs[i]=='Tuesday')
    {tsh.put('Tuesday','Y');
    }else if(schs[i]=='Wednesday')
    {tsh.put('Wednesday','Y');
    }else if(schs[i]=='Thursday')
    {tsh.put('Thursday','Y');
    }else if(schs[i]=='Friday')
    {tsh.put('Friday','Y');
    }else if(schs[i]=='Saturday')
    {tsh.put('Saturday','Y');
    }else if(schs[i]=='Sunday')
    {tsh.put('Sunday','Y');
    }
    }
    }
    Map<String,Integer> tcD=new Map<String,Integer>();
    for(Train_Coach_Details__c tcDetails:[select Coach_Category__c from Train_Coach_Details__c where name=:t.name])
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
    trList.add(t.id);
    wrapperTrains.put(t.id,new wrapperTrains(String.valueOf(t.Train_No__c),t.name,t.From__c,t.Departure__c,t.To__c,t.Arrival__c,String.valueOf(t.Distance_KM__c),t.Travel_Time__c,tsh,tcD)); 
    }
    }
        return null;
    }
    public class wrapperTrains
    {
    public String tNo {get; set;}
    public String tName {get; set;}
    public String frm {get; set;}
    public String depT {get; set;}
    public String to {get; set;}
    public String arrT {get; set;}
    public String dist {get; set;}
    public String travT {get; set;}
    public Map<String,String> tsh { get; set; }
    public Map<String,Integer> tcD { get; set; }
    public wrapperTrains(String tNo,String tName,String frm,String depT,String to,String arrT,String dist,String travT,Map<String,String> tsh,Map<String,Integer> tcD)
    {
    this.tNo=tNo;
    this.tName=tName;
    this.frm=frm;
    this.depT=depT;
    this.to=to;
    this.arrT=arrT;
    this.dist=dist;
    this.travT=travT;
    this.tsh=tsh;
    this.tcD=tcD;
    }
    }
    public List<String> trList {get; set;}
    public Map<String,wrapperTrains> wrapperTrains {get; set;}
    public boolean mainView {get; set;}
    public boolean bookView {get; set;}
    public Date dat { get; set; }

    public String DesText { get; set; }
    public List<String> dayList {get; set;}
    public List<String> weekDays= new List<String>{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'};
    public String SrcText { get; set; }
}