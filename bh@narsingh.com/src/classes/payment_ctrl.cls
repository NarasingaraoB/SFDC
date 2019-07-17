public class payment_ctrl {

    public String to { get; set; }
    public String classN { get; set; }
    public String jrDate { get; set; }

    public String trNo { get; set; }

    public String tName { get; set; }

    public String smsMobNo { get; set; }
    public Integer childCnt{get;set;}
    public String frm { get; set; }
    public String schArrival {get;set;}
    public String schDeparture {get;set;}
    public String dist{get;set;}
    public String trnsId { get; set; }
    public String bookDate {get; set;}
    public String pnrNo { get; set; }
    public Decimal tFare { get; set; }
    public Decimal srCharge { get; set; }
    public Decimal tAmt { get; set; }
    public String tFareWords { get; set; }
    public String tAmtWords { get; set; }
    public String srChargeWords { get; set; }
    public String pEList { get; set; }
    public String pNames { get; set; }
    public String pAge { get; set; }
    public String pGender { get; set; }
    public String aSeats { get; set; }
    public List<String> passList {get;set;}
    public Map<String,passengerWrapperClass> passMap{get;set;}
    public Map<String,String> passAge{get;set;}
    public Map<String,String> passGender{get;set;}
    public Map<String,String> passBirths {get;set;}
    public payment_ctrl()
    {
    childCnt=0;
    tFare=0.0;
    passMap=new Map<String,passengerWrapperClass>();
    passList=new List<String>();
    this.pnrNo=ApexPages.currentPage().getParameters().get('pnrNo');
    ticketInfo__c pnrInfo=[select id from ticketInfo__c where name=:pnrNo limit 1];
    for(PassengerInfo__c pInfo:[select id,name,Train_Name__c,Age__c,Train_No__c,From__c,To__c,Gender__c,Status__c,CoachName__c,SeatNo__c,Berth__c,TransactionId__c,Mobile_No__c,DateOfBooking__c,JourneyDate__c,Class__c,Distance_Km__c,Arrival__c,Departure__c,TicketFare__c  from PassengerInfo__c where ticketInfo__c=:pnrInfo.id])
    {
    tName=pInfo.Train_Name__c;
    trNo=String.valueOf(pInfo.Train_No__c);
    frm=pInfo.From__c;
    to=pInfo.To__c;
    trnsId=pInfo.TransactionId__c;
    smsMobNo=pInfo.Mobile_No__c;
    bookDate=String.valueOf(pInfo.DateOfBooking__c);
    jrDate=String.valueOf(pInfo.JourneyDate__c);
    classN=pInfo.Class__c;
    schArrival=pInfo.Arrival__c;
    schDeparture=pInfo.Departure__c;
    dist=String.valueOf(pInfo.Distance_Km__c);
    tFare=tFare+pInfo.TicketFare__c;
    passList.add(pInfo.name);
    Integer age=Integer.valueOf(pInfo.Age__c);
    if(age<6)
    {
    childCnt=childCnt+1;
    }
    passMap.put(pInfo.name, new passengerWrapperClass(pInfo.Age__c,pInfo.Gender__c,pInfo.Status__c,pInfo.CoachName__c,pInfo.SeatNo__c,pInfo.Berth__c,''));
    }
    for(String s:passMap.keySet())
    {
    System.debug('.......passMap...........................'+passMap.get(s));
    }
    
    tFareWords=new NumberToWord().english_number(Long.valueOf(String.valueOf(tFare)));
    srCharge=11.24;
    String[] sr=String.valueOf(srCharge).split('\\.');
    srChargeWords=new NumberToWord().english_number(Long.valueOf(sr[0]))+' rupees and'+new NumberToWord().convert_paise(Integer.valueOf(sr[1]))+' paise only';
    tAmt=tFare+srCharge;
    String[] tAm=String.valueOf(tAmt).split('\\.');
    tAmtWords=new NumberToWord().english_number(Long.valueOf(tAm[0]))+' rupees and '+new NumberToWord().convert_paise(Integer.valueOf(tAm[1]))+' paise only';
    
    }
    public class passengerWrapperClass
    {
    public String age {get;set;}
    public String gender {get;set;}
    public String status {get;set;}
    public String coachName {get;set;}
    public String seatNo {get;set;}
    public String Berth {get;set;}
    public String IdProof {get;set;}
    public String PassengerSeats {get;set;}
       public passengerWrapperClass(String age,String gender,String status,String coachName,String seatNo,String Berth,String IdProof)
       {
        this.age=age;
        this.gender=gender;
        this.status=status;
        this.coachName=coachName;
        this.seatNo=seatNo;
        this.Berth=Berth;
        this.IdProof=IdProof;
        this.PassengerSeats=status+'/'+coachName+'/'+seatNo+'/'+Berth;
       }
    }
    
}