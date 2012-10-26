(function( $ ){
    var settings = {
        alert : false
    };

    var methods = {
        publicFunction : function( ) {
            alert('This is a public function.');
        },
        publicFunctionWithArgs : function(args) {
            alert('This is a public function with arguments: ' + JSON.stringify(args));
        }
    };

    $.fn.pluginTemplate = function(method) {
        var base = this;
        var args = arguments;

        return base.each(function() {
            if (methods[method]) {
                return methods[method].apply(base, Array.prototype.slice.call(args, 1));
            } else if (typeof method === 'object' || ! method) {
                setOptions(method);
                init();
            } else {
                alert('Method ' +  method + ' does not exist on jQuery.pluginTemplate.');
            }
        });

        function init() {
            alert("init() - settings.alert = " + settings.alert);
        }

        function setOptions(options) {
            settings = $.extend(settings, options);
        }

        function privateFunction() {
           // This is a private function
        }

    };
})(jQuery);
