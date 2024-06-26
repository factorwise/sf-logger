public class SalesforceLimitsInfo {
    public static String getLimitsInfo() {
        Map<String, Object> limitsMap = new Map<String, Object>();

        // Retrieve limits information
        limitsMap.put('AsyncCalls', Limits.getLimitAsyncCalls());
        limitsMap.put('Callouts', Limits.getLimitCallouts());
        limitsMap.put('DmlRows', Limits.getDmlRows());
        limitsMap.put('DmlStatements', Limits.getDmlStatements());
        limitsMap.put('EmailInvocations', Limits.getEmailInvocations());
        limitsMap.put('FutureCalls', Limits.getFutureCalls());
        limitsMap.put('HeapSize', Limits.getHeapSize());
        limitsMap.put('QueueableJobs', Limits.getQueueableJobs());
        limitsMap.put('SoqlQueries', Limits.getQueries());
        limitsMap.put('SoqlQueryRows', Limits.getQueryRows());
        limitsMap.put('CpuTime', Limits.getCpuTime());
        limitsMap.put('PublishImmediateDml', Limits.getPublishImmediateDML());
        
        // Convert map to JSON string
        String limitsJson = JSON.serialize(limitsMap);

        return limitsJson;
    }
}