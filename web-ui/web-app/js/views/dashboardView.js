YUI().add('dashboardView', function (Y) {

    Y.DashboardView = Y.Base.create('dashboardView', Y.View, [], {
        render: function () {
            var template = Y.AppCache.getTemplate('dashboard');
            this.get('container').setHTML(template({appInfo: Y.AppCache.getAppInfo()}));
            return this;
        }
    });

}, '1.0', {requires: ['view', 'appCache']} );