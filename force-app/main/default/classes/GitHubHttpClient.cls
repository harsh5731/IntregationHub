public with sharing class GitHubHttpClient {

    private static final String NAMED_CREDENTIAL = 'callout:GitHubAPI';

    public static HttpResponse sendGet(String path) {

        HttpRequest req = new HttpRequest();

        req.setEndpoint(
            NAMED_CREDENTIAL + path
        );

        req.setMethod('GET');

        req.setHeader('Accept', 'application/json');
        req.setHeader('User-Agent', 'Salesforce');

        Http http = new Http();

        return http.send(req);
    }
}