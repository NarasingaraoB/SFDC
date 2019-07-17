public class fetchRecordDetails {
    @AuraEnabled
    public static List<contact> fetchData()
    {
        return [select Id, name, Account.name, Email from contact limit 10];         
    }
}