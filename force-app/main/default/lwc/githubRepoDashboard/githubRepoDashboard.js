import { LightningElement, track } from 'lwc';
import getRepositories from '@salesforce/apex/GitHubController.getRepositories';

export default class GithubRepoDashboard extends LightningElement {


    @track repositories = [];
    @track error;

    username = '';

    isLoading = false;

    columns = [
        {
            label: 'Repository Name',
            fieldName: 'name',
            type: 'text'
        },
        {
            label: 'Full Name',
            fieldName: 'full_name',
            type: 'text'
        },
        {
            label: 'GitHub URL',
            fieldName: 'html_url',
            type: 'url',
            typeAttributes: {
                label: {
                    fieldName: 'html_url'
                },
                target: '_blank'
            }
        },
        {
            label: 'Visibility',
            fieldName: 'visibility',
            type: 'text'
        }
    ];



    handleUsernameChange(event) {

        this.username = event.target.value;

    }

    async fetchRepositories() {

        this.isLoading = true;

        this.error = undefined;

        try {

            const result = await getRepositories({
                username: this.username
            });

            console.log('Repositories:', result);

            this.repositories = result;

        } catch (error) {

            console.error('Error:', error);

            this.error =
                error.body?.message || 'Something went wrong';

        } finally {

            this.isLoading = false;

        }
    }
}