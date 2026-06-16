import QtQuick
import QtGraphs

// Standalone chart component for the table example.
// API:
//   loadData(array)         — populate series from [{month, value}, ...] array
//   updatePoint(index, y)   — replace one point and rescale Y axis
Item {
    id: root
    implicitHeight: 340

    // ── Public API ────────────────────────────────────────────────────────────

    // Populate the series from an array of {month, value} objects.
    // Called once by the parent after the DataProvider has loaded.
    function loadData(dataArray) {
        series.clear()
        for (var i = 0; i < dataArray.length; i++)
            series.append(i, dataArray[i].value)
        recalcAxisY()
    }

    // Replace one data point and rescale the Y axis.
    // Uses the confirmed XYSeries.replace(index, newX, newY) API.
    function updatePoint(index, newY) {
        series.replace(index, index, newY)
        recalcAxisY()
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    // Scan all series points and update yAxis.min / yAxis.max.
    // ValueAxis has no autoScale — min/max must be set explicitly.
    // tickInterval: 0 (default) tells Qt Graphs to pick tick spacing automatically.
    function recalcAxisY() {
        var lo = Infinity, hi = -Infinity
        for (var i = 0; i < series.count; i++) {
            var y = series.at(i).y
            if (y < lo) lo = y
            if (y > hi) hi = y
        }
        if (lo === Infinity) { lo = 0; hi = 100 }

        // 10 % headroom; round outward to a multiple of 50 so ticks land cleanly
        var paddedLo = Math.floor(lo  * 0.9  / 50) * 50
        var paddedHi = Math.ceil(hi   * 1.10 / 50) * 50
        if (paddedHi <= paddedLo) paddedHi = paddedLo + 100

        yAxis.min = Math.max(paddedLo, 0)   // never show negative for sales data
        yAxis.max = paddedHi
    }

    // ── GraphsView ────────────────────────────────────────────────────────────
    GraphsView {
        anchors.fill: parent

        theme: GraphsTheme {
            colorScheme: GraphsTheme.ColorScheme.Dark
            plotAreaBackgroundVisible: true
        }

        axisX: ValueAxis {
            min: 0; max: 11
            tickInterval: 1
            gridVisible: false
            labelFormat: "%g"
        }

        axisY: ValueAxis {
            id: yAxis
            min: 0; max: 500
            gridVisible: false
            tickInterval: 0   // 0 = auto spacing (ValueAxis documentation)
            labelFormat: "%g"
        }

        LineSeries {
            id: series
            name: "Units Sold"
            width: 2
        }
    }
}
