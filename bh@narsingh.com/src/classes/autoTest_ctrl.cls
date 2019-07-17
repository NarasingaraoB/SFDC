global class autoTest_ctrl {
public autoTest_ctrl()
{
 
}
@RemoteAction
    global static SObject[] findSObjects(string obj, string qry, string addFields, string profilename) 
    {
        /* More than one field can be passed in the addFields parameter
           Split it into an array for later use */
        List<String> fieldList=new List<String>();
     
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
        String soql = 'SELECT   SLA__c';
        
      
       
        
        /* Adding the object and filter by name to the soql */
        soql += ' from ' + obj + ' where    SLA__c' + filter;
        
       
        
        soql += ' order by Name limit 20';
        
        system.debug('Qry: '+soql);
        
        List<sObject> L = new List<sObject>();
        List<sObject> M = new List<sObject>();
        Map<String,String> mm=new Map<String,String>();
        Set<String> N = new Set<String>();
        try 
        {
            L = Database.query(soql);
            System.debug('....s...........s........s........'+L);
            for(sObject s:L)
            {
            
            String Name = (String) s.get('SLA__c');
           
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
         System.debug('.........m.............m.............m...........'+M);
        return M;
       
   }

}