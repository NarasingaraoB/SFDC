public with sharing class LookupMainController 
{
    public String accountName {get; set;}
    public Id accountId {get; set;}
    public List<Contact> contacts {get;set;}
    
    public PageReference findContacts()
    {
        if (null!=accountId)
        {
           contacts=[select id,FirstName, LastName from Contact where AccountId=:accountId];
        }
        
        return null;
    }
}