YUI().add('partials', function (Y) {

    Y.Handlebars.registerPartial('version', Y.io("exec/fetch?template=version", { sync: true }).responseText);
    Y.Handlebars.registerPartial('warning-banner', Y.io("exec/fetch?template=warning-banner", { sync: true }).responseText);

});