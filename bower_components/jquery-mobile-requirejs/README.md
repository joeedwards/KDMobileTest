jquery mobile requirejs
=======================

If you want to use it with requirejs AND don't have to worry about when is loaded use this.

In your main file add this config:

    require.config({
        map: {
            '*': {
                'jquery-mobile-bower': '../bower_components/jquery-mobile-requirejs/js/jquery.mobile-1.3.2',
            }
        }
    }

And then:

    require(['jquery-mobile-bower'], function (jqmOpen) {
        'use strict';


        $( document ).on( "mobileinit",
            // Set up the "mobileinit" handler before requiring jQuery Mobile's module
            function() {
                // Prevents all anchor click handling including the addition of active button state and alternate link bluring.
                $.mobile.linkBindingEnabled = false;

                // Disabling this will prevent jQuery Mobile from handling hash changes
                $.mobile.hashListeningEnabled = false;
            }
        )
        // only now jquery mobile is really injected into the jquery.
        jqmOpen();
    }

If you would not use this lib (such as the default jquery mobile or jquery-mobile-bower) you should make an inner require in order to attach the "mobileinit" event before the jquery mobile. By wrapping it within a function we can delay the jquery mobile injection.
