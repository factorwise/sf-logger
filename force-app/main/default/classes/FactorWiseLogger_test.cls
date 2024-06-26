@IsTest
public class FactorWiseLogger_test {

    @IsTest
    static void testLogDebug() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        
        Test.startTest();
        logger.setLevel(FactorWiseLogLevel.DEBUG_LEVEL);
        logger.logDebug('debug message');
        Test.stopTest();

        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('DEBUG', events[0].level__c);
        Assert.areEqual('debug message', events[0].message__c);
    }

    @IsTest
    static void testLogInfo() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        
        Test.startTest();
        logger.logInfo('info message');
        Test.stopTest();

        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('INFO', events[0].level__c);
        Assert.areEqual('info message', events[0].message__c);
    }

    @IsTest
    static void testLogWarn() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        
        Test.startTest();
        logger.logWarn('warn message');
        Test.stopTest();

        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('WARN', events[0].level__c);
        Assert.areEqual('warn message', events[0].message__c);
    }

    @IsTest
    static void testLogError() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        
        Test.startTest();
        logger.logError(new TestException(), 'error message');
        Test.stopTest();

        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('ERROR', events[0].level__c);
        Assert.isTrue(events[0].message__c.contains('error message'));
    }

    @IsTest
    static void testPublishMetric() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        
        Test.startTest();
        logger.pushMetric('metricName', 123);
        Test.stopTest();

        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('metric', events[0].type__c);
    }
    
    @IsTest
    static void testFlush() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();
        
        Test.startTest();
        logger.logInfo('info message');
        Test.stopTest();

        List<FactorWiseLog__e> events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(1, events.size());
        Assert.areEqual('INFO', events[0].level__c);
        Assert.areEqual('info message', events[0].message__c);

        FactorWiseLogger.flush();

        events = logger.getEnqueuedEvents();
        Assert.isNotNull(events);
        Assert.areEqual(0, events.size());
    }

    
    private class TestException extends Exception {}
}
