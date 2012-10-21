YUI().use('handlebars', 'bootstrap', 'app-base', 'io-base', 'json-parse', function (Y) {

    var version = "unknown",
        updated = "unknown",
        local_changelist = [];

    // Load configuration data
    Y.io("exec/appinfo", {
        on: {
            success : function (x,o) {
                var resp = Y.JSON.parse(o.responseText);
                version = resp.appliance.version;
                updated = resp.appliance.updated;
                local_changelist = resp.appliance.local_changelist;
            }
        }
    });

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //              Views

    Y.Handlebars.registerPartial('version', Y.one('#version-partial').getHTML());
    Y.Handlebars.registerPartial('warning-banner', Y.one('#warning-banner-partial').getHTML());
    Y.AdminView = Y.Base.create('adminView', Y.View, [], {
        events: {
            '#btn-test': {
                click: function() {
                    alert('test button works');
                }
            }
        },
        render: function () {
            var template = Y.Handlebars.compile(Y.one('#admin-template').getHTML());
            this.get('container').setHTML(template({
                    version: version,
                    last_updated: updated,
                    local_changelist: local_changelist
                }));
            return this;
        }
    });

    Y.DashboardView = Y.Base.create('dashboardView', Y.View, [], {
        render: function () {
            var template = Y.Handlebars.compile(Y.one('#dashboard-template').getHTML());
            this.get('container').setHTML(template({
                    version: version,
                    last_updated: updated,
                    local_changelist: local_changelist
                }));
            return this;
        }
    });

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //              App

    var app  = new Y.App({
        container     : '#app',
        viewContainer : '#app',
        transitions: true,
        views: {
            admin: { type: 'AdminView' },
            dashboard: { type: 'DashboardView' }
        }
    });

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //              Routes

    app.route('/dashboard', function () {
        this.showView('dashboard');
    });

    app.route('/admin', function () {
        this.showView('admin');
    });

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //              Init


    app.navigate('dashboard');
    app.render();

});