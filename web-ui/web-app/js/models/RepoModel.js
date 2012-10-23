YUI().add('RepoModel', function (Y) {

    Y.RepoModel = Y.Base.create('RepoModel', Y.Model, [], {
    }, {
        ATTRS: {
            name: {},
            url: {},
            updated: {}
        }
    });

}, '1.0', {requires: ['model']} );