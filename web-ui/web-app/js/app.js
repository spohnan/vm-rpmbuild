YUI().use(
    'handlebars', 'bootstrap', 'app-base',
    'io-base', 'json-parse', 'appInfoModel',
    'adminView', 'dashboardView', 'partials', function (Y) {

    // The AppInfo model loads some fairly static app state (version, last updated)
    var appInfo = new Y.AppInfo();
    appInfo.load();

    var app  = new Y.App({
        viewContainer : '#app',
        root: '/web-ui',

        views: {
            admin:     { type: 'AdminView'     },
            dashboard: { type: 'DashboardView' }
        },

        routes: [{
            path: '/dashboard',
            callback: function() { this.showView('dashboard', { model: appInfo }); }
        }, {
            path: '/admin',
            callback: function() { this.showView('admin', { model: appInfo }); }
        }]
    });

    // Figure out what view the client is requesting and route accordingly
    var requestedView = window.location.pathname.split('/')[2];
    if(requestedView !== "") {
        app.navigate('/' + requestedView);
    } else {
        app.navigate('/dashboard'); // The default view
    }

});