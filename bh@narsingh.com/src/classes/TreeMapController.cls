public class TreeMapController {
	 @AuraEnabled
    public static List<Contact> initData(String recordID)
    {
        system.debug('..#recordID..'+recordID);
        String query = 'Select id,(select Id, name, Account.name, Email,TreeMapNumber__c from Contacts) From Account WHERE id = :recordID';
        List<Account> accList= Database.query(String.escapeSingleQuotes(query));
        List<Contact> conList=accList[0].Contacts;
        
       return conList; 
    }
}