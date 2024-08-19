!function(o) {
    "use strict";

    function t() {
        this.$body = o("body"), this.charts = []
    }

    t.prototype.respChart = function(t, r, a, e) {
        Chart.defaults.color = "#8fa2b3";
        Chart.defaults.borderColor = "rgba(133, 141, 152, 0.1)";
        var i, n = t.get(0).getContext("2d"),
            s = o(t).parent();
        t.attr("width", o(s).width());
        if (r === "Doughnut") {
            i = new Chart(n, {
                type: "doughnut",
                data: a,
                options: e
            });
        }
        return i;
    };

    t.prototype.initCharts = function() {
        var t, r = [];
        if (o("#project-status-chart").length > 0) {
            t = {
                labels: ["진행", "대기", "마감"],
                datasets: [{
                    data: window.projectStatusData,
                    backgroundColor: (t = o("#project-status-chart").data("colors")) ? t.split(",") : ["#0acf97", "#727cf5", "#fa5c7c"],
                    borderColor: "transparent",
                    borderWidth: "3"
                }]
            };
            r.push(this.respChart(o("#project-status-chart"), "Doughnut", t, {
                maintainAspectRatio: !1,
                cutout: 80,
                plugins: {
                    cutoutPercentage: 40,
                    legend: {
                        display: !1
                    }
                }
            }));
        }
        return r;
    };

    t.prototype.init = function() {
        var r = this;
        Chart.defaults.font.family = '-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen-Sans,Ubuntu,Cantarell,"Helvetica Neue",sans-serif';
        r.charts = this.initCharts();
        o(window).on("resizeEnd", function(t) {
            o.each(r.charts, function(t, r) {
                try {
                    r.destroy();
                } catch (t) {}
            });
            r.charts = r.initCharts();
        });

        o(window).resize(function() {
            this.resizeTO && clearTimeout(this.resizeTO);
            this.resizeTO = setTimeout(function() {
                o(this).trigger("resizeEnd");
            }, 500);
        });
    };

    o.ChartJs = new t;
    o.ChartJs.Constructor = t;
}(window.jQuery),

function() {
    "use strict";
    window.jQuery.ChartJs.init();
}();
