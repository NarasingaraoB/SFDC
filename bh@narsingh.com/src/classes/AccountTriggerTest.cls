@isTest
public class AccountTriggerTest {
@isTest static void testAcc()
{
    List<Account> accList=new List<Account>();
    for(integer i=0;i<200;i++)
    {
        Account acc=new Account(Name='Test Acc'+i,BillingState='CA');
        accList.add(acc);
    }
    
    System.test.startTest();
    insert accList;
    System.test.stopTest(); 
    List<Account> accs=[select id,ShippingState from Account];
    System.assertEquals(200, accs.size());
    System.assertEquals('CA', accs[0].ShippingState);
}
}