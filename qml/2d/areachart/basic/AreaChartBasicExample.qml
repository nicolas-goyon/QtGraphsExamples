import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    AreaChartBasicDataProvider { id: dataProvider }

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
                text: "Area Chart — Monthly Temperature Range (London)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                }

                axisX: ValueAxis {
                    min: 0; max: 11
                    tickInterval: 1
                    labelFormat: "%g"
                }
                axisY: ValueAxis {
                    min: -2; max: 30
                    gridVisible: false
                    tickInterval: 5
                    labelFormat: "%g °C"
                }

                // ── Upper boundary (daily highs) ─────────────────────────────
                LineSeries {
                    id: highSeries
                    Component.onCompleted: {
                        var pts = dataProvider.highData()
                        for (var i = 0; i < pts.length; i++) append(i, pts[i])
                    }
                }

                // ── Lower boundary (daily lows) ──────────────────────────────
                LineSeries {
                    id: lowSeries
                    Component.onCompleted: {
                        var pts = dataProvider.lowData()
                        for (var i = 0; i < pts.length; i++) append(i, pts[i])
                    }
                }

                // ── Area between low and high ────────────────────────────────
                // upperSeries = daily highs, lowerSeries = daily lows.
                // The filled region shows the daily temperature band each month.
                AreaSeries {
                    name: "Temp Range"
                    color: "#4089b4fa"         // #89b4fa at ~25 % opacity
                    borderColor: "#89b4fa"
                    borderWidth: 2
                    upperSeries: highSeries
                    lowerSeries: lowSeries
                }
            }

            AreaChartBasicDescription {}
        }
    }
}
