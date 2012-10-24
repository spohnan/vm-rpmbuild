YUI().add('appCache', function (Y) {

    Y.AppCache = (function() {
        var ONE_MINUTE = 60 * 1000;
        var NO_EXPIRATION = 0;

        var templateCache = new Y.Cache({max: 25 ,expires: NO_EXPIRATION});
        var miscCache = new Y.Cache({max: 25 ,expires: ONE_MINUTE});

        return {

            flush: function() {
                templateCache.flush();
                miscCache.flush();
            },

            getCacheInfo: function() {
                var entries = [], i;
                for(i=0; i<miscCache.get("size"); i++) {
                    entries.push(miscCache.get("entries")[i]);
                }
                for(i=0; i<templateCache.get("size"); i++) {
                    entries.push(templateCache.get("entries")[i]);
                }
                return entries;
            },

            getAppInfo: function() {
                var cacheObj = miscCache.retrieve('appInfo');
                if(cacheObj === null) {
                    var resp = Y.io("exec/appinfo", { sync: true });
                    var appInfo = Y.JSON.parse(resp.responseText);
                    miscCache.add('appInfo', appInfo);
                    return appInfo;
                } else {
                    return cacheObj.response;
                }
            },

            getTemplate: function(name) {
                var cacheObj = templateCache.retrieve(name);
                if(cacheObj === null) {
                    var template = Y.Handlebars.compile(Y.io("exec/fetch?template=" + name, {sync: true}).responseText);
                    templateCache.add(name, template);
                    return template;
                } else {
                    return cacheObj.response;
                }
            }
        };

    }());

}, '1.0', {requires: ['cache']} );