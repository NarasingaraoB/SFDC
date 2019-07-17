public class SearchController {
 @AuraEnabled
 public static  List<sObject> fetchLookUpValues(String searchKeyword,String objectName)
 {
     system.debug('.##searchKeyword'+searchKeyword);
     system.debug('.##objectName'+objectName);
     String searchKey=searchKeyword+'%';
     String query='select id from '+objectName+' where Name Like:searchKey order by createddate desc limit 5';
     system.debug('.##query'+query);
     return Database.query(query);
 }
}