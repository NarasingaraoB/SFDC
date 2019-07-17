trigger aok on Attachment (after insert, after update) {
ID aokId; 

    list<FeedItem> listOfFeedFiles = new List<FeedItem>(); 
 
    if(Trigger.isAfter){
     
        for(Attachment attachment : trigger.new) {
          if(attachment.ParentId.getSObjectType() != AOK__c.SObjectType)
          {
              string checkIfCase = string.valueof(attachment.Description);
          
            //Adding a Content post
            aokId = attachment.ParentId;
            FeedItem post = new FeedItem();
            post.ParentId = aokId;
            post.Body = 'Attachment added';
            post.Type = 'ContentPost';
            post.ContentData = attachment.body;
            post.ContentFileName = attachment.Name;
            post.Title = attachment.Name;
            insert post;   
               post = [SELECT Id, ParentId, Type, Title, Body, LinkUrl, RelatedRecordId FROM FeedItem Where Type = 'ContentPost' And ParentId =: aokId Order by Createddate desc limit 1];
            
            System.debug('post:::'+post);
              
               ContentVersion cv = [SELECT Id,ContentModifiedDate,ContentDocumentId FROM ContentVersion WHERE Id = :post.RelatedRecordId];
            System.debug('cv:::'+cv);

            ContentDistribution cd = new ContentDistribution();
            cd.Name = post.Title + ' ' + System.today().format();
            cd.ContentVersionId = cv.Id;
            //cd.ContentDocumentId = cv.ContentDocumentId;
            cd.PreferencesNotifyOnVisit = false;
            cd.PreferencesAllowOriginalDownload = true;
            cd.PreferencesLinkLatestVersion = true;
            cd.PreferencesAllowViewInBrowser = true;
            insert cd;

            cd = [SELECT Id, Name, ContentVersionId, ContentDocumentId, PreferencesAllowOriginalDownload, PreferencesLinkLatestVersion, PreferencesAllowViewInBrowser, ViewCount, DistributionPublicUrl FROM ContentDistribution WHERE Id = :cd.Id];

            System.debug('cd:::'+cd);
            AOK__c a =  new AOK__c (Share_via_Link__c = cd.DistributionPublicUrl, Has_Attachment_s__c = true, Send_Approval__c = true);
            insert a;   
                 
          }
        }
    }
}