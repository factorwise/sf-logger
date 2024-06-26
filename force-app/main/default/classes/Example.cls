public class Example {

    public static void action() {
        FactorWiseLogger logger = FactorWiseLogger.getLogger();

        try {
            logger.pushMetric('lead_converted', 1);
            logger.logInfo('An info log from another test...');
            throw new ExampleException('Something bad happened');
        } catch(Exception e) {

            logger.LogError(e, 'This is an error log');
        }
        finally {
            FactorWiseLogger.flush();
        }
    }

    public class ExampleException extends Exception{
        
    }
}