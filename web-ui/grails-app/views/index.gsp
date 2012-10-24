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
    <link rel="icon" type="image/ico" href="images/favicon.ico">
    <style> body { padding-top: 60px; /* Align the body container with the bottom of the topbar */ } </style>
    <!--[if IE 7]>
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome-ie7.css"><![endif]-->
    <!--[if lt IE 9]><script src="lib/html5shim/html5.js"></script><![endif]-->
    <script src="lib/yui/build/yui/yui-min.js"></script>
    <script src="js/config.js"></script>
    <script src="js/app.js"></script>
    <style>
        .table-cell {
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif !important;
            font-size: 115% !important;
        }
        .
        .alert {
            margin-bottom: 10px;
        }
        #cacheItems {
            height: 160px;
        }
    </style>
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
                        <li><a href="/web-ui/repo"><i class="icon-download"></i> Repositories</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="app" class="container"></div>

</body>
</html>
