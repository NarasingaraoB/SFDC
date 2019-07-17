public with sharing class LookupPopupController 
{
    public String query {get; set;}
    public List<Account> accounts {get; set;}
    String obj='Account';
    public PageReference runQuery()
    {
      String filter = ' like \'%' + String.escapeSingleQuotes(query) + '%\'';
      String soql = 'SELECT  SLA__c,name';
        soql += ' from ' + obj + ' where    SLA__c' + filter;
        soql += ' order by Name limit 20';
       system.debug('Qry: '+soql);
      accounts=Database.query(soql);
    System.debug('...........query............................'+query);
       // List<List<Account>> searchResults=[FIND :query IN ALL FIELDS RETURNING Account (id, name, billingstreet, billingcity, billingpostalcode)];
      
       // accounts=searchResults[0];
         System.debug('.............accounts..........................'+accounts);
        return null;
    }
}