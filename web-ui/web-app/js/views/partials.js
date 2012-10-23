YUI().add('partials', function (Y) {

    Y.Handlebars.registerPartial('version', Y.one('#version-partial').getHTML());
    Y.Handlebars.registerPartial('warning-banner', Y.one('#warning-banner-partial').getHTML());

});