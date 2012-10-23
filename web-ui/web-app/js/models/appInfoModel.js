YUI().add('appInfoModel', function (Y) {

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //            Models

    Y.AppInfo = Y.Base.create('appInfoModel', Y.Model, [], {
        sync: function (action, options, callback) {
            if(action === 'read') {
                var resp = Y.io("exec/appinfo", { sync: true });
                var appInfo = Y.JSON.parse(resp.responseText);
                this.set('version', appInfo.appliance.version);
                this.set('updated', appInfo.appliance.updated);
                this.set('local_changelist', appInfo.appliance.local_changelist);
            }
        }
    }, {
        ATTRS: {
            version: { value: "UNKNOWN" },
            updated: { value: "UNKNOWN" },
            local_changelist: { value: [] }
        }
    });

}, '1.0', {requires: ['model']} );
