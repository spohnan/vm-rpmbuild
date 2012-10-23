YUI().add('adminView', function (Y) {

    Y.AdminView = Y.Base.create('adminView', Y.View, [], {
        events: {
            '#btn-test': {
                click: function() {
                    Y.AppCache.flush();
                }
            }
        },
        render: function () {
            var template = Y.AppCache.getTemplate('admin');
            var appInfo = Y.AppCache.getAppInfo();
            console.log(Y.AppCache.getCacheInfo());
            this.get('container').setHTML(template({
                                            version: appInfo.appliance.version,
                                            last_updated: appInfo.appliance.updated,
                                            local_changelist: appInfo.appliance.local_changelist,
                                            cacheInfo: Y.AppCache.getCacheInfo()
                                        }));
            return this;
        }
    });

}, '1.0', {requires: ['view', 'appCache']} );