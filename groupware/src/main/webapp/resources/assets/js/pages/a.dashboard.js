!function(r) {
    "use strict";

    function e() {
        this.$body = r("body"), this.charts = []
    }

    e.prototype.init = function() {
        r("#dash-daterange").daterangepicker({
            singleDatePicker: !0
        });
    }, r.Dashboard = new e, r.Dashboard.Constructor = e
}(window.jQuery),

function(t) {
    "use strict";
    t(document).ready(function(e) {
        t.Dashboard.init()
    })
}(window.jQuery);
