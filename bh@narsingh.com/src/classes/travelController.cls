global class travelController {

    public PageReference GetTrainDetails() {
    
     wrapperInfo.clear();
    for(Train__c inf:[select id,name,Train_No__c,From__c,Departure__c,To__c,Arrival__c,Distance_KM__c,Travel_Time__c from Train__c where From__c=:fromText and To__c=:toText])
    {
    //List<Train_Coach_Details__c> tcDetails=[select Coach_Category__c from Train_Coach_Details__c where name=:inf.name];
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
        return null;
    }


    public Date dat {get;set;}
    public String soqlQuery { get; set; }
     public List<WrapperInfo> wrapperInfo { get; set; }
    public PageReference buildQueryString() {
        return null;
    }


    public String chDate { get; set; }

    public String toText { get; set; }
    public String fromText { get; set; }

    public travelController()
    {
   wrapperInfo=new List<WrapperInfo>();
    }
    public  String GetResourceURL(String resourceName){

            // Fetching the resource
            List<StaticResource> resourceList= [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :resourceName];

            // Checking if the result is returned or not
            if(resourceList.size() == 1){

               // Getting namespace
               String namespace = resourceList[0].NamespacePrefix;
               // Resource URL
               return '/resource/' + resourceList[0].SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName; 
            }
            else return '';
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
}