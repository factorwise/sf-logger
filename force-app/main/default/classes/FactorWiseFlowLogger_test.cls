@IsTest
public class FactorWiseFlowLogger_test {
    @IsTest
    static void testFlowLoggerDebug() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        logger.setLevel(FactorWiseLogLevel.DEBUG_LEVEL);

        List<FactorWiseFlowLogger.LogInput> inputs = new List<FactorWiseFlowLogger.LogInput>();
        FactorWiseFlowLogger.LogInput li = new FactorWiseFlowLogger.LogInput();
        li.message = 'debug message';
        li.logLevel = 'DEBUG';
        inputs.add(li);

        FactorWiseFlowLogger.log(inputs);
        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('DEBUG', events[0].level__c);
        Assert.areEqual('debug message', events[0].message__c);
    }

    @IsTest
    static void testFlowLoggerInfo() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();

        List<FactorWiseFlowLogger.LogInput> inputs = new List<FactorWiseFlowLogger.LogInput>();
        FactorWiseFlowLogger.LogInput li = new FactorWiseFlowLogger.LogInput();
        li.message = 'info message';
        li.logLevel = 'INFO';
        inputs.add(li);

        FactorWiseFlowLogger.log(inputs);
        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('INFO', events[0].level__c);
        Assert.areEqual('info message', events[0].message__c);
    }

    @IsTest
    static void testFlowLoggerWarn() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();

        List<FactorWiseFlowLogger.LogInput> inputs = new List<FactorWiseFlowLogger.LogInput>();
        FactorWiseFlowLogger.LogInput li = new FactorWiseFlowLogger.LogInput();
        li.message = 'warn message';
        li.logLevel = 'WARN';
        inputs.add(li);

        FactorWiseFlowLogger.log(inputs);
        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('WARN', events[0].level__c);
        Assert.areEqual('warn message', events[0].message__c);
    }

    @IsTest
    static void testFlowLoggerError() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();

        List<FactorWiseFlowLogger.LogInput> inputs = new List<FactorWiseFlowLogger.LogInput>();
        FactorWiseFlowLogger.LogInput li = new FactorWiseFlowLogger.LogInput();
        li.message = 'error message';
        li.logLevel = 'ERROR';
        inputs.add(li);

        FactorWiseFlowLogger.log(inputs);
        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('ERROR', events[0].level__c);
        Assert.areEqual('error message', events[0].message__c);
    }
}