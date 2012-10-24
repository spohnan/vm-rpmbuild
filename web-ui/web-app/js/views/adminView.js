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
            this.get('container').setHTML(template({appInfo: Y.AppCache.getAppInfo()}));

            var table = new Y.DataTable({
                        columns: [
                            { key: 'request', label: 'Key', className: 'table-cell' },
                            { key: 'cached', label: 'Cached At', className: 'table-cell'},
                            { key: 'expires', label: 'Expires', emptyCellValue: 'No Expiration', className: 'table-cell'}
                        ],
                        data: Y.AppCache.getCacheInfo(),
                        sortable: true,
                        scrollable: "y",
                        height:"75px",
                        width: "100%"
                    });

            setTimeout(function() {
                table.render('#cacheItems');
            }, 50);

            return this;
        }
    });

}, '1.0', {requires: ['view', 'appCache', 'datatable']} );