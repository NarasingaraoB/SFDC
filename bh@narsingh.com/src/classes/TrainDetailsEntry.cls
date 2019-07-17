global class TrainDetailsEntry {
public boolean displayPopup {get; set;}
public boolean displayPopup1 {get; set;}
public boolean nw {get; set;}
public String tnameE {get; set;}
public String tnameN {get; set;}
public String tnoE {get; set;}
public String tnoN {get; set;}
    public TrainDetailsEntry()
    {
    displayPopup1=true;
    nw=true;
    }
    public void closePopup() {
        displayPopup = false;
        displayPopup1 = true;
        nw=true;
        tnameN=tnameE;
        tnoN=tnoE;
    }
    public void clearPopup() {
        displayPopup = false;
        displayPopup1 = true;
        nw=true;
        tnameN='';
        tnoN='';
    }
    public void showPopup() {
        displayPopup = true;
        displayPopup1 = false;
        nw=false;
        tnameE='';
        tnoE='';
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
}