public with sharing class ReassignLeads {
    @future
    public static void futureLeadReassign(Set<ID> lIdReassignSet) {
AssignmentRule AR = new AssignmentRule();
AR = [select id from AssignmentRule where SobjectType = 'Lead' and name='test' and Active = true limit 1];
        System.debug('......AR........'+AR);
      List<Lead> lUpdList = [SELECT Id FROM Lead WHERE Id IN: lIdReassignSet];
      for (Lead l:lUpdList){
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule  = false;
        dmo.assignmentRuleHeader.assignmentRuleId= AR.id;
        l.setOptions(dmo);
      }

      update(lUpdList);
    }
}