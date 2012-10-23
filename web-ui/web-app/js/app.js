YUI().use(
    'handlebars', 'bootstrap', 'app-base',
    'io-base', 'json-parse', 'appInfoModel',
    'adminView', 'dashboardView', 'repoView',
    'partials', function (Y) {

    var app  = new Y.App({
        viewContainer : '#app',
        root: '/web-ui',
        views: {
            admin:     { type: 'AdminView'     },
            dashboard: { type: 'DashboardView' },
            repo:      { type: 'RepoView'      }
        },

        routes: [{
            path: '/dashboard',
            callback: function() { this.showView('dashboard'); }
        }, {
            path: '/admin',
            callback: function() { this.showView('admin'); }
        }, {
            path: '/repo',
            callback: function() { this.showView('repo'); }
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