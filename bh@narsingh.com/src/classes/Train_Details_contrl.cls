global  class Train_Details_contrl {

    //New Tab Declaration and methods
    public String trName { get; set; }
    public String trNo { get; set; }
    public String trNoNew { get; set; }
    public boolean tNoRend {get; set; }
    public boolean tNoListRend {get; set;}
    public boolean displayView {get; set;}
    public boolean setSrcDestView {get; set;}
    public boolean editSrcDestView {get; set;}
    public Integer statesView {get; set;}       
    public List<SelectOption> trainNos { get; set; }
    public List<SelectOption> availStations { get; set; }
    public List<SelectOption> availCities { get; set; }
    public List<String> chooseList { get; set; }
    public List<String> availList { get; set; }
    public List<String> fromList { get; set; }
    public List<String> toList { get; set; }
    public List<string> availValues = new List<string>();
    public List<string> chooseValues = new List<string>();
    public List<string> fromValues {get;set;}
    public List<string> toValues = new List<string>();
    public List<String> arrList { get; set; } 
    public List<String> depList { get; set; } 
    public List<String> haltList { get; set; } 
    public String hrF {get; set;}
    public String minF {get;set;}
    public String hrT {get; set;}
    public String minT {get;set;} 
    public String hrH {get; set;}
    public String minH {get;set;} 
    public Map<String,String> fromTo {get; set;}
    public Map<String,TdetailsClass> detailsMap { get; set; }
    public List<String> val {get; set;} 
    public List<String> fromStationsList {get; set;}
    public List<String> toStationsList {get; set;}
    public Map<String,String> arrTMap {get; set;}
    public Map<String,String> depTMap {get; set;}  
    public Map<String,String> haltTMap {get; set;} 
    public String stateName {get; set;} 
    public Integer stateCnt {get; set;} 
    public List<Integer> stateBoxes {get; set;}
    public Map<Integer,String> stateBoxMap {get; set;}  
    public String src {get;set;}
    public String dest {get;set;}
    public String srcSet {get; set;}
    public String destSet {get; set;}
    public String setSrcVal {get; set;}
    public String editSrcVal {get; set;}
    public String setSrcVal1 {get; set;}
    public String editSrcVal1 {get; set;}
    public Map<String,String>  distanceMap {get; set;}
    public String dist {get; set;}
    public Map<String,String> runsMap {get; set;}
    public Map<String,List<String>> fromtoStationsMap {get; set;}
    public Map<String,stationsClass> StationsMap {get; set;}
    public List<String> dayNames { get; set; }
    public Set<String> schd=new Set<String>();
    public List<String> stationCodes {get; set;}
    public List<String> frStList {get; set;}
    public Map<String,Set<String>> fromToMapList;
      Public List<SelectOption> getAvailSelValues()
       {
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(availValues);
        //tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
       }
       public List<SelectOption> getChooseSelValues()
       {
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(chooseValues);
        //tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
       }
       Public PageReference stclick(){
        chooseList.clear();
        
        Set<String> temp=new Set<String>();
        temp.addAll(availValues);
         for(String s : availList)
        {
            temp.remove(s);
            chooseValues.add(s);
            chooseValues.sort();
            distanceMap.put(s,'');
        }
        availValues.clear();
        availValues.addAll(temp);
        availValues.sort();
        return null;
       }
       public PageReference unstclick(){
        availList.clear();
        Set<String> temp=new Set<String>();
        Set<String> tempF=new Set<String>();
        Set<String> tempT=new Set<String>();
        temp.addAll(chooseValues);
        tempF.addAll(fromValues);
        tempT.addAll(toValues);
        for(String s : chooseList){
            temp.remove(s);
            tempF.remove(s);
            tempT.remove(s);
            availValues.add(s);
            availValues.sort();
            distanceMap.remove(s);
        }
        chooseValues.clear();
        fromValues.clear();
        toValues.clear();
        chooseValues.addAll(temp);
        fromValues.addAll(tempF);
        toValues.addAll(tempT);
        chooseValues.sort();
        return null;
       }
       Public List<SelectOption> getFromStations()
       {
        List<SelectOption> options3 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(fromValues);
        //tempList.sort();
        for(string s : tempList)
            options3.add(new SelectOption(s,s));
        return options3;
       }
       Public List<SelectOption> getToStations()
       {
        List<SelectOption> options4 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(toValues);
        //tempList.sort();
        for(string s : tempList)
            options4.add(new SelectOption(s,s));
        return options4;
       }
       Public PageReference fromclick(){
        fromList.clear();
        Set<String> temp=new Set<String>();
        List<String> temp1=new List<String>();
        temp.addAll(fromValues);
        for(String s : chooseList){
            if(s.contains('-'))
            {
            String[] splitS=s.split('-');
            s=splitS[0];
            }
            for(String t:temp)
            {
            if(t.contains('-'))
            {
            String[] splitS=t.split('-');
            if(s==splitS[0])
            {
            s=t;
            }
            }
            }
            if(s!=destSet)
            {
            temp.add(s); 
            }  
        }
        fromValues.clear();
        fromValues.addAll(temp);
        fromStationsList.clear();
        for(String st:fromValues)
        {
        if(st.contains('-'))
            {
            String[] splitS=st.split('-');
            fromStationsList.add(splitS[0]);
            depTMap.put(splitS[0],splitS[1]);
            }
            else
            {
            depTMap.put(st,'00:00');
            fromStationsList.add(st);
            }
        }
        return null;
       }
       public PageReference fromunclick(){
        chooseList.clear();
        Set<String> temp=new Set<String>();
        temp.addAll(fromValues);
        for(String s : fromList){
        depTMap.remove(s);
            temp.remove(s);
            /*if(s.contains('-'))
            {
            String[] splitS=s.split('-');
            temp1.add(splitS[0]);
            }
            else
            {
            temp1.add(s);
            }*/
        fromValues.clear();
        fromValues.addAll(temp);
        fromStationsList.clear();
        fromStationsList.addAll(fromValues);
        
        }
        return null;
       }
      Public PageReference toclick(){
        toList.clear();
        Set<String> temp=new Set<String>();
        List<String> temp1=new List<String>();
        temp.addAll(toValues);
        for(String s : chooseList){
            //chooseValues.remove(s);
            if(s.contains('-'))
            {
            String[] splitS=s.split('-');
            s=splitS[0];
            }
            for(String t:temp)
            {
            if(t.contains('-'))
            {
            String[] splitS=t.split('-');
            if(s==splitS[0])
            {
            s=t;
            }
            }
            }
            if(s!=srcSet)
            {
            temp.add(s); 
            }  
        }
        toValues.clear();
        toValues.addAll(temp);
        toStationsList.clear();
        //toStationsList.addAll(toValues);
        for(String st:toValues)
        {
        if(st.contains('-'))
            {
            String[] splitS=st.split('-');
            toStationsList.add(splitS[0]);
            arrTMap.put(splitS[0],splitS[1]);
            }
            else
            {
            arrTMap.put(st,'00:00');
            toStationsList.add(st);
            }
            System.debug('....test...3+......'+toStationsList);
        }
        return null;
       }
       public PageReference tounclick(){
        availList.clear();
        Set<String> temp=new Set<String>();
        temp.addAll(toValues);
        for(String s : toList){
        arrTMap.remove(s);
            temp.remove(s);
          /* if(s.contains('-'))
            {
            String[] splitS=s.split('-');
            chooseValues.add(splitS[0]);
            }
            else
            {
            chooseValues.add(s);
            }*/
            toValues.clear();
            toValues.addAll(temp);
        }
        toStationsList.clear();
        toStationsList.addAll(toValues);
        
        return null;
       }
       Public PageReference showArrival(){
       if(fromList.size()==1)
       {
       String fList=fromList[0];
       if(fList.contains('-'))
       {
       String[] s1=flist.split('-');
       String[] s2=s1[1].split(':');
       hrF=s2[0];
       minF=s2[1];
       }
       else
       {
       hrF='';
       minF='';
       }
       }
       depList.clear();
       depList.addAll(fromList); 
       
       return null;
       }
       Public PageReference showDeparture(){
       if(toList.size()==1)
       {
       String fList=toList[0];
       if(fList.contains('-'))
       {
       String[] s1=flist.split('-');
       String[] s2=s1[1].split(':');
       hrT=s2[0];
       minT=s2[1];
       }
       else
       {
       hrT='';
       minT='';
       }
       }
       arrList.clear();
       arrList.addAll(toList); 
       return null;
       }
       Public PageReference showHalt()
       {
       
       if(chooseList.size()==1)
       {
       src=chooseList[0];
       dest=chooseList[0];
       String fList=chooseList[0];
       if(fList.contains('-'))
       {
       String[] s1=flist.split('-');
       String[] s2=s1[1].split(':');
       hrH=s2[0];
       minH=s2[1];
       if(distanceMap.containsKey(s1[0]))
       {
       dist=distanceMap.get(s1[0]);
       }
       else
       {
       dist='';
       }
       }
       else
       {
       hrH='';
       minH='';
       if(distanceMap.containsKey(fList))
       {
       dist=distanceMap.get(fList);
       }
       else
       {
       dist='';
       }
       }
       /*
       if(distanceMap.containsKey(chooseList[0]))
       {
       dist=distanceMap.get(chooseList[0]);
       }
       else
       {
       dist='';
       }
       */
       }
       haltList.clear();
       haltList.addAll(chooseList); 
       
       return null;
       }
       Public PageReference DepTime(){
       if(depList.size()==1)
       {
       String depTime=hrF+':'+minF;
       String dr=depList[0];
       String drT=dr+'-'+hrF+':'+minF;
      /* Set<String> temp=new Set<String>();
       temp.addAll(fromValues);
       temp.remove(ar);
       fromValues.clear();
       fromValues.addAll(temp);
       fromValues.add(arT);
       */
       for(Integer i=0;i<fromValues.size();i++)
       {
       if(fromValues[i]==dr)
       {
       
       fromValues.set(i,drT);
       }
       }
       fromStationsList.clear();
      fromStationsList.addAll(fromValues);
      for(Integer k=0;k<fromStationsList.size();k++)
       {
       if(fromStationsList[k].contains('-'))
       {
       String[] ss=(fromStationsList.get(k)).split('-');
       fromStationsList.set(k,ss[0]);
       }
       }      
            depTMap.put(dr,depTime);
       }
       return null;
       }
       Public PageReference ArrTime(){
       if(arrList.size()==1)
       {
       String ar=arrList[0];
       String arrTime=hrT+':'+minT;
       String arT=ar+'-'+hrT+':'+minT;
       /*Set<String> temp=new Set<String>();
       temp.addAll(toValues);
       temp.remove(ar);
       toValues.clear();
       toValues.addAll(temp);
       toValues.add(arT);
       toStationsList.clear();
       */
       for(Integer i=0;i<toValues.size();i++)
       {
       if(toValues[i]==ar)
       {
       
       toValues.set(i,arT);
       }
       }
      toStationsList.addAll(toValues);
      for(Integer k=0;k<toStationsList.size();k++)
       {
       if(toStationsList[k].contains('-'))
       {
       String[] ss=(toStationsList.get(k)).split('-');
       toStationsList.set(k,ss[0]);
       }
       }      
            arrTMap.put(ar,arrTime);
       }
       return null;
       }
       Public PageReference HalTime()
       {
       /*
       if(haltList.size()==1)
       {
       String halTime=hrH+':'+minH;
       String ha=haltList[0];
       Set<String> temp=new Set<String>();
       temp.addAll(chooseValues);
       temp.remove(ha);
       
       if(ha.contains('-'))
       {
       String[] spt=ha.split('-');
       ha=spt[0];
       }
       
       String haT=ha+'-'+hrH+':'+minH;
       
       chooseValues.clear();
       chooseValues.addAll(temp);
       chooseValues.add(haT);
       
       haltTMap.put(ha,haT);
       }
       haltList.clear();
       */
       if(haltList.size()==1)
       {
       String halTime=hrH+':'+minH;
       String ha=haltList[0];
       for(Integer i=0;i<chooseValues.size();i++)
       {
       if(chooseValues[i]==ha)
       {
       ha=ha+'-'+halTime;
       chooseValues.set(i,ha);
       }
       }
       }
       return null;
       }
       Public PageReference distan()
       {
       if(chooseList.size()==1)
       {
       String choose=chooseList[0];
       if(choose.contains('-'))
       {
       String[] splitS=choose.split('-');
       choose=splitS[0];
       }
       distanceMap.put(choose,dist);
       
       }
       return null;
       }
       public PageReference upFrom()
       {
       
       if(fromList.size()==1)
       {
       List<String> temp=new List<String>();
       temp.addAll(fromValues);
       for(Integer i=0;i<fromValues.size();i++)
       {
       if(fromValues[i]==fromList[0])
       {
       if(i==0)
       {
       fromValues.set(0,temp.get(fromValues.size()-1));
       fromValues.set((fromValues.size()-1),fromList[0]);
       }
       else
       {
       fromValues.set(i-1,fromList[0]);
       fromValues.set(i,temp.get(i-1));
       }
       break;
       }
       }
       }
       fromStationsList.clear();
       for(String sp:fromValues)
       {
       if(sp.contains('-'))
       {
       String[] s1=sp.split('-');
       fromStationsList.add(s1[0]);
       }
       else
       {
       fromStationsList.add(sp);
       }
       }
      // fromStationsList.addAll(fromValues);
       System.debug('................'+fromStationsList);
       return null;
       }
       public PageReference downFrom()
       {
       
       String s=fromList.get(0);
       
       if(fromList.size()==1)
       {
       List<String> temp=new List<String>();
       temp.addAll(fromValues);
       for(Integer i=0;i<fromValues.size();i++)
       {
       if(fromValues[i]==fromList[0])
       {
       Integer j=i;
       if((j+1)==fromValues.size())
       {
       fromValues.set(i,temp.get(0));
       fromValues.set(0,temp.get(i));
       }
       else
       {
       fromValues.set(i,temp.get(i+1));
       fromValues.set(i+1,temp.get(i));
       }
       break;
       }
       }
       }
       fromStationsList.clear();
       for(String sp:fromValues)
       {
       if(sp.contains('-'))
       {
       String[] s1=sp.split('-');
       fromStationsList.add(s1[0]);
       }
       else
       {
       fromStationsList.add(sp);
       }
       }
       //fromStationsList.addAll(fromValues);
       return null;
       }
       public PageReference upTo()
       {
       if(toList.size()==1)
       {
       List<String> temp=new List<String>();
       temp.addAll(toValues);
       for(Integer i=0;i<toValues.size();i++)
       {
       if(toValues[i]==toList[0])
       {
       if(i==0)
       {
       toValues.set(0,temp.get(toValues.size()-1));
       toValues.set((toValues.size()-1),toList[0]);
       }
       else
       {
       toValues.set(i-1,toList[0]);
       toValues.set(i,temp.get(i-1));
       }
       break;
       }
       }
       }
       toStationsList.clear();
       for(String sp:toValues)
       {
       if(sp.contains('-'))
       {
       String[] s1=sp.split('-');
       toStationsList.add(s1[0]);
       }
       else
       {
       toStationsList.add(sp);
       }
       }
       return null;
       }
       public PageReference downTo()
       {
       if(toList.size()==1)
       {
       List<String> temp=new List<String>();
       temp.addAll(toValues);
       for(Integer i=0;i<toValues.size();i++)
       {
       if(toValues[i]==toList[0])
       {
       Integer j=i;
       if((j+1)==toValues.size())
       {
       toValues.set(i,temp.get(0));
       toValues.set(0,temp.get(i));
       }
       else
       {
       toValues.set(i,temp.get(i+1));
       toValues.set(i+1,temp.get(i));
       }
       break;
       }
       }
       }
       toStationsList.clear();
       for(String sp:toValues)
       {
       if(sp.contains('-'))
       {
       String[] s1=sp.split('-');
       toStationsList.add(s1[0]);
       }
       else
       {
       toStationsList.add(sp);
       }
       }
       return null;
       }
       
       class TdetailsClass
       {
       public TdetailsClass(String fName,String tName,String arrT,String depT)
       {
       }
       }
       public PageReference showViewDetails()
       {
       displayView=true;
       stationCodes.clear();
       StationsMap.clear();
       frStList.clear();
       Map<String,String> toMap=new Map<String,String>();
       Map<String,String> chMap=new Map<String,String>();
       for(String chVaL:chooseValues)
       {
       if(chVal.contains('-'))
       {
       String[] spltS=chVal.split('-');
       chMap.put(spltS[0],spltS[1]);
       }
       chMap.put(chVal,'00:00'); 
       }
       for(String toVaL:toValues)
       {
       if(toVal.contains('-'))
       {
       String[] spltS=toVal.split('-');
       toMap.put(spltS[0],spltS[1]);
       }
       toMap.put(toVal,'00:00'); 
       }
       for(String frVal:fromValues)
       {
       
       String dep='00:00';
       String withChar='';
       if(frVal.contains('-'))
       {
       String[] spltS=frVal.split('-');
       frVal=spltS[0];
       dep=spltS[1];
       }
       String stCode=[select Code__c from City__c where name=:frVal limit 1].Code__c;
       System.debug('........stCode.....'+stcode);
       frStList.add(frVal);
       StationsMap.put(frVal,new stationsClass(stCode,toMap.get(frVal),dep,chMap.get(frVal),distanceMap.get(frVal)));
       }
       System.debug('.....stationsMap.....'+StationsMap);
       return null;
       }
       public PageReference closeViewDetails()
       {
       displayView=false;
       return null;
       }
       public PageReference saveTRDetails()
       {
       fromTo.clear();
       fromToMapList.clear();
       Map<String,String> chHaltMap=new Map<String,String>();
       
       for(String ch:chooseValues)
       {
       String haltTime='00:00';
       if(ch.contains('-'))
       {
       String[] spltH=ch.split('-');
       chHaltMap.put(spltH[0],spltH[1]);
       }
       chHaltMap.put(ch,haltTime);
       }
       for(String fr:fromValues)
       {
       Set<String> toListStations=new Set<String>();
       
       for(String to:toValues)
       {
       
       if(fr!=to)
       {
       toListStations.add(to);
       }
       
       }
       fromToMapList.put(fr,toListStations);
       
       }
       System.debug('......fromToMap...'+fromToMapList);
       for(String frKey:fromToMapList.keySet())
       {
       String dep='00:00';
       List<String> lst=new List<String>();
       lst.addAll(fromToMapList.get(frKey));
       if(frKey.contains('-'))
       {
       String[] splitF=frKey.split('-');
       dep=splitF[1];
       frKey=splitF[0];
       }
       
       
       for(String toStation:lst)
       { 
       String arr='00:00';
       if(toStation.contains('-'))
       {
       String[] splitT=toStation.split('-');
       arr=splitT[1];
       toStation=splitT[0];
       }
       if(frKey!=toStation)
       {
       
       Train__c t=new Train__c();
       t.name=trName;
       t.Train_No__c=Integer.valueOf(trNoNew);
       t.From__c=frKey;
       t.To__c=toStation;
       t.Arrival__c=arr;
       t.Departure__c=dep;
       t.Travel_Time__c='00:00';
       t.Halt_Time__c=chHaltMap.get(frKey);
       t.Route__c='0';
       t.Source__c=srcSet;
       t.Destination__c=destSet;
       Integer d=0;
       if((distanceMap.get(frKey))=='0')
       {
       d=Integer.valueOf(distanceMap.get(toStation));
       }
       else
       {
       d=(Integer.valueOf(distanceMap.get(toStation)))-(Integer.valueOf(distanceMap.get(frKey)));
       }
       t.Distance_KM__c=d;
       if(d>=0)
       {
       insert t;
       }
       System.debug('.....frkey..'+frKey+'....toStation.....'+toStation);
       }
       }
       }
       
     
      
       
       PageReference test =new PageReference('https://c.ap2.visual.force.com/apex/test3');
       return test;
       }
       public PageReference GetStateBoxs()
       {
       
       System.debug('......stateCnt..............'+stateCnt);
       stateBoxes.clear();
       stateBoxMap.clear();
       for(Integer i=1;i<=stateCnt;i++)
       {
       stateBoxes.add(i);
       stateBoxMap.put(i,'');
       }
     
       return null;
       }
       public PageReference GetCityFromStates()
       {
       List<String> cities=new List<String>();
       for(Integer key:stateBoxMap.keySet())
       {
       String state=stateBoxMap.get(key);
       if(state!=null && state!='')
       {
       id stId=[select id from State__c where name=:state limit 1].id;
       for(City__c ct:[select id,name from City__c where StateName__c=:stId])
       {
       cities.add(ct.name);
       }
       }
       cities.sort();
       availValues.clear();
       availValues.addAll(cities);
       }
       return null;
       }
     
       public PageReference SrcDestSet()
       {
       system.debug('......setSrcVal.............'+setSrcVal);
       system.debug('......setSrcVal1.............'+setSrcVal1);
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
       public PageReference SrcDestEdit()
       {
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
       public class stationsClass
       {
       public String stCode {get;set;}
       public String arrT {get;set;}
       public String depT {get;set;}
       public String halT {get;set;}
       public String dist {get;set;}
       public stationsClass(String stCode,String arrT,String depT,String halT,String dist)
       {
       this.stCode=stCode;
       this.arrT=arrT;
       this.depT=depT;
       this.halT=halT;
       this.dist=dist;
       }
       }
    //New Tab End....................
    public Date dat {get;set;}
    public List<string> villUnSel {get; set;}
    public List<string> villSel {get; set;}
    public List<string> schTDay {get; set;}
    public List<string> schDay {get; set;}
    public Integer noc {get; set;}
    public Train__c train { get; set; }
    public String cdate { get; set; }
    public Integer tENos { get; set; }
    public String tNos { get; set; }
    public String tText { get; set; }
    public String tEText { get; set; }
    public boolean ccAdd { get; set; }
    public boolean tEdit { get; set; }
    public boolean trI { get; set; }
    public boolean info { get; set; }
    public boolean tED { get; set; }
    public boolean alot { get; set; }
    public boolean ctView { get; set; }
    public boolean cHideVisib { get; set; }
    public boolean cOutHV { get; set; }
    public boolean knwSD { get; set; }
    public boolean knwTN { get; set; }
    public boolean tInfo { get; set; }
    public boolean trInfo { get; set; }
    public String knw { get; set; }
    public String type { get; set; }
    public String speed { get; set; }
    public String Tmins { get; set; }
    public String Thours { get; set; }
    public String Dmins { get; set; }
    public String Dhours { get; set; }
    public String Amins { get; set; }
    public String Ahours { get; set; }
    public String selectedVal { get; set; }
    public String sTName { get; set; }
    public String sTNo { get; set; }
    public String sTSource { get; set; }
    Public boolean schRend {get; set;}
    public List<selectOption> TrNos { get; set; }
    public List<selectOption> hrs { get; set; }
    public List<selectOption> mns { get; set; }
    public List<selectOption> hours { get; set; }
    public String srcText { get; set; }
    public String destText { get; set; }
    public String selClass { get; set; }
    public String tTTime { get; set; }
    public Integer tDist { get; set; }
    public String tArrv { get; set; }
    public String tDep { get; set; }
    public String fromText { get; set; }
    public String toText { get; set; }
    public Integer tNo { get; set; }
    public String tName { get; set; }
    public String coachCount { get; set; }
    public String newEditTName { get; set; }
    public Integer newEditTNo { get; set; }
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
    public List<WrapperAddStnList> wrapperAddStnList { get; set; }
    public List<WrapperTrainInfo> WrapperTrainInfo { get; set; }
    public List<WrapperCoachInfo> WrapperCoachInfo { get; set; }
    public List<WrapperTrainsInfo> wrapperTrainsInfo { get; set; }
    public List<String> weekDays= new List<String>{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'};
    public List<String> wDays { get; set; }
    public Map<String,String> runD { get; set; }
    public List<String> displayFieldLst= new List<String>{'tName', 'tNo', 'from1', 'dep', 'to','arr','distKm','tt'}; 
    public list<String> labelFieldLst= new list<String>{'Name', 'No', 'From', 'Departure', 'To','Arrival','Distance(KM)','Travel Time'};
    Date[] names = new Date[0];
    Set<string> leftvalues = new Set<string>();
    Set<string> rightvalues = new Set<string>(); 
    Set<string> villLeftValues = new Set<string>();
    Set<string> villRightValues = new Set<string>(); 
    public Map<String,WrapperAddStnList> addStn { get; set; }
    public String stnCode { get; set; }
    public String fromCityVal { get; set; }
    public String toCityVal { get; set; }
    public String fromCVal { get; set; }
    Public List<String> stCount {get; set;}
    public String selectedValue { get; set; }
    Public Map<String,String> stnCodeMap { get; set; }
    Public Map<String,String> stnFromMap { get; set; }
    Public Map<String,String> stnToMap { get; set; }
    Public Map<String,String> rtNoMap { get; set; }
    Public Map<String,String> depMap { get; set; }
    Public Map<String,String> arrMap { get; set; }
    Public Map<String,String> haltMap { get; set; }
    Public Map<String,String> distMap { get; set; }
    Public Map<String,String> dayCntMap { get; set; }
    Public Map<String,String> travMap { get; set; }
    Public Map<String,String> runsOnMap { get; set; }
    Public Map<Integer,String> tcD1 { get; set; }
    
    public Train_Details_contrl(ApexPages.StandardController controller) {
    //New Tab Initializations
    trainNos=new List<SelectOption>();
    trainNos.add(new SelectOption('0','none'));
    tNoRend=true;
    availStations=new List<SelectOption>();
    availCities=new List<SelectOption>();
    chooseList=new List<String>();
    availList=new List<String>();
    fromList=new List<String>();
    toList=new List<String>();
    arrList=new List<String>();
    depList=new List<String>();
    haltList=new List<String>();
    detailsMap=new Map<String,TdetailsClass>();
    fromTo=new Map<String,String>();
    val=new List<String>();
    fromStationsList =new List<String>();
    toStationsList =new List<String>();
    hrF='00';hrT='00';hrH='00';minF='00';minT='00';minH='00';
    arrTMap=new Map<String,String>();
    depTMap=new Map<String,String>();
    haltTMap=new Map<String,String>();
    displayView=false;
    stateBoxes=new List<Integer>();
    stateBoxMap=new Map<Integer,String>();
    statesView=0;
    runsMap=new Map<String,String>();
    dayNames=new List<String>();
    distanceMap=new Map<String,String>();
    fromToStationsMap=new Map<String,List<String>>();
    StationsMap=new Map<String,stationsClass>();
    stationCodes=new List<String>();
    fromValues=new List<String>();
    frStList=new List<String>();
    stateCnt=0;
    trNoNew='0';
    fromToMapList=new Map<String,Set<String>>();
    //New Tab End Intialization..................
    
    st=0;
    knwSD=true;
    wDays=new List<String>();
    runD=new Map<String,String>();
    for(Integer i=0;i<weekDays.size();i++)
    {
     wDays.add(weekDays[i]);
     rund.put(weekDays[i],'');
     dayNames.add(weekDays[i]);//New Tab.
     runsMap.put(weekDays[i],'');//New Tab.
    }
     
     wrapperTrainInfo=new List<WrapperTrainInfo>();
     wrapperTrainsInfo=new List<WrapperTrainsInfo>();
     wrapperCoachInfo=new List<WrapperCoachInfo>();
     addStn=new Map<String,WrapperAddStnList>();
     TrNos=new List<SelectOption>();
     TrNos.add(new SelectOption('none','none'));
     stCount=new List<String>();
      stnCodeMap =new Map<String,String>();
      stnFromMap =new Map<String,String>();
      stnToMap =new Map<String,String>();
      
      rtNoMap =new Map<String,String>();
      depMap =new Map<String,String>();
      arrMap =new Map<String,String>();
      haltMap =new Map<String,String>(); 
      distMap =new Map<String,String>();
      dayCntMap =new Map<String,String>();
      travMap =new Map<String,String>();
      runsOnMap =new Map<String,String>();
      hours=new List<selectOption>();
      hrs=new List<selectOption>();
    for(integer i=0;i<24;i++)
    {
    
    
    if(i<10)
    {
     String hr='0'+i+':00Hr';
     hours.add(new Selectoption(hr,hr));
    hrs.add(new selectOption('0'+String.valueOf(i),'0'+String.valueOf(i)));
    }
    else
    {
    String hr=i+':00Hr';
     hours.add(new Selectoption(hr,hr));
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
    villUnSel = new List<String>();
    villSel = new List<String>();
    leftvalues.addAll(weekDays);
    
     
    }
    public PageReference GetSchInF() 
    {
    System.debug('.............selectedValue..............'+selectedValue);
    String[] sts=selectedValue.split('/');
    schRend=true;
    sTNo=sts[0];
    sTName=sts[1];
    sTSource=sts[2];
    return null;
    }
    //Get coaches for new
    public PageReference GetCoachCnt() 
    {
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
    Public PageReference GetCityInfo() 
    {
    
    if(fromText!='' && toText!='')
    {
    if(fromText!=null && toText!=null)
    {
    ctView=true;
    //List<String> vill=new List<String>();
    String stat1=[select State__c from Cities__c where name=:fromText limit 1].State__c;
    String stat2=[select State__c from Cities__c where name=:toText limit 1].State__c;
    Set<String> stat=new Set<String>();
    stat.add(stat1);
    stat.add(stat2);
    if(stat1==stat2)
    {
    for(Village__c v:[select name from Village__c where State__c=:stat1])
    {
    villLeftValues.add(v.name);
    }
    }
    else
    {
    for(Village__c v:[select name from Village__c where State__c=:stat])
    {
    villLeftValues.add(v.name);
    }
    }
    System.debug('........vill..........name............'+villLeftValues);
    }
    }
    else if(fromText=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose From'));
    }
    else if(toText=='')
    {
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please choose To'));
    }
    
    return null;
    }
    public PageReference trainNos() {
    System.debug('..........cghoose................');
    
    TrNos.add(new SelectOption('new','new'));
        return null;
    }
    Public Pagereference BySrcDest()
    {
    trInfo=true;
    wrapperTrainInfo.clear();
     Map<Integer,String> tcD;
     
     system.debug('.......srcText..........'+srcText+'........destText..........'+destText);
    for(Train__c INF:[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Schedule__c from Train__c where From__c='VISHAKHAPATNAM' and To__c='SECUNDERABAD'])
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
    System.debug('........wrapperTrainsInfo.........'+wrapperTrainsInfo);
    return null;
    }
    Public Pagereference knowsSDTN()
    {
    system.debug('.........knw...........'+knw);
    if(knw=='1')
    {
    knwSD=true;
    knwTN=false;
    tInfo=false;
    }
    if(knw=='2')
    {
    knwTN=true;
    knwSD=false;
    trInfo=false;
    }
    return null;
    }
    public Integer st {get; set;}
    Public Pagereference delStations()
    {
    String delR=Apexpages.currentPage().getParameters().get('delR');
      stCount.remove(Integer.valueOf(delR)-1);
      stnCodeMap.remove(delR);
      stnFromMap.remove(delR);
      stnToMap.remove(delR);
      rtNoMap.remove(delR);
      depMap.remove(delR);
      arrMap.remove(delR);
      haltMap.remove(delR);
      distMap.remove(delR);
      dayCntMap.remove(delR);
      travMap.remove(delR);
      runsOnMap.remove(delR);
      st--;
    return null;
    }
    Public Pagereference neweditTrain1()
    {
    newEditTName='';
    newEditTNo=0;
    return null;
    }
    Public Pagereference neweditTrain()
    {
    System.debug('........newEditTName..........'+newEditTName);
    List<Train__c> tr=[select id,Train_No__c from Train__c where name=:newEditTName];
    if(tr.size()>0 || tr!=null)
    {
    for(Integer t=0;t<tr.size();t++)
    {
    newEditTNo=Integer.valueOf(tr[t].Train_No__c);
    }
    }
    else 
    {
    newEditTNo=0;
    }
    return null;
    }
    Public Pagereference SaveStations()
    {
    return null;
    }
    Public Pagereference addStations()
    {
    st++;
    String stt=String.valueOf(st);
      stCount.add(stt);
      stnCodeMap.put(stt,'');
      stnFromMap.put(stt,'');
      stnToMap.put(stt,'');
      rtNoMap.put(stt,'');
      depMap.put(stt,'');
      arrMap.put(stt,'');
      haltMap.put(stt,'');
      distMap.put(stt,'');
      dayCntMap.put(stt,'');
      travMap.put(stt,'');
      runsOnMap.put(stt,'');
    cHideVisib=true;
    
    addStn.put(String.valueOf(st),new WrapperAddStnList(st,stnCode,fromCityVal,toCityVal));
    return null;
    }
    Public PageReference GetStnInfo() 
    {
    cOutHV=true;
    cHideVisib=false;
    fromCVal=fromCityVal;
    stnCode=[select Station_Code__c from Train__c where From__c=:fromCityVal].Station_Code__c;
    return null;
    }
    Public PageReference GetTrsInfo() 
    {Map<String,Integer> tcD=new Map<String,Integer>();
      tInfo=true;
      List<Train__c> infs=new List<Train__c>();
      List<Train_Coach_Details__c> coachInfs=new List<Train_Coach_Details__c>();
      wrapperTrainInfo.clear();
      wrapperCoachInfo.clear();
      Set<String> trName=new Set<String>();
      if(tText!=null && Integer.valueOf(tNoS)>0)
      {
      infs=[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c,Day_Count__c,Halt_Time__c,Route__c,Station_Code__c from Train__c  where name=:tText and Train_No__c=:Integer.valueOf(tNoS) order by Distance_KM__c];
      coachInfs=[select id,name,Coach_Name__c,Coach_Category__c,Coache_Seats__c from Train_Coach_Details__c where name=:tText and Train_No__c=:Integer.valueOf(tNoS)];
      }
      
        for(Train__c inf:infs)
        {
      
    if(inf.To__c==null)
    {
        wrapperTrainInfo.add(new WrapperTrainInfo(inf.Station_Code__c,inf.From__c,inf.Route__c,inf.Arrival__c,inf.Departure__c,inf.Halt_Time__c,Integer.valueOf(inf.Distance_KM__c),Integer.valueOf(inf.Day_Count__c)));
     }   
        }
    for(Train_Coach_Details__c cInf:coachInfs)
    {
    wrapperCoachInfo.add(new WrapperCoachInfo(cInf.Coach_Name__c,cInf.Coach_Category__c,Integer.valueOf(cInf.Coache_Seats__c)));
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
      tc.Train_No__c=tNo;
      insert tc;
      }
       PageReference entryPage = new PageReference('https://c.ap2.visual.force.com/apex/test3');
        entryPage.setRedirect(true);
      return entryPage;
    } 
    Public List<SelectOption> getfromStnList()
    {
     List<SelectOption> options = new List<SelectOption>();
     for(Cities__c c:[select name from Cities__c])
     {
     options.add(new SelectOption(c.name,c.name));
     }
     return options;
    }
    Public List<SelectOption> gettoStnList()
    {
     List<SelectOption> options = new List<SelectOption>();
     for(Cities__c c:[select name from Cities__c])
     {
     options.add(new SelectOption(c.name,c.name));
     }
     return options;
    }
    Public List<SelectOption> getunschDayvalues()
    {
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(leftvalues);
        //tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }
    Public List<SelectOption> getunVillSelValues()
    {
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(villLeftValues);
        //tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }
    public List<SelectOption> getVillSelValues(){
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(villRightValues);
        //tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
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
    Public PageReference selectVillclick(){
        villSel.clear();
        for(String s : villUnSel){
            villLeftValues.remove(s);
            villRightValues.add(s);
        }
        return null;
    }
    public PageReference unselectVillclick(){
        villUnSel.clear();
        for(String s : villSel){
            villRightValues.remove(s);
            villLeftValues.add(s);
        }
        return null;
    }
    public PageReference chooseTrainNos(){
       tInfo=true;
       TrNos.clear();
       TrNos.add(new SelectOption('0','none'));
       for(Train__c tc:[select id,Train_No__c from Train__c where name=:tText])
       {
       TrNos.add(new SelectOption(String.valueOf(tc.Train_no__c),String.valueOf(tc.Train_no__c)));
       }
       
        return null;
    }
    //autopopup text
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
      //Wrapper class for get
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
      //Wrapper class for get
      class WrapperAddStnList
        {
        public integer sno { get; set; }
        public String stnCode { get; set; }
        public String fromC { get; set; }
        public String toC { get; set; }
        
        public WrapperAddStnList(Integer sno,String stnCode,String fromC,String toC)
        {
        this.sno=sno;
        this.stnCode=stnCode;
        this.fromC=fromC;
        this.toC=toC;
        }
        }  
      class WrapperCoachInfo
        {
        public String cName { get; set; }
        public String category { get; set; }
        public Integer seats { get; set; }
        
        
        public WrapperCoachInfo(String cName,String category,Integer seats)
        {
        this.cName=cName;
        this.category=category;
        this.seats=seats;
        }
        }  
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
        class newTrainWrapperClass
        {
        public newTrainWrapperClass()
        {
        }
        }     
}