YUI().add('repoView', function (Y) {

    Y.RepoView = Y.Base.create('repoView', Y.View, [], {
        render: function () {
            //var template = Y.Handlebars.compile(Y.io("exec/fetch?template=repo", { sync: true }).responseText);
            var template = Y.AppCache.getTemplate('repo');
            var appInfo = Y.AppCache.getAppInfo();
            this.get('container').setHTML(template({
                                            version: appInfo.appliance.version,
                                            last_updated: appInfo.appliance.updated,
                                            local_changelist: appInfo.appliance.local_changelist
                                        }));
            return this;
        }
    });

}, '1.0', {requires: ['view', 'appCache']} );