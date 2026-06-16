import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    LineChartTargetDataProvider { id: dataProvider }

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
                text: "Line Chart — Yearly Sales vs Target (k$)"
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
                    min: 2015; max: 2024
                    tickInterval: 1
                    labelFormat: "%g"
                }
                axisY: ValueAxis {
                    min: 0; max: 140
                    tickInterval: 20
                    labelFormat: "$%g k"
                }

                // ── Actual yearly sales ───────────────────────────────────────
                LineSeries {
                    name: "Yearly Sales"
                    color: "#89b4fa"
                    width: 2

                    Component.onCompleted: {
                        var pts = dataProvider.salesData()
                        for (var i = 0; i < pts.length; i++)
                            append(pts[i].year, pts[i].value)
                    }
                }

                // ── Target line — two-point horizontal LineSeries ─────────────
                // Spans the full X range at y = targetValue().
                // Uses a contrasting colour so it reads clearly as a reference.
                LineSeries {
                    name: "Target ($100 k)"
                    color: "#f38ba8"
                    width: 2

                    Component.onCompleted: {
                        var t = dataProvider.targetValue()
                        append(2015, t)
                        append(2024, t)
                    }
                }
            }

            LineChartTargetDescription {}
        }
    }
}
