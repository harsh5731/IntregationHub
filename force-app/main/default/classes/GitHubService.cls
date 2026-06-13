public with sharing class GitHubService {

    public static List<GitHubRepo> getRepositories(
        String username
    ) {

        Long startTime =
            DateTime.now().getTime();

        try {

            HttpResponse res =
                GitHubHttpClient.sendGet(
                    '/user/repos'
                );

            Long executionTime =
                DateTime.now().getTime() - startTime;

            if (res.getStatusCode() != 200) {

                IntegrationLogger.logError(
                    'GitHub',
                    '/user/repos',
                    'GET',
                    res.getStatusCode(),
                    res.getBody(),
                    executionTime
                );

                throw new CalloutException(
                    'GitHub API failed: '
                    + res.getBody()
                );
            }

            List<Object> rawRepos =
                (List<Object>) JSON.deserializeUntyped(
                    res.getBody()
                );

            List<GitHubRepo> repositories =
                new List<GitHubRepo>();

            for (Object obj : rawRepos) {

                Map<String, Object> repoMap =
                    (Map<String, Object>) obj;

                GitHubRepo repo =
                    new GitHubRepo();

                repo.id =
                    Integer.valueOf(
                        repoMap.get('id')
                    );

                repo.name =
                    (String) repoMap.get('name');

                repo.full_name =
                    (String) repoMap.get('full_name');

                repo.html_url =
                    (String) repoMap.get('html_url');

                repo.isPrivate =
                    (Boolean) repoMap.get('private');

                repo.visibility =
                    repo.isPrivate
                    ? 'Private 🔒'
                    : 'Public 🌍';

                repositories.add(repo);
            }

            IntegrationLogger.logSuccess(
                'GitHub',
                '/user/repos',
                'GET',
                res.getStatusCode(),
                res.getBody(),
                executionTime
            );

            return repositories;

        } catch (Exception e) {

            Long executionTime =
                DateTime.now().getTime() - startTime;

               System.debug(
                   'ORIGINAL ERROR => ' +
                   e.getMessage()
               );

            throw e;
        }
    }
}