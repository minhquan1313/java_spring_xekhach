(() => {
    const colors = myColors();

    $("[data-data-chart]").each(function () {
        const $canvas = $(this);
        const context = $canvas[0].getContext("2d");

        const columnTitlesAttr = $canvas.attr("data-labels-chart");
        const dataAttr = $canvas.attr("data-data-chart");
        const typeAttr = $canvas.attr("data-type-chart") || "line";
        const tableName = $canvas.attr("data-table-name-chart");
        const dataOf = $canvas.attr("data-label-chart");
        const dataPostfix = $canvas.attr("data-postfix-chart");

        const data = parseData(dataAttr);
        const columnTitles = parseData(columnTitlesAttr);
        // console.log({ labelAttr, labels, dataAttr, data });

        let color;
        let legend;
        let scales;
        let interaction;
        switch (typeAttr) {
            case "line":
            case "bar":
                const contextGradient = context.createLinearGradient(0, 0, 0, 400);
                contextGradient.addColorStop(0, colors.get());
                contextGradient.addColorStop(1, colors.get());
                color = contextGradient;

                scales = {
                    y: {
                        ticks: {
                            callback: (v) => parseInt(v).toLocaleString() + (dataPostfix ? " " + dataPostfix : ""),
                        },
                    },
                    x: {
                        ticks: {
                            source: "auto",
                            // Disabled rotation for performance
                            maxRotation: 0,
                            autoSkip: true,
                        },
                    },
                };
                legend = {
                    onHover: handleHover,
                    onLeave: handleLeave,
                };

                interaction = {
                    intersect: false,
                    mode: "index",
                };
                break;
            case "doughnut":
            case "polarArea":
            case "pie":
                color = [];
                data.forEach(() => {
                    color.push(colors.get());
                });

                legend = {
                    onHover: handleHover,
                    onLeave: handleLeave,
                };
                break;

            default:
                color = colors.get();
                break;
        }

        const d = {
            labels: columnTitles,
            datasets: [
                {
                    label: dataOf,
                    data,
                    fill: true,
                    backgroundColor: color,
                    borderColor: "#fff",
                    borderWidth: 1,
                    tension: 0.3,
                    pointStyle: "rectRot",
                },
            ],
        };

        const config = {
            type: typeAttr,
            data: d,
            options: {
                hitRadius: 50,
                hoverRadius: 8,

                interaction,

                responsive: true,
                scales,
                plugins: {
                    title: {
                        display: true,
                        text: tableName,
                    },
                    legend,
                },
            },
        };

        const chart = new Chart(context, config);

        window.addEventListener("resize", () => {
            chart.resize();
        });
    });
    // }

    function parseData(o) {
        return o
            .replace(/\[|\]/g, "")
            .replace(/(,\s+)/g, ",")
            .split(",");
    }

    function myColors() {
        const color = ["#c44569", "#cf6a87", "#e15f41", "#e77f67", "#546de5", "#778beb", "#f5cd79", "#f7d794", "#f19066", "#f3a683"];
        let i = 0;

        return {
            get(index) {
                if (typeof index == "number") i = index;

                let ind = i++ % color.length;
                let c = color[ind];

                return c;
            },
        };
    }
    function handleHover(evt, item, legend) {
        const bc = legend.chart.data.datasets[0].backgroundColor;
        if (!Array.isArray(bc)) return;

        bc.forEach((color, index, colors) => {
            colors[index] = index === item.index || color.length === 9 ? color : color + "4D";
        });
        legend.chart.update();
    }
    function handleLeave(evt, item, legend) {
        const bc = legend.chart.data.datasets[0].backgroundColor;
        if (!Array.isArray(bc)) return;

        bc.forEach((color, index, colors) => {
            colors[index] = color.length === 9 ? color.slice(0, -2) : color;
        });
        legend.chart.update();
    }
})();
