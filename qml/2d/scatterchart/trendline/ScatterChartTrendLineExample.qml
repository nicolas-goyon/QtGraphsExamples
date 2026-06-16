import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    ScatterChartTrendLineDataProvider { id: dataProvider }

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
                text: "Scatter Chart — Study Hours vs Exam Score (with trend line)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisX: ValueAxis { min: 0; max: 9;   tickInterval: 1;  labelFormat: "%g h" }
                axisY: ValueAxis { min: 30; max: 110; tickInterval: 10; labelFormat: "%g" }

                // ── Data points ───────────────────────────────────────────────
                ScatterSeries {
                    name: "Score"
                    color: "#89b4fa"
                    //markerSize: 12
                    Component.onCompleted: {
                        var pts = dataProvider.scatterData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }

                // ── Trend line (pre-computed linear regression: y = 7.64x + 41.12) ──
                LineSeries {
                    name: "Trend"
                    color: "#f38ba8"
                    width: 2
                    Component.onCompleted: {
                        var pts = dataProvider.trendLineData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
            }

            ScatterChartTrendLineDescription {}
        }
    }
}
