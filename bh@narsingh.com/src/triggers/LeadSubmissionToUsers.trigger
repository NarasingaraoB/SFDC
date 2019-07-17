trigger LeadSubmissionToUsers  on Lead(after update) {
Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Lead.getRecordTypeInfosById();
set<Id> leads=new set<Id>();
  for (Lead newLead : Trigger.new) {  
  Integer usrAssign;
  usrAssign= math.mod(1,2);
  if(rtmap.get(newLead.RecordTypeId).getName().containsIgnoreCase('US'))
  {
  leads.add(newLead.id);
   
  }
  if(rtmap.get(newLead.RecordTypeId).getName().containsIgnoreCase('International'))
  {
    leads.add(newLead.id);
  }
  
  System.debug('.........newLead..................'+newLead.RecordTypeId);
  
  }
   if (leads.size() > 0) {
        // This is the Fix
        ReassignLeads.futureLeadReassign(leads);
    }
}