import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    BarChartMixedLineDataProvider { id: dataProvider }

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
                text: "Mixed Chart — Monthly Revenue with 3-Month Rolling Average"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    seriesColors: ["#89b4fa", "#f38ba8"]
                }

                // Axes at view level so both BarSeries and LineSeries share them
                axisX: BarCategoryAxis {
                    Component.onCompleted: categories = dataProvider.months()
                }
                axisY: ValueAxis { min: 0; max: 110; tickInterval: 20; labelFormat: "$%g M" }

                BarSeries {
                    BarSet {
                        label: "Revenue"
                        Component.onCompleted: values = dataProvider.revenueValues()
                    }
                }

                // BarCategoryAxis maps categories to integer positions 0..n-1.
                // LineSeries x values use the same 0-based integer index.
                LineSeries {
                    name: "3M Rolling Avg"
                    color: "#f38ba8"
                    width: 2
                    Component.onCompleted: {
                        var pts = dataProvider.avgValues()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
            }

            BarChartMixedLineDescription {}
        }
    }
}
