trigger applyDiscountOnBook on Book__c (before insert) {
      
       for(Book__c b:trigger.new)
       {
       b.Price__c=b.Price__c*0.9;
       if(b.Price__c>50)
       {
       b.Price__c.addError('please enter bleow 50');
       
       }
       }
}