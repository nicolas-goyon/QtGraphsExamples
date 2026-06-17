import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    SplineChartBasicDataProvider { id: dataProvider }

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
                text: "Spline Chart — Monthly Average Temperatures (°C)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    seriesColors: ["#89b4fa", "#f38ba8", "#a6e3a1"]
                }

                axisX: ValueAxis { min: 1; max: 12; tickInterval: 1; labelFormat: "%g" }
                axisY: ValueAxis { min: 0; max: 36; tickInterval: 5; labelFormat: "%g°C" }

                // Shared point delegate — Qt Graphs injects pointColor from the series colour
                Component {
                    id: dotDelegate
                    Rectangle {
                        property color pointColor
                        width: 8; height: 8; radius: 4
                        color: pointColor
                        x: -4; y: -4
                    }
                }

                SplineSeries {
                    name: "Paris"
                    Component.onCompleted: {
                        // Load data first, then assign delegate so Qt Graphs never sees 0 points
                        var pts = dataProvider.parisData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        pointDelegate = dotDelegate
                    }
                }

                SplineSeries {
                    name: "Miami"
                    Component.onCompleted: {
                        var pts = dataProvider.miamiData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        pointDelegate = dotDelegate
                    }
                }

                SplineSeries {
                    name: "Tokyo"
                    Component.onCompleted: {
                        var pts = dataProvider.tokyoData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        pointDelegate = dotDelegate
                    }
                }
            }

            SplineChartBasicDescription {}
        }
    }
}
