public class book_ticket_ctrl {

    public String trnsId { get; set; }
    public Decimal srCharge { get; set; }
    public String srChargeWords { get; set; }
    public String pnrNo { get; set; }
    public String tAmtWords { get; set; }
    public String tFareWords { get; set; }
    public String tFare { get; set; }
    public Decimal tAmt { get; set; }
    public String pEList { get; set; }
    public String pNames { get; set; }
    public String pAge { get; set; }
    public String pGender { get; set; }
    public String aSeats { get; set; }
    public String schArrival;
    public String schDeparture;
    public Decimal distance;
    public Map<String,String> passNames{get;set;}
    public Map<String,String> passBirths {get;set;}
    public static string GenerateRandomNumber(integer length) {
    string result = '';
    while(result.length() < length){
         blob privateKey = crypto.generateAesKey(256);
   string randomString = EncodingUtil.base64Encode(crypto.generateMac('hmacSHA512',privateKey,privateKey));
   result += randomString.replaceAll('[^0-9]','');
    }
     result = result.substring(0,length);
     return result;
 }
    public PageReference PayBill() {
    Map<String,String> seatWithName=new Map<String,String>();
    Map<String,List<String>> alotedSeats=new Map<String,List<String>>();
    Integer passCount=passEntryList.size();
    srCharge=11.24;
    String[] sr=String.valueOf(srCharge).split('\\.');
    srChargeWords=new NumberToWord().english_number(Long.valueOf(sr[0]))+' rupees and'+new NumberToWord().convert_paise(Integer.valueOf(sr[1]))+' paise only';
    tFareWords=new NumberToWord().english_number(Long.valueOf(totalFare));
    tAmt=Decimal.valueOf(totalFare)+srCharge;
    String[] tAm=String.valueOf(tAmt).split('\\.');
    tAmtWords=new NumberToWord().english_number(Long.valueOf(tAm[0]))+' rupees and'+new NumberToWord().convert_paise(Integer.valueOf(tAm[1]))+' paise only';
    
    
    ticketInfo__c ticket=new ticketInfo__c();
    String pnr=String.valueOf(GenerateRandomNumber(10));
    ticket.name=pnr;
    insert ticket;
    System.debug('..........pnr....................'+pnr);
    ticketInfo__c pnrInfo=[select id from ticketInfo__c where name=:pnr limit 1];
    
    String[] dateS=jrDate.split('-');
    Date journeyDate=date.newinstance(Integer.valueOf(dateS[2]),Integer.valueOf(dateS[1]),Integer.valueOf(dateS[0]));
    TrainDetail__c td=[select id from TrainDetail__c where ScheduleTrains__c in (select id from ScheduleTrains__c where schDate__c=:journeyDate) and name=:trNo and Train_Name__c=:tName];
    List<CoachDetails__c> cd=[select id,(select id,name from CoachDetails__r where Category__c=:classN) from TrainDetail__c where id=:td.id].CoachDetails__r;
   Map<String,String> cDetails=new Map<String,String>();
   for(CoachDetails__c c:cd)
   {
   cDetails.put(c.id,c.name);
   }
   //new. start.................................................................
   Integer seatCount=0;
        String seatName='0';
   String srcNo=[select Station_No__c from TrainByStation__c where Train_Name__c=:tName and Train_No__c=:Integer.valueOf(trNo) and Station_Name__c=:frm limit 1].Station_No__c;
        String destNo=[select Station_No__c from TrainByStation__c where Train_Name__c=:tName and Train_No__c=:Integer.valueOf(trNo) and Station_Name__c=:to limit 1].Station_No__c;
        System.debug('...........srcNo..............'+srcNo);
        Set<String> coachSubIds=new Set<String>();
        Map<String,String> coachSubMap=new Map<String,String>();
        Map<String,String> berthWithNum=new Map<String,String>();
        for(CoachSubDivision__c cSub:[select id,CoachDetails__c,Seats__c,(select id,name,berthNumber__c from Berths__r) from CoachSubDivision__c where CoachDetails__c IN:cd])
        {
        coachSubIds.add(cSub.id);
        coachSubMap.put(cSub.id,cDetails.get(cSub.CoachDetails__c));
        List<Berths__c> berthList=cSub.Berths__r;
        System.debug('.......berthList.........'+berthList);
         
        for(Berths__c b:berthList)
        {
        berthWithNum.put(b.berthNumber__c,b.name);
        }
            }
            System.debug('.......berthWithNum................'+berthWithNum);
        Map<String,String> seatStatusMap=new Map<string,String>();
        Map<String,String> StatusMap=new Map<string,String>();
        List<String> seatStatusList=new List<string>();
        Map<String,String> statMap=new Map<String,String>();
        List<String> updateListId=new List<String>();
        for(SeatStatus__c stat:[select id,name,CoachSubDivision__c,Stations__c,Seats__c from SeatStatus__c where CoachSubDivision__c IN:coachSubIds])
        {
        if(stat.name=='process')
        {
        if(stat.Stations__c=='0-0')
        {
        seatCount=seatCount+1;
        System.debug('.......seat.........'+stat.Seats__c+'.........seatCount..............'+seatCount);
        seatStatusList.add(stat.id);
        StatusMap.put(stat.id,stat.CoachSubDivision__c);
        seatStatusMap.put(stat.id,stat.Seats__c);
        String seatUpdate=srcNo+'-'+destNo;
        statMap.put(stat.id,seatUpdate);
        }
        else
        {
        String[] splt=stat.Stations__c.split('-');
        
        if((Integer.valueOf(splt[0])>Integer.valueOf(srcNo) && splt[0]==destNo) || (Integer.valueOf(splt[0])>Integer.valueOf(srcNo) && Integer.valueOf(splt[0])>Integer.valueOf(destNo)))
        {
        seatCount=seatCount+1;
        System.debug('.......seat.........'+stat.Seats__c+'.........seatCount..............'+seatCount);
        seatStatusList.add(stat.id);
         StatusMap.put(stat.id,stat.CoachSubDivision__c);
         seatStatusMap.put(stat.id,stat.Seats__c);
         String a;
         String b;
         if(Integer.valueOf(splt[0])>Integer.valueOf(srcNo)  && splt[0]==destNo)
         {
         a=srcNo;
         b=splt[1];
         }
         if(splt[0]==destNo)
         {
         statMap.put(stat.id,(srcNo+'-'+splt[1]));
         }
         else
         {
         String tempSeat=srcNo+'-'+destNo+','+splt[0]+'-'+splt[1];
         statMap.put(stat.id,tempSeat);
         }
        }
        else if(Integer.valueOf(splt[1])==Integer.valueOf(srcNo))
        {
         seatCount=seatCount+1;
         System.debug('.......seat.........'+stat.Seats__c+'.........seatCount..............'+seatCount);
        seatStatusList.add(stat.id);
         StatusMap.put(stat.id,stat.CoachSubDivision__c);
         seatStatusMap.put(stat.id,stat.Seats__c);
         statMap.put(stat.id,(splt[0]+'-'+destNo));
        }
        }
        
        seatName=String.valueOf(seatCount);
        
        }
        }
        System.debug('..............availSeats...................'+seatName);
        System.debug('..............seatStatusMap...............'+seatStatusMap);
        System.debug('..............StatusMap...............'+StatusMap);
        System.debug('..............seatStatusList...............'+seatStatusList);
        System.debug('..............coachSubMap...............'+coachSubMap);
        Integer availS=Integer.valueOf(seatName);
        Integer remainPass=Integer.valueOf(seatName);
        if(passCount!=0)
        {
        if(passCount<=availS)
        {
        for(Integer i=(passCount-1);i>=0;i--)
        {
        
        String cName='confirm/'+coachSubMap.get(StatusMap.get(seatStatusList[i]))+'/'+seatStatusMap.get(seatStatusList[i])+'/'+(berthWithNum.get(seatStatusMap.get(seatStatusList[i]))).split('-')[0];
     System.debug('.........j.........'+i+'.........passEntryList................'+passEntryList); 
    seatWithName.put(passEntryList.get(i),cName);
  updateListId.add(seatStatusList[i]);
        }
        }
         else if(availS!=0 && passCount!=0)
         {
         
        Integer k=passCount-availS;
    for(Integer j=0;j<availS;j++)
    {
    
      String cName='confirm/'+coachSubMap.get(StatusMap.get(seatStatusList[j]))+'/'+seatStatusMap.get(seatStatusList[j])+'/'+(berthWithNum.get(seatStatusMap.get(seatStatusList[j]))).split('-')[0];
     System.debug('.........j.........'+j+'.........passEntryList................'+passEntryList); 
    seatWithName.put(passEntryList.get(passCount-1),cName);
    updateListId.add(seatStatusList[j]);
     passCount--;
     remainPass--;
    }
   System.debug('....availS..........'+availS+'.......passCount................'+passCount);
        }
     if(remainPass==0 && passCount!=0)
    {
    takeWaiting();
      Integer updateRAC=0;
    Integer updateWL=0;
    Integer currentRAC=0;
    Integer currentWL=0;
    String cName='';
    for(TrainWaitingList__c trainWl:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c =:td.id])
        {
         if(trainWl.name=='RAC')
        {
        currentRAC=Integer.valueOf(trainWl.waitingCount__c);
        }
        else if(trainWl.name=='WL')
        {
        currentWL=Integer.valueOf(trainWl.waitingCount__c);
        }
        }
    for(Integer j=0;j<passCount;j++)
    {
    System.debug('.......j...........'+j+'.......currentRAC......'+currentRAC+'...........currentWL....................'+currentWL);
    if(currentRAC<3)
        {
        currentRAC++;
        cName='RAC'+String.valueOf(currentRAC);
        }
        else
        {
        currentWL++;
        cName='WL'+String.valueOf(currentWL);
        }
        seatWithName.put(passEntryList.get(j),cName);
   
     System.debug('..........alotedSeats......................'+alotedSeats);
    System.debug('...........cName........................'+cName);
    System.debug('...........seatWithName........................'+seatWithName);
        
    }
   for(TrainWaitingList__c trainWls:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c =:td.id])
        {
         if(trainWls.name=='RAC')
        {
        trainWls.waitingCount__c=String.valueOf(currentRAC+1);
        }
        else  if(trainWls.name=='WL')
        {
        trainWls.waitingCount__c=String.valueOf(currentWL+1);
        }
        update trainWls;
        }
    }
        }
        System.debug('........seatWithName............new..................'+seatWithName);
        updateSeatStatus(statMap,updateListId);
   //new end...............................................................
   /*
  for(CoachSubDivision__c csd:[select id,name,Seats__c,CoachDetails__c,(select id,name,berthNumber__c from Berths__r)  from CoachSubDivision__c where CoachDetails__c IN:cd])
    {
     
     List<Berths__c> berthList=csd.Berths__r;
    System.debug('.......berthList.........'+berthList);
    Map<String,String> berthWithNum=new Map<String,String>();
    
    for(Berths__c b:berthList)
    {
    berthWithNum.put(b.berthNumber__c,b.name);
    }
    System.debug('.........berthWithNum....................'+berthWithNum);
    System.debug('....name....'+csd.name+'........seats...............'+csd.Seats__c);
    
    String[] splt=csd.Seats__c.split('-');
    Integer splt1=Integer.valueOf(splt[0]);
    Integer splt2=Integer.valueOf(splt[1]);
    Integer availS=(splt2-splt1)+1;
    System.debug('...............availS..........................'+availS);
    System.debug('..........passCount.....................'+passCount);
  //  for(Integer i=(passCount-1);i>=0;i--)
  //  {
  if(passCount!=0)
  {
    if(passCount<availS)
    {
    for(Integer i=(passCount-1);i>=0;i--)
    {
    Integer inc=splt1+i;
    System.debug('..start.....cDetails......'+cDetails+'.......berthWithNum............'+berthWithNum);
    String cName='confirm/'+cDetails.get(csd.CoachDetails__c)+'/'+String.valueOf(inc)+'/'+(berthWithNum.get(String.valueOf(inc))).split('-')[0];
     System.debug('.........j.........'+i+'.........passEntryList................'+passEntryList); 
    seatWithName.put(passEntryList.get(i),cName);
    if(alotedSeats.containsKey(csd.id))
    {
    alotedSeats.get(csd.id).add(csd.Seats__c);
    }
    else
    {
    List<String> csdIds=new List<String>();
    csdIds.add(csd.Seats__c);
    alotedSeats.put(csd.id,csdIds);
    }
     System.debug('..........alotedSeats......................'+alotedSeats);
    System.debug('...........cName........................'+cName);
    System.debug('...........seatWithName........................'+seatWithName);
    System.debug('..........passCount........inner.............'+passCount);
    passCount--;
   // availS--;
    }//addddd......................new......................
    }
    else if(availS!=0 && passCount!=0)
    {
    Integer k=passCount-availS;
    for(Integer j=(passCount-1);j>=k;j--)
    {
    Integer inc=splt1+(j-k);
    System.debug('.......cDetails......'+cDetails+'.......berthWithNum............'+berthWithNum);
    String cName='confirm/'+cDetails.get(csd.CoachDetails__c)+'/'+String.valueOf(inc)+'/'+(berthWithNum.get(String.valueOf(inc))).split('-')[0];
     System.debug('.........j.........'+j+'.........passEntryList................'+passEntryList); 
    seatWithName.put(passEntryList.get(j),cName);
    if(alotedSeats.containsKey(csd.id))
    {
    alotedSeats.get(csd.id).add(csd.Seats__c);
    }
    else
    {
    List<String> csdIds=new List<String>();
    csdIds.add(csd.Seats__c);
    alotedSeats.put(csd.id,csdIds);
    }
     System.debug('..........alotedSeats......................'+alotedSeats);
    System.debug('...........cName........................'+cName);
    System.debug('...........seatWithName........................'+seatWithName);
    
    }
    passCount=k;
    }
    else if(availS==0 && passCount!=0)
    {
    takeWaiting();
      Integer updateRAC=0;
    Integer updateWL=0;
    Integer currentRAC=0;
    Integer currentWL=0;
    String cName='';
    for(TrainWaitingList__c trainWl:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c =:td.id])
        {
         if(trainWl.name=='RAC')
        {
        currentRAC=Integer.valueOf(trainWl.waitingCount__c);
        }
        else if(trainWl.name=='WL')
        {
        currentWL=Integer.valueOf(trainWl.waitingCount__c);
        }
        }
    for(Integer j=0;j<passCount;j++)
    {
    System.debug('.......j...........'+j+'.......currentRAC......'+currentRAC+'...........currentWL....................'+currentWL);
    if(currentRAC<3)
        {
        currentRAC++;
        cName='RAC'+String.valueOf(currentRAC);
        }
        else
        {
        currentWL++;
        cName='WL'+String.valueOf(currentWL);
        }
        seatWithName.put(passEntryList.get(j),cName);
   
     System.debug('..........alotedSeats......................'+alotedSeats);
    System.debug('...........cName........................'+cName);
    System.debug('...........seatWithName........................'+seatWithName);
        
    }
   for(TrainWaitingList__c trainWls:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c =:td.id])
        {
         if(trainWls.name=='RAC')
        {
        trainWls.waitingCount__c=String.valueOf(currentRAC+1);
        }
        else  if(trainWls.name=='WL')
        {
        trainWls.waitingCount__c=String.valueOf(currentWL+1);
        }
        update trainWls;
        }
    }
    }
   // }
    
    }
    */
    updateseats(alotedSeats);
    for(Train__c t:[select Arrival__c,Departure__c,Distance_Km__c from Train__c where name=:tName and Train_No__c=:Integer.valueOf(trNo) and From__c=:frm and To__c=:to])
    {
    schArrival=t.Arrival__c;
    schDeparture=t.Departure__c;
    distance=t.Distance_Km__c;
    }
    Integer tAmt=0;
    for(TrainFare__c tf:[select id,Class__c,Distance_Km__c,Base_Fare__c,Reservation_Charges__c,Superfast_Charges__c,Other_Charges__c,Service_Tax_Charges__c from TrainFare__c where name=:tName and Train_No__c=:Integer.valueOf(trNo) and Class__c=:classN limit 1])
    {
    tAmt=Integer.valueOf(tf.Base_Fare__c)+Integer.valueOf(tf.Reservation_Charges__c)+Integer.valueOf(tf.Superfast_Charges__c)+Integer.valueOf(tf.Other_Charges__c)+Integer.valueOf(tf.Service_Tax_Charges__c);
    }
    
    List<PassengerInfo__c> passInfos=new List<PassengerInfo__c>();
    
    if(seatWithName.isEmpty())
    {
    Integer updateRAC=0;
    Integer updateWL=0;
    Integer currentRAC=0;
    Integer currentWL=0;
    String cName='';
    for(TrainWaitingList__c trainWl:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c =:td.id])
        {
         if(trainWl.name=='RAC')
        {
        currentRAC=Integer.valueOf(trainWl.waitingCount__c);
        }
        else if(trainWl.name=='WL')
        {
        currentWL=Integer.valueOf(trainWl.waitingCount__c);
        }
        }
    for(Integer j=0;j<passCount;j++)
    {
    System.debug('.......j...........'+j+'.......currentRAC......'+currentRAC+'...........currentWL....................'+currentWL);
    if(currentRAC<3)
        {
        currentRAC++;
        cName='RAC'+String.valueOf(currentRAC);
        }
        else
        {
        currentWL++;
        cName='WL'+String.valueOf(currentWL);
        }
        seatWithName.put(passEntryList.get(j),cName);
   
     System.debug('..........alotedSeats......................'+alotedSeats);
    System.debug('...........cName........................'+cName);
    System.debug('...........seatWithName........................'+seatWithName);
        
    }
   for(TrainWaitingList__c trainWls:[SELECT ID,name,TrainDetail__c,waitingCount__c FROM TrainWaitingList__c WHERE TrainDetail__c =:td.id])
        {
         if(trainWls.name=='RAC')
        {
        trainWls.waitingCount__c=String.valueOf(currentRAC+1);
        }
        else  if(trainWls.name=='WL')
        {
        trainWls.waitingCount__c=String.valueOf(currentWL+1);
        }
        update trainWls;
        }
    }
     
    System.debug('...........seatWithName........................'+seatWithName);
    for(Integer i=0;i<passEntryList.size();i++)
    {
    PassengerInfo__c passInfo=new PassengerInfo__c();
    passInfo.name=passName.get(passEntryList.get(i));
    passInfo.Age__c=passAge.get(passEntryList.get(i));
    passInfo.Gender__c=passGender.get(passEntryList.get(i));
    passInfo.ticketInfo__c=pnrInfo.id;
    passInfo.Train_Name__c=tName;
    passInfo.Train_No__c=Integer.valueOf(trNo);
    passInfo.Arrival__c=schArrival;
    passInfo.Departure__c=schDeparture;
    passInfo.Distance_Km__c=distance;
    passInfo.From__c=frm;
    passInfo.To__c=to;
    passInfo.Class__c=classN;
    passInfo.TransactionId__c=trnsId;
    passInfo.TicketFare__c=tAmt;
    passInfo.Mobile_No__c=smsMobNo;
    passInfo.JourneyDate__c=journeyDate;
    passInfo.DateOfBooking__c=system.today();
    
    if((seatWithName.get(passEntryList.get(i))).contains('/'))
    {
    String[] spltS=seatWithName.get(passEntryList.get(i)).split('/');
    passInfo.Status__c=spltS[0];
    passInfo.CoachName__c=spltS[1];
    passInfo.SeatNo__c=spltS[2];
    passInfo.Berth__c=spltS[3];
    }
    else
    {
    passInfo.Status__c='waiting';
    passInfo.CoachName__c='';
    passInfo.SeatNo__c=seatWithName.get(passEntryList.get(i));
    passInfo.Berth__c=seatWithName.get(passEntryList.get(i));
    }
    passInfos.add(passInfo);
    }
    insert passInfos;
   
    
    PageReference tb=new PageReference('/apex/payment');
    tb.getParameters().put('pnrNo',pnr);
    /*
    Blob ticket = tb.getcontentAsPdf();
Document d = new Document();
d.FolderId = UserInfo.getUserId();
d.Body = ticket;
d.Name = pnrNo;
d.ContentType = 'application/pdf';
d.Type = 'pdf';
insert d;
*/
        return tb;
    }
    public void takeWaiting()
    {
    
    }
    public void updateSeatStatus(Map<String,String> statMap,List<String> updateListId)
    {
    System.debug('...........statMap..................................'+statMap);
    System.debug('...........updateListId...........................'+updateListId);
    for(SeatStatus__c stat:[select id,Stations__c from SeatStatus__c where id IN:updateListId])
        {
        
        
        System.debug('........statMap.get(stat.id)............'+statMap.get(stat.id));
        stat.Stations__c=statMap.get(stat.id);
        
       // update stat;
        }
    }
    public void updateseats(Map<String,List<String>> alotedSeats)
    {
    System.debug('.......csdIds.....................'+alotedSeats);
    
    for(CoachSubDivision__c cSub:[select id,name,Seats__c from CoachSubDivision__c where id =:alotedSeats.keySet()])
    {
    System.debug('.....id...'+cSub.id+'.....name...'+cSub.name+'......Seats....'+cSub.Seats__c);
    String[] splt=cSub.Seats__c.split('-');
    
    Integer alot=((alotedSeats.get(cSub.id)).size());
    System.debug('...........size......id...'+cSub.id+'.................'+alot);
    Integer updateSeats=Integer.valueOf(splt[0])+alot;
    if(updateSeats>(Integer.valueOf(splt[1])))
    {
    cSub.Seats__c='1-0';
    }
    else
    {
    cSub.Seats__c=String.valueOf(updateSeats)+'-'+splt[1];
    }
    update cSub;
    
    
    }
    }
    public PageReference replan() {
    PageReference tb=new PageReference('apex/book_train');
        return tb;
    }


    public String ticketFare { get; set; }

    public String totalFare { get; set; }

    public String getAvailSeats() {
    String availSeats;
    System.debug('.........jrDate............'+jrDate);
    String[] dateS=jrDate.split('-');
    Date bookDate=date.newinstance(Integer.valueOf(dateS[2]),Integer.valueOf(dateS[1]),Integer.valueOf(dateS[0]));
    System.debug('.........bookDate............'+bookDate);
   /* DateByTrain__c dbt=[select X1AC__c,X2AC__c,X3AC__c,X2S__c,SL__c,CC__c from DateByTrain__c where Train_Name__c=:tName and Train_Number__c=:Integer.valueOf(trNo) and SheduleDate__c=:bookDate limit 1];
    if(classN=='')
    {
    }
    else if(classN=='1AC')
    {
    availSeats=dbt.X1AC__c;
    }
    else if(classN=='2AC')
    {
    availSeats=dbt.X2AC__c;
    }
    else if(classN=='3AC')
    {
    availSeats=dbt.X3AC__c;
    }
    else if(classN=='SL')
    {
    availSeats=dbt.SL__c;
    }
    else if(classN=='CC')
    {
    availSeats=dbt.CC__c;
    }
    else if(classN=='2S')
    {
    availSeats=dbt.X2S__c;
    }
    */
    Set<String> schTrainIds=new Set<String>();
        Set<String> trainIds=new Set<String>();
        Set<String> coachIds=new Set<String>();
        for(ScheduleTrains__c schTrs:[select id from ScheduleTrains__c where SchDate__c =:bookDate])
        {
        schTrainIds.add(schTrs.id);
        }
        for(TrainDetail__c tDetails:[select id,name from TrainDetail__c where ScheduleTrains__c IN:schTrainIds and Train_Name__c=:tName])
        {
        trainIds.add(tDetails.id);
        }
        for(CoachDetails__c cDetails:[select id,Category__c,Seats__c from CoachDetails__c where TrainDetail__c IN:trainIds])
        {
        if(classN==cDetails.Category__c)
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
        for(CoachSubDivision__c cSub:[select id,Seats__c from CoachSubDivision__c where CoachDetails__c IN:coachIds])
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
        }
        //details.add(seatName);
       // mapDetails.put(nextD,seatName);
       // System.debug('.......seatName.....'+seatName+'......details.....'+details+'........mapDetails.............'+mapDetails);
        //details.add(String.valueOf(seatCount));
        //mapDetails.put(nextD,String.valueOf(seatCount));
        return seatName;
        //return availSeats;
    }


    
    public Datetime currentDate {get;set;}
    public String randomCaptcha;
    public String getGetCaptcha() {
    String captcha='';
    captcha+=(getChar1()+getChar2()+getChar3()+getChar4()+getChar5()+getChar1());
    randomCaptcha=captcha;
        return captcha;
    }

 List<String> characters;   
 public Integer randomNumber(){
        Integer random = Math.Round(Math.Random() * characters.Size());
        if(random == characters.size()){
            random--;
        }
        return random;
    }
    public String getChar1(){
        
        return characters[randomNumber()];
    }
    public String getChar2(){
        return characters[randomNumber()];
    }
    public String getChar3(){
        return characters[randomNumber()];
    }
    public String getChar4(){
        return characters[randomNumber()];
    }
    public String getChar5(){
        return characters[randomNumber()];
    }
    public String getChar6(){
        return characters[randomNumber()];
    }
    
 
    public PageReference resetChildDetails() {
    for(Integer i=1;i<3;i++)
    {
    childName.put(String.valueOf(i),'');
    childAge.put(String.valueOf(i),'');
    childGender.put(String.valueOf(i),'');
    }
        return null;
    }


    public PageReference resetPassDetails() {
    for(Integer i=1;i<7;i++)
    {
    
    passName.put(String.valueOf(i),'');
    passAge.put(String.valueOf(i),'');
    passGender.put(String.valueOf(i),'');
    passBerth.put(String.valueOf(i),'');
    passSenior.put(String.valueOf(i),'');
    passProof.put(String.valueOf(i),'');
    }
        return null;
    }


    public PageReference backPage() {
     backView=true;
    nextView=false;
    captcha='';
        return null;
    }

    public List<String> passEntryList {get;set;}
    public List<String> childEntryList {get;set;}
    public boolean validateEntry()
    {
    Boolean b=false;
    if(passName.get('1')=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter atleast one passenger details '));
     
    }
    else if(captcha!=randomCaptcha)
    {
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Captcha text does not match'));
    }
    else
    {
    b=true;
    }
    return b;
    }
    public PageReference NextPage() {
    if(validateEntry())
    {
    backView=false;
    nextView=true;
    currentDate=datetime.now();
    passEntryList=new List<String>();
    for(String s:passList)
    {
    if((passName.get(s))!='')
    {
    passEntryList.add(s);
    }
    }
    for(String c:childList)
    {
    if((childName.get(c))!='')
    {
    childEntryList.add(c);
    }
    }
    Integer tAmt=0;
    for(TrainFare__c tf:[select id,Class__c,Distance_Km__c,Base_Fare__c,Reservation_Charges__c,Superfast_Charges__c,Other_Charges__c,Service_Tax_Charges__c from TrainFare__c where name=:tName and Train_No__c=:Integer.valueOf(trNo) and Class__c=:classN limit 1])
    {
    tAmt=Integer.valueOf(tf.Base_Fare__c)+Integer.valueOf(tf.Reservation_Charges__c)+Integer.valueOf(tf.Superfast_Charges__c)+Integer.valueOf(tf.Other_Charges__c)+Integer.valueOf(tf.Service_Tax_Charges__c);
    }
    ticketFare=String.valueOf(tAmt);
    Integer nofPass=passEntryList.size();
    totalFare=String.valueOf(tAmt*nofPass);
    }
        return null;
    }


    public boolean nextView { get; set; }

    public boolean backView { get; set; }

    public String payTypeInfo { get; set; }

    public String payType { get; set; }

    public boolean payTypeInfoView { get; set; }

    public PageReference paymentTypeInfo() {
    if(payType=='Net Banking')
    {
    payTypeInfoView=false;
    }
    else if(payType=='Credit Card')
    {
    payTypeInfoView=true;
    payTypeInfo='1.All VISA/MASTER Debit cards (If enabled by card issuer) can also be used for ticket booking through any of the VISA/MASTER credit card Payment gateways (ICICI PG, HDFC PG, AXIS PG, CITI PG).<br><br>2.All RuPay Debit Cards (If enabled by card issuer) can also be used for ticket booking through RuPay-Card KOTAK PG';
    }
    else if(payType=='Debit Card')
    {
    payTypeInfoView=true;
    payTypeInfo='1. If you have any Visa/Master Debit card not listed below, any of the Visa/Master credit card Payment Gateways (ICICI PG, HDFC PG, AXIS PG, CITI PG) can be used for ticket booking (If enabled by card issuer). Click Here to pay through Credit Card Payment Gateways.<br/>2. All RuPay Debit Card holders can pay through RuPay-Card KOTAK PG present under Payment Gateway/Credit Card section.';
    }
    else if(payType=='EMI')
    {
    payTypeInfoView=true;
    payTypeInfo='Please do not use Debit Cards for EMI Payments.';
    }
        return null;
    }



    public Map<Integer,String> advMap {get; set;}
    public String exUrl { get; set; }


    public String smsMobNo { get; set; }

    public String captcha { get; set; }

    public List<String> passList{get; set;}
    public Map<String,String> passName{get; set;}
    public Map<String,String> passAge{get; set;}
    public Map<String,String> passGender{get; set;}
    public Map<String,String> passBerth{get; set;}
    public Map<String,String> passSenior{get; set;}
    public Map<String,String> passProof{get; set;}
    public List<String> childList{get; set;}
    public Map<String,String> childName{get; set;}
    public Map<String,String> childAge{get; set;}
    public Map<String,String> childGender{get; set;}
    public String trNo { get; set; }
    public String tName { get; set; }
    public String frm { get; set; }
    public String jrDate { get; set; }
    public String to { get; set; }
    public String classN { get; set; }
    public book_ticket_ctrl()
    {
    trNo=ApexPages.currentPage().getParameters().get('trNo');
    tName=ApexPages.currentPage().getParameters().get('tName');
    frm=ApexPages.currentPage().getParameters().get('frm');
    jrDate=ApexPages.currentPage().getParameters().get('jrDate');
    to=ApexPages.currentPage().getParameters().get('to');
    classN=ApexPages.currentPage().getParameters().get('cls');
    passList=new List<String>();
    passName=new Map<String,String>();
    passAge=new Map<String,String>();
    passGender=new Map<String,String>();
    passBerth=new Map<String,String>();
    passSenior=new Map<String,String>();
    passProof=new Map<String,String>();
    for(Integer i=1;i<7;i++)
    {
    passList.add(String.valueOf(i));
    passName.put(String.valueOf(i),'');
    passAge.put(String.valueOf(i),'');
    passGender.put(String.valueOf(i),'');
    passBerth.put(String.valueOf(i),'');
    passSenior.put(String.valueOf(i),'');
    passProof.put(String.valueOf(i),'');
    }
    childList=new List<String>();
    childName=new Map<String,String>();
    childAge=new Map<String,String>();
    childGender=new Map<String,String>();
    for(Integer i=1;i<3;i++)
    {
    childList.add(String.valueOf(i));
    childName.put(String.valueOf(i),'');
    childAge.put(String.valueOf(i),'');
    childGender.put(String.valueOf(i),'');
    }
    advMap=new Map<Integer,String>();
    advMap.put(1,'');
    advMap.put(2,'');
    List<advertises__c> advs=[select docId__c from advertises__c where Name='book_ticket'];
    if(advs!=null && advs.size()>0)
    {
    Integer advPos=0;
    for(advertises__c adv:advs)
    {
    advPos++;
    String url='/servlet/servlet.FileDownload?file='+adv.docId__c;
    advMap.put(advPos,url);
    }
    }
    backView=true;
     characters = new List<String>{'a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p','q','r','s','t','u','v','w',
            'x','y','z','1','2','3','4','5','6','7','8','9','0'
        };
    
    
    }
}