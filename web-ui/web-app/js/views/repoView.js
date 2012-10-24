YUI().add('repoView', function (Y) {

    Y.RepoView = Y.Base.create('repoView', Y.View, [], {
        render: function () {
            var template = Y.AppCache.getTemplate('repo');
            this.get('container').setHTML(template({appInfo: Y.AppCache.getAppInfo()}));
            return this;
        }
    });

}, '1.0', {requires: ['view', 'appCache']} );