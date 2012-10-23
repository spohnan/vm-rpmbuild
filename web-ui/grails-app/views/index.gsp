<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if IE 9 ]>        <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <title>RPM Builder</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/ico" href="img/favicon.ico">
    <style> body { padding-top: 60px; /* Align the body container with the bottom of the topbar */ } </style>
    <!--[if IE 7]>
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome-ie7.css"><![endif]-->
    <!--[if lt IE 9]><script src="lib/html5shim/html5.js"></script><![endif]-->
    <script src="lib/yui/build/yui/yui-min.js"></script>
    <script src="js/config.js"></script>
    <script src="js/app.js"></script>
</head>
<body class="yui3-skin-sam">

    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <a class="brand" href="/web-ui/dashboard"><i class="icon-cogs"></i> RPM Builder</a>
                <div class="nav-collapse collapse">
                    <ul class="nav">
                        <li><a href="/web-ui/dashboard"><i class="icon-dashboard"></i> Dashboard</a></li>
                        <li><a href="/web-ui/admin"><i class="icon-wrench"></i> Admin</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <div id="app" class="container"></div>

    <script id="version-partial" type="text/x-handlebars-template">
        <div class="muted">Appliance: v{{version}} - Last Updated: {{last_updated}}</div>
    </script>

    <script id="warning-banner-partial" type="text/x-handlebars-template">
        {{#if local_changelist}}
        <div class="alert">
            <button type="button" class="close" data-dismiss="alert">×</button>
            <strong>Warning!</strong> Some files have been locally modified on this appliance
            <button type="button" style="margin-left: 15px" class="btn btn-warning btn-mini" data-toggle="collapse" data-target="#demo">
                more ...
            </button>
            <div id="demo" class="collapse">
            {{#each local_changelist}}
                {{this.name}}<br/>
            {{/each}}
            </div>
        </div>
        {{/if}}
    </script>

    <script id="admin-template" type="text/x-handlebars-template">
        {{>warning-banner}}
        {{>version}}
        <form>
            <legend><i class="icon-wrench"></i> Admin</legend>
        </form>
        <button id="btn-test" class="btn btn-primary">Update Version</button>
    </script>

    <script id="dashboard-template" type="text/x-handlebars-template">
        {{>warning-banner}}
        {{>version}}
        <form>
            <legend><i class="icon-dashboard"></i> Dashboard</legend>
        </form>
    </script>

    <script>
//        var _gaq = _gaq || [];
//        _gaq.push(['_setAccount', 'UA-22981039-1']);
//        _gaq.push(['_trackPageview']);
//        (function() {
//            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
//            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
//            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
//        })();
    </script>
</body>
</html>
