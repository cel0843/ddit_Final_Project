$(document).ready(function() {
    var colors = ["#727cf5", "#0acf97", "#fa5c7c"];
    var dataColors = $("#basic-treemap").data("colors");
    var options = {
        series: [{
            data: monthlySurveyData // JSP에서 전달된 데이터를 사용
        }],
        colors: dataColors ? dataColors.split(",") : colors,
        legend: {
            show: !1
        },
        chart: {
            height: 300,
            type: "treemap"
        },
        title: {
            text: "Basic Treemap",
            align: "center"
        }
    };
    var chart = new ApexCharts(document.querySelector("#basic-treemap"), options);
    chart.render();
});
