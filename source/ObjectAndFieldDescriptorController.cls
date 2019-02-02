public class ObjectAndFieldDescriptionController {
    
    @AuraEnabled
    public static List<wrapperObjectDetail> fetchWrapperObjectDetail(){
        List<wrapperObjectDetail> listWrapperObjectDetails = new List<wrapperObjectDetail>();
        Map<String, Schema.SObjectType> mapGlobalDescribe = Schema.getGlobalDescribe();
        for(String objName : mapGlobalDescribe.KeySet()){
            listWrapperObjectDetails.add(new wrapperObjectDetail(objName, String.valueOf(mapGlobalDescribe.get(objName))));
        }
        return listWrapperObjectDetails;
    }
    
    @AuraEnabled
    public static List<wrapperFieldList> fetchObjectDetails(String nameObj){
        if(nameObj != Null && !String.isEmpty(nameObj) && Schema.getGlobalDescribe().containsKey(nameObj)){
            Map<String, Schema.SObjectField> mapSObjectField = Schema.getGlobalDescribe().get(nameObj).getDescribe().fields.getMap();
            if(mapSObjectField != Null){
                List<wrapperFieldList> lstWrapperFieldList = new List<wrapperFieldList>();
            	for(Schema.SObjectField objField : mapSObjectField.Values()){
                    Schema.DescribeFieldResult fieldDescribe = objField.getDescribe();
            		lstWrapperFieldList.add(new wrapperFieldList(fieldDescribe.getLabel(),fieldDescribe.getName(), String.valueOf(fieldDescribe.getType()) ,fieldDescribe.isCustom()));
            	}
                return lstWrapperFieldList;
            }
        }
        	
        return null;
    }
    
    public class wrapperObjectDetail{
        @AuraEnabled public String objectLabel;
        @AuraEnabled public String objectAPIName;
        public wrapperObjectDetail(String objectLabel, String objectAPIName){
            this.objectLabel = objectLabel;
            this.objectAPIName = objectAPIName;
        }
    }
    public class wrapperFieldList{
        @AuraEnabled public String fieldLabel;
        @AuraEnabled public String fieldAPIName;
        @AuraEnabled public boolean isCustom;
        @AuraEnabled public String dataType;
        
        public wrapperFieldList(String fieldLabel, String fieldAPIName, String dataType, boolean isCustom){
            this.fieldLabel = fieldLabel;
            this.fieldAPIName = fieldAPIName;
            this.dataType = dataType;
            this.isCustom = isCustom;
        }
    }
}