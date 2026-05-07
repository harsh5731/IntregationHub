public with sharing class GitHubService {

    public static List<GitHubRepo> getRepositories(
        String username
    ) {

        HttpResponse res =
            GitHubHttpClient.sendGet(
                '/users/' + username + '/repos'
            );

        if (res.getStatusCode() != 200) {

            throw new CalloutException(
                'GitHub API failed: ' + res.getBody()
            );
        }

        return (List<GitHubRepo>) JSON.deserialize(
            res.getBody(),
            List<GitHubRepo>.class
        );
    }
}