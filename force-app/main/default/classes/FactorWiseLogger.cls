public class FactorWiseLogger {

    private static FactorWiseLogger instance;

    private static final Integer LIMITS_MARGIN = 3;

    static final Integer DEFAULT_LEVEL = FactorWiseLogLevel.INFO_LEVEL;

    private static List<FactorWiseLog__e> logsToFlush = new List<FactorWiseLog__e>();


    static Quiddity currentQuiddity;
    static String transactionId = UUID.randomUUID().toString();
    String className;
    Integer currentLevel;

    static {
        try {
            Request reqInfo = Request.getCurrent();
            String currentRequestId = reqInfo.getRequestId();
            currentQuiddity = reqInfo.getQuiddity();         
        } catch(Exception e) {
            System.debug('FactorWiseException:: ' + e);
        }
    }

    private FactorWiseLogger() {
        this.currentLevel = DEFAULT_LEVEL; // Hardcodd for now. Read from custom metadata
    }

    public void setLevel(Integer level) {
        this.currentLevel = level;
    }

    public static FactorWiseLogger getLogger() {
        if(instance == null) {
            instance = new FactorWiseLogger();
        }
        return instance;
    }

    public static void flush() {

        if(Limits.getLimitPublishImmediateDML() - Limits.getPublishImmediateDML() == LIMITS_MARGIN) {
            return;
        }

        if(Limits.getLimitPublishImmediateDML() - Limits.getPublishImmediateDML() == (LIMITS_MARGIN + 1)) {
            FactorWiseLogger.getLogger().logWarn('Limits approaching: last flush');
        }

        if(logsToFlush.size() > 0) {
            EventBus.publish(logsToFlush);
            logsToFlush.clear();
        }
    
    }

    private void pushEventCommon(FactorWiseLog__e log) {
        log.transactionId__c = transactionId;
        log.quiddity__c = String.valueOf(currentQuiddity);
        log.timestamp__c = Datetime.now();
        log.userId__c = UserInfo.getUserId();
        log.metadata__c = SalesforceLimitsInfo.getLimitsInfo();
        logsToFlush.add(log);

    }

    private void publishLogEvent(String level, String message) {
        FactorWiseLog__e log = new FactorWiseLog__e();        
        log.level__c = level;
        log.message__c = message;        
        log.type__c = 'log';
        pushEventCommon(log);
    }

    private void publishMetricEvent(String metric) {
        FactorWiseLog__e log = new FactorWiseLog__e();        
        log.level__c = FactorWiseLogLevel.INFO;
        log.message__c = metric;
        log.type__c = 'metric';
        pushEventCommon(log);
    }

    public void pushMetric(String metricName, Decimal metricValue ) {
        if(String.isNotBlank(metricName) && !metricName.contains(':')) {
            publishMetricEvent(metricName + ':' + metricValue);
        }
    }
    
    public void logDebug(String message) {
        if(this.currentLevel <= FactorWiseLogLevel.DEBUG_LEVEL) {
            this.publishLogEvent(FactorWiseLogLevel.DEBUG, message);
        }
    }

    public void logInfo(String message) {
        if(this.currentLevel <= FactorWiseLogLevel.INFO_LEVEL) {
            this.publishLogEvent(FactorWiseLogLevel.INFO, message);
        }
    }

    public void logWarn(String message) {
        if(this.currentLevel <= FactorWiseLogLevel.WARN_LEVEL) {
            this.publishLogEvent(FactorWiseLogLevel.WARN, message);
        }
    }

    public void logError(Exception e, String message) {
        if (e != null) {
            this.publishLogEvent(FactorWiseLogLevel.ERROR, message + '\n' + e.getMessage() + '\n' + e.getStackTraceString());
        } else {
             this.publishLogEvent(FactorWiseLogLevel.ERROR, message);
        }
    }

    public List<FactorWiseLog__e> getEnqueuedEvents() {
        return logsToFlush;
    }
}