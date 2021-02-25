/**
	* This class is main bridge between Salesforce Org and DevOps Framework.
	* This class retrieves Metadata from Org and show it on User Story.
*/
public with sharing class RetrieveMetadata {
    /**
        * This method wraps all the Metadata available in org. 
        * return: list of all Metadata.
    */
    @AuraEnabled(cacheable=true)
    public static List<MetadataWrapper> getAllMetadata() {
        List<MetadataWrapper> mw = new List<MetadataWrapper>();
        List<ApexClass> classes = getApexClasses(10) ;
        List<ApexTrigger> triggers = getApexTriggers(10);
        List<EmailTemplate> emailTemplates = getEmailTemplate(10);
        List<ApexPage> pages = getApexPages(10);
        for(ApexClass ac : classes) {
            mw.add(new MetadataWrapper(ac.Name,'Apex Class'));
        }
        for(ApexTrigger at : triggers) {
            mw.add(new MetadataWrapper(at.Name,'Apex Trigger'));
        }
        for(ApexPage ap : pages) {
            mw.add(new MetadataWrapper(ap.Name,'Apex Page'));
        }
        for(EmailTemplate et : emailTemplates) {
          mw.add(new MetadataWrapper(et.Name,'Email Template'));
        }
        
        return mw;
    }
    
    /**
        * This method retrieves all the apex classes available in org. 
        * return: list of all apex classes.
    */
    private static List<ApexClass> getApexClasses(Integer dlimit) {
        return [select ApiVersion, Body, BodyCrc, CreatedById, CreatedDate, Id, IsValid, LastModifiedById, 
                LastModifiedDate, LengthWithoutComments, Name, NamespacePrefix, Status, SystemModstamp 
                from ApexClass LIMIT : dlimit];
    }
    /**
        * This method retrieves all the apex triggers available in org. 
        * return: list of all apex triggers.
    */
    private static List<ApexTrigger> getApexTriggers(Integer dlimit) {
        return [select ApiVersion, Body, BodyCrc, CreatedById, CreatedDate, Id, IsValid, LastModifiedById, 
                LastModifiedDate, LengthWithoutComments, Name, NamespacePrefix, Status, SystemModstamp 
                from ApexTrigger LIMIT : dlimit];
    }
    /**
        * This method retrieves all the apex pages available in org. 
        * return: list of all apex pages.
    */
    private static List<ApexPage> getApexPages(Integer dlimit) {
        return [select Id,  Name from ApexPage LIMIT : dlimit];
    }
    /**
        * This method retrieves all the email templates available in org. 
        * return: list of all email templates.
    */
    private static List<EmailTemplate> getEmailTemplate(Integer dlimit) {
        return [select Description, Name, Subject from EmailTemplate LIMIT : dlimit];
    }
    
    /**
        * This method retrieves all the Lightning Components available in org. 
        * return: list of all Lightning Components.
    */
    @AuraEnabled(cacheable=true)
    public static Object getLightningComponents(){
        HttpRequest req = new HttpRequest();
        Http h = new Http();
        req.setEndpoint('callout:MetadataFetching/services/data/v50.0/tooling/query/?q=SELECT+Id+FROM+LightningComponentBundle');
        req.setMethod('GET');
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId() );  
        req.setHeader('Content-Type', 'application/json');
        HttpResponse res = h.send(req);
        if(res.getStatusCode() == 302) {
            req.setEndpoint(res.getHeader('Location'));
            res = new Http().send(req);
        }
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        //String accountsJSON = JSON.createGenerator(jsonString)
        return results.get('records');
    }
}