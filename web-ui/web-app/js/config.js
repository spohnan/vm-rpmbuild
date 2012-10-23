YUI_config = {
    groups: {
        'app': {
            base: '/web-ui/',
            async: false,
            modules: {

                'bootstrap': {
                    path: 'lib/bootstrap/js/bootstrap.min.js',
                    requires: ['jquery', 'font-awesome-css', 'bootstrap-css', 'bootstrap-responsive-css']
                },
                'bootstrap-css': {
                    path: 'lib/bootstrap/css/bootstrap.min.css',
                    type: 'css'
                },
                'bootstrap-responsive-css': {
                    path: 'lib/bootstrap/css/bootstrap-responsive.css',
                    type: 'css'
                },
                'font-awesome-css': {
                    path: 'lib/font-awesome/css/font-awesome.css',
                    type: 'css'
                },
                'jquery': {
                    path: 'lib/jquery/jquery-1.8.2.min.js'
                },
                'appInfoModel': {
                    path: 'js/models/appInfoModel.js'
                },
                'repoModel': {
                    path: 'js/models/repoModel.js'
                },
                'repoModelList': {
                    path: 'js/models/repoModelList.js'
                },
                'adminView': {
                    path: 'js/views/adminView.js'
                },
                'dashboardView': {
                    path: 'js/views/dashboardView.js'
                },
                'repoView': {
                    path: 'js/views/repoView.js'
                },
                'partials': {
                    path: 'js/views/partials.js'
                },
                'appCache': {
                    path: 'js/util/appCache.js'
                }
            }
        }
    }
};