/**
	* This class is used to generate dataset for lwc charts.
*/
public class LwcChartController {
	@AuraEnabled(cacheable=true)
    public static List<DataSet> getProjectSprints(String projectId){
        DateTime todayDate ;
        Timezone tz = Timezone.getTimeZone('America/Los_Angeles');
        Datetime pst_Date = DateTime.newInstance(System.Now().getTime() + tz.getOffset(System.Now()));
        todayDate = pst_Date.date().addDays(-1);
        
        List<Sprint__c> sprints =  [SELECT Name,Progress__c,Status__c  FROM Sprint__c WHERE Project__c =: projectId];
        List<DataSet> dataSet = new List<DataSet>();
        for(Sprint__c sprint : sprints){
            String name =  (String)sprint.get('Name') ;
            //String status =  (String)sprint.get('Status__c') ;
            Decimal total =  (Decimal)sprint.get('Progress__c') ;
            dataSet.add(new DataSet(name,total));
        }
        System.debug('dataSet'+dataSet);
        return dataSet ;
    }
    
    public class DataSet{
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public String status {get;set;}
        @AuraEnabled
        public Decimal count {get;set;}
        
        public DataSet(String label,Decimal count){
            this.label  = label ;
            this.count = count ;
        }
        public DataSet(String label,Decimal count,String status){
            this.label  = label ;
            this.count = count ;
            this.status = status;
        }
    }
}