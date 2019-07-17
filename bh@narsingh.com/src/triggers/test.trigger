trigger test on Contact (after update) {
 if (!classForRecursiveTrigger.hasAlreadyCreatedFollowUpTasks()) {
List<Contact> ct=new List<Contact>();
List<String> contactEmails = new List<String>();
List<Contact> con=new List<Contact>();
for (Contact contact : Trigger.new)
      {
         
            contactEmails.add(contact.Email);       
         
      }
    ct=  [SELECT Id,email FROM Contact WHERE email in :contactEmails];
    if(ct.size() > 0)
      {
         for(Contact contact : ct )
         {
           contact.email = 'Yes@gmail.com';
           con.add(contact);
         }          
        
      }
      classForRecursiveTrigger.setAlreadyCreatedFollowUpTasks();
       update con;
      }
}