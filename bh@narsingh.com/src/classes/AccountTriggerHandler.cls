public class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> accs)
    {
        List<Account> accList=new List<Account>();
        for(Account ac:accs)
        {
            ac.ShippingState=ac.BillingState;
            accList.add(ac);
        }
       insert accList;
           
    }
}