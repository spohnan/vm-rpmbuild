YUI.add('repoModelList', function (Y) {

    Y.RepoModelList = Y.Base.create('repoModelList', Y.ModelList, [], {

        model:Y.RepoModel

    });

}, '0.1', { requires: ['model-list', 'repoModel'] } );