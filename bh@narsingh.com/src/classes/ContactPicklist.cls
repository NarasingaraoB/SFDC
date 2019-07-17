public class ContactPicklist {
@AuraEnabled
    public static Map<String, String> pickList()
    {
        Map<String, String> pickMap=new Map<String, String>();
        Schema.DescribeFieldResult conFields=Contact.LeadSource.getDescribe();
        List<Schema.PicklistEntry> conPicvals=conFields.getPickListValues();
        
        for(Schema.PicklistEntry p:conPicvals)
        {
           pickMap.put(p.getLabel(),p.getValue()); 
        }
        return pickMap;
    }
}