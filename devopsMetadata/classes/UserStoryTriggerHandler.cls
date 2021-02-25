public class UserStoryTriggerHandler {
    public static void updateTargetOrg(List<User_Story__c> userStories) {
        for(User_Story__c userStory : userStories) {
            List<Pipeline_Connection__c> connections = [select Id,Source_Environment__c,Destination_Environment__c from Pipeline_Connection__c where Pipeline__c =: userStory.Project__r.Pipeline__r.Id];
            for(Pipeline_Connection__c connection : connections) {
                if(connection.Source_Environment__c == userStory.Source__c) {
                    userStory.Target__c = connection.Destination_Environment__c;
                    break;
                }
            }
        }
    }
}