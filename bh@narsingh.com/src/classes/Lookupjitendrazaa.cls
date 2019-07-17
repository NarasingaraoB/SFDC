public class Lookupjitendrazaa {
@AuraEnabled
    public static List<SObject> searchDB(String ObjectName,String field_API_text,string field_API_value,string field_API_search,String searchText,Integer lmt)
    {
        List < sObject > returnList = new List < sObject > ();
        String filter = ' like \'%' + String.escapeSingleQuotes(searchText) + '%\'';
        String query='select '+field_API_text+','+field_API_value+' from '+ObjectName+' where '+field_API_search+' '+filter+' limit '+lmt;
        system.debug('..query.'+query);
        List < sObject > lstOfRecords = Database.query(query);
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        system.debug('..returnList'+returnList);
        return returnList;
    }
}