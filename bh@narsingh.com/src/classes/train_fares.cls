public class train_fares {

    public PageReference EditFareDetails() {
    for(TrainFare__c tf:[select id,Class__c,Distance_Km__c,Base_Fare__c,Reservation_Charges__c,Superfast_Charges__c,Other_Charges__c,Service_Tax_Charges__c from TrainFare__c where name=:trName and Train_No__c=:Integer.valueOf(trNo) and Class__c IN: classes])
    {
    tf.Distance_Km__c=kmPerPrice.get(tf.Class__c);
    tf.Base_Fare__c=BaseFare.get(tf.Class__c);
    tf.Reservation_Charges__c=rCharges.get(tf.Class__c);
    tf.Superfast_Charges__c=sCharges.get(tf.Class__c);
    tf.Other_Charges__c=oCharges.get(tf.Class__c);
    tf.Service_Tax_Charges__c=sTaxCharges.get(tf.Class__c);
    update tf;
    }
    PageReference tf =new PageReference('https://c.ap2.visual.force.com/apex/train_fares');
        return tf;
    }


    public boolean addView{get;set;}
    public boolean editView{get;set;}
    public PageReference AddFareDetails() {
    for(String s:classes)
    {
    TrainFare__c tf=new TrainFare__c();
    tf.name=trName;
    tf.Train_No__c=Integer.valueOf(trNo);
    tf.Class__c=s;
    tf.Distance_Km__c=kmPerPrice.get(s);
    tf.Base_Fare__c=BaseFare.get(s);
    tf.Reservation_Charges__c=rCharges.get(s);
    tf.Superfast_Charges__c=sCharges.get(s);
    tf.Other_Charges__c=oCharges.get(s);
    tf.Service_Tax_Charges__c=sTaxCharges.get(s);
    insert tf;
    }
    PageReference tf =new PageReference('https://c.ap2.visual.force.com/apex/train_fares');
        return tf;
    }


    public Map<String,String> sTaxCharges { get; set; }

    public Map<String,String> oCharges { get; set; }

    public Map<String,String> sCharges { get; set; }

    public Map<String,String> rCharges { get; set; }

    public Map<String,String> BaseFare { get; set; }

    public Map<String,Decimal> kmPerPrice { get; set; }

    public train_fares()
    {
    trainNos=new List<SelectOption>();
    trainNos.add(new SelectOption('None','None'));
    classes=new Set<String>();
    sTaxCharges=new Map<String,String>();
    oCharges=new Map<String,String>();
    sCharges=new Map<String,String>();
    rCharges=new Map<String,String>();
    BaseFare=new Map<String,String>();
    kmPerPrice=new Map<String,Decimal>();
    
    }
    public PageReference GetTrainInfo() {
    if(trNo!='None')
    {
    for(Train_Coach_Details__c tcd:[select Coach_Category__c from Train_Coach_Details__c where name=:trName and Train_No__c=:Integer.valueOf(trNo)])
    {
    classes.add(tcd.Coach_Category__c);
    kmPerPrice.put(tcd.Coach_Category__c,0);
    BaseFare.put(tcd.Coach_Category__c,'0');
    rCharges.put(tcd.Coach_Category__c,'0');
    sCharges.put(tcd.Coach_Category__c,'0');
    oCharges.put(tcd.Coach_Category__c,'0');
    sTaxCharges.put(tcd.Coach_Category__c,'0');
     editView=false;
    addView=true;
    }
    Integer i=0;
    for(TrainFare__c tf:[select id,Class__c,Distance_Km__c,Base_Fare__c,Reservation_Charges__c,Superfast_Charges__c,Other_Charges__c,Service_Tax_Charges__c from TrainFare__c where name=:trName and Train_No__c=:Integer.valueOf(trNo) and Class__c IN: classes])
    {
    i++;
    if(tf.id!=null)
    {
    
    kmPerPrice.put(tf.Class__c,tf.Distance_Km__c);
    BaseFare.put(tf.Class__c,tf.Base_Fare__c);
    rCharges.put(tf.Class__c,tf.Reservation_Charges__c);
    sCharges.put(tf.Class__c,tf.Superfast_Charges__c);
    oCharges.put(tf.Class__c,tf.Other_Charges__c);
    sTaxCharges.put(tf.Class__c,tf.Service_Tax_Charges__c);
    }
    else
    {
   
    kmPerPrice.put(tf.Class__c,0);
    BaseFare.put(tf.Class__c,'0');
    rCharges.put(tf.Class__c,'0');
    sCharges.put(tf.Class__c,'0');
    oCharges.put(tf.Class__c,'0');
    sTaxCharges.put(tf.Class__c,'0');
    }
    }
    if(i>0)
    {
    editView=true;
    addView=false;
    }
    }
        return null;
    }
    public List<SelectOption> trainNos { get; set; }

    public String trNo { get; set; }

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

    public Set<String> classes {get;set;}
    public String trName { get; set; }
}