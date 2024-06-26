public class FactorWiseFlowLogger {

    public class LogInput {
        @InvocableVariable(required=true)
        public String message;
        
        @InvocableVariable(required=true)
        public String logLevel;
    }

    @InvocableMethod(label='Log' description='Logs a message')
    public static void log(List<LogInput> inputs) {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        for(LogInput input : inputs) {
            logWithLogLevel(logger, input.logLevel, input.message);
        }
        if (!Test.isRunningTest()) {
            FactorWiseLogger.flush();
        }
    }

    private static void logWithLogLevel(FactorWiseLogger logger, String logLevel, String message) {
        if (logLevel.equalsIgnoreCase(FactorWiseLogLevel.DEBUG)) {
            logger.logDebug(message);
        } else if (logLevel.equalsIgnoreCase(FactorWiseLogLevel.INFO)) {
            logger.logInfo(message);
        } else if (logLevel.equalsIgnoreCase(FactorWiseLogLevel.WARN)) {
            logger.logWarn(message);
        } else if (logLevel.equalsIgnoreCase(FactorWiseLogLevel.ERROR)) {
            logger.logError(null, message);
        } else {
            logger.logDebug('Invalid log level specified: ' + logLevel);
        }
    }
}