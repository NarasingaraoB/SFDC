@isTest
public class applyDiscountOnBookTest {
public static testMethod void test1()
{
    try{
        
     Book__c b=new Book__c(name='java',Price__c=100);
    insert b;
    System.debug('.......b.............'+b);
   // Book__c bk=[select name,Price__c from Book__c where name='java'];
   // System.debug('.....bk.....'+bk);
   b.Price__c=b.Price__c*0.9;
    update b;
    system.assertEquals(90, b.Price__c);
    }
	catch(Exception e)
    {
        System.debug('.........e..........'+e.getMessage());
        system.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, please enter bleow 50: [Price__c]', e.getMessage());
    }
}
}