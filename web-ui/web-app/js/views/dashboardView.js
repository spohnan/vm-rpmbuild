YUI().add('dashboardView', function (Y) {

    Y.DashboardView = Y.Base.create('dashboardView', Y.View, [], {
        render: function () {
            var model = this.get('model');
            var template = Y.Handlebars.compile(Y.one('#dashboard-template').getHTML());
            this.get('container').setHTML(template({
                                version: model.get('version'),
                                last_updated: model.get('updated'),
                                local_changelist: model.get('local_changelist')
                            }));
            return this;
        }
    });

}, '1.0', {requires: ['view']} );