import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    LineChartRangeDataProvider { id: dataProvider }

    // ── Boundary series (outside GraphsView — data containers only) ───────────
    // Defined here so they are not rendered as independent lines; only the
    // AreaSeries inside GraphsView uses them to fill the colored range band.
    LineSeries { id: minBound }
    LineSeries { id: maxBound }

    Component.onCompleted: {
        var mn  = dataProvider.minData()
        var mx  = dataProvider.maxData()
        var act = dataProvider.actualData()
        for (var i = 0; i < act.length; i++) {
            minBound.append(i, mn[i])
            maxBound.append(i, mx[i])
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        contentHeight: content.implicitHeight + 32

        ColumnLayout {
            id: content
            x: 16; y: 16
            width: parent.width - 32
            spacing: 8

            Text {
                text: "Line Chart — Temperature vs. Comfort Range"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                    grid.mainWidth: 0.5
                }

                axisX: ValueAxis {
                    min: 0; max: 11
                    tickInterval: 1
                    labelFormat: "%g"
                }
                axisY: ValueAxis {
                    min: -5; max: 30
                    tickInterval: 5
                    labelFormat: "%g°"
                }

                // ── Red comfort-zone band ─────────────────────────────────────
                // upperSeries/lowerSeries reference the LineSeries defined above
                // (outside GraphsView), so only the fill area is drawn — no extra
                // lines appear on the chart.
                AreaSeries {
                    name: "Comfort Zone"
                    color: "#40f38ba8"
                    borderColor: "#80f38ba8"
                    borderWidth: 1
                    upperSeries: maxBound
                    lowerSeries: minBound
                }

                // ── Actual temperature line ───────────────────────────────────
                LineSeries {
                    name: "Avg Temp (°C)"
                    color: "#89b4fa"
                    width: 2
                    Component.onCompleted: {
                        var pts = dataProvider.actualData()
                        for (var i = 0; i < pts.length; i++) append(i, pts[i])
                    }
                }
            }

            LineChartRangeDescription {}
        }
    }
}
