YUI().add('adminView', function (Y) {

    Y.AdminView = Y.Base.create('adminView', Y.View, [], {
        events: {
            '#btn-test': {
                click: function() {
                    var model = this.get('model');
                    model.set('version', "2.2.2");
                }
            }
        },
        initializer: function() {
            var model = this.get('model');
            model.after('*:change', this.render, this);
        },
        render: function () {
            var model = this.get('model');
            var template = Y.Handlebars.compile(Y.one('#admin-template').getHTML());
            this.get('container').setHTML(template({
                                            version: model.get('version'),
                                            last_updated: model.get('updated'),
                                            local_changelist: model.get('local_changelist')
                                        }));
            return this;
        }
    });

}, '1.0', {requires: ['view']} );