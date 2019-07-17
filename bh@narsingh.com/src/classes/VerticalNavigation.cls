public class VerticalNavigation {

    @AuraEnabled
    public static List<Account> AccountList()
    {
       List<Account> acList=new List<Account>();
        acList=[select id,Name from Account];
        system.debug('..acList..'+acList);
        return acList;
    }
}