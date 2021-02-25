@isTest
public without sharing class TestDataFactory {
    public Orgs__c source{get;set;}
    public Orgs__c target{get;set;}
    public User_Story__c userStory{get;set;}
    public TestDataFactory() {
        source = new Orgs__c();
        source.Name = 'Dev1';
        source.Org_Type__c = 'Sandbox';
        insert source;
        target = new Orgs__c();
        target.Name = 'UAT';
        target.Org_Type__c = 'Sandbox';
        insert target;
        userStory = new User_Story__c();
        userStory.User_Story_Name__c = 'Test';
        userStory.Source__c = source.Id;
        userStory.Target__c = target.Id;
        insert userStory;
    }
}