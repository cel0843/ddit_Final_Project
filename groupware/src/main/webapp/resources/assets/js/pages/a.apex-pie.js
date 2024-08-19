function renderSimpleDonutChart(questionLabels, questionData, ordNo) {
    var colors = ["#39afd1", "#ffbc00", "#313a46", "#fa5c7c", "#0acf97"];
    var dataColors = $("#simple-donut-"+ordNo).data("colors");
    
    if (dataColors) {
        colors = dataColors.split(",");
    }

    var options = {
        chart: {
            height: 320,
            type: "donut"
        },
        series: questionData,
        labels: questionLabels,
        colors: colors,
        legend: {
            show: true,
            position: "bottom",
            horizontalAlign: "center",
            verticalAlign: "middle",
            floating: false,
            fontSize: "14px",
            offsetX: 0,
            offsetY: 7
        },
        responsive: [{
            breakpoint: 600,
            options: {
                chart: {
                    height: 240
                },
                legend: {
                    show: false
                }
            }
        }]
    };

    var chart = new ApexCharts(document.querySelector("#simple-donut-"+ordNo), options);
    chart.render();
}

