public with sharing class IntegrationLogger {

    public static void logSuccess(
        String integrationName,
        String endpoint,
        String method,
        Integer statusCode,
        String responseBody,
        Long executionTime
    ) {

        try {

            Integration_Log__c logRecord =
                new Integration_Log__c();

            logRecord.Name =
                integrationName;

            logRecord.End_Point__c =
                endpoint;

            logRecord.Http_Method__c =
                method;

            logRecord.Status_Code__c =
                statusCode;

            logRecord.Success__c =
                true;

            logRecord.Response__c =
                responseBody;

            logRecord.Execution_Time__c =
                executionTime;

            insert logRecord;

        } catch (Exception e) {

            System.debug(
                LoggingLevel.ERROR,
                'Failed to create integration log: '
                + e.getMessage()
            );

        }
    }

    public static void logError(
        String integrationName,
        String endpoint,
        String method,
        Integer statusCode,
        String errorMessage,
        Long executionTime
    ) {

        try {

            Integration_Log__c logRecord =
                new Integration_Log__c();

            logRecord.Name =
                integrationName;

            logRecord.End_Point__c =
                endpoint;

            logRecord.Http_Method__c =
                method;

            logRecord.Status_Code__c =
                statusCode;

            logRecord.Success__c =
                false;

            logRecord.Error_Message__c =
                errorMessage;

            logRecord.Execution_Time__c =
                executionTime;

            insert logRecord;

        } catch (Exception e) {

            System.debug(
                LoggingLevel.ERROR,
                'Failed to create integration log: '
                + e.getMessage()
            );

        }
    }
}