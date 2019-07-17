public with sharing class AccountJSONCreator {
public String getJSON()
    {
String AccountName = Apexpages.currentPage().getParameters().get('AccName');
        List<AccountWrapper> wrp = new List<AccountWrapper>();
        for (Cities__c a : [Select a.Id,a.name
                            From
                                Cities__c a
                            WHERE name Like : '%'+AccountName+'%' ]) {
               AccountWrapper w = new AccountWrapper (a.name);
               wrp.add(w);
            }
        return JSON.serialize(wrp);
    }
    
    public class AccountWrapper
    {
        String AccName;

        public AccountWrapper(String aName)
        {
            AccName = aName;
            
        }
    }

}