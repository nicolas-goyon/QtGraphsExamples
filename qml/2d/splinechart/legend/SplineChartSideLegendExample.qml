import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root
    SplineChartLegendDataProvider { id: dataProvider }

    readonly property var seriesColors: ["#89b4fa", "#f38ba8", "#a6e3a1"]
    readonly property var seriesNames:  ["Paris", "Miami", "Tokyo"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Spline Chart — Monthly Average Temperatures (°C) with Legend Below"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        GraphsView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            theme: GraphsTheme {
                colorScheme: GraphsTheme.ColorScheme.Dark
                plotAreaBackgroundVisible: true
                seriesColors: root.seriesColors
            }

            axisX: ValueAxis { min: 1; max: 12; tickInterval: 1; labelFormat: "%g" }
            axisY: ValueAxis { min: 0; max: 36; tickInterval: 5; labelFormat: "%g°C" }

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

        // ── Legend row (below chart) ──────────────────────────────────────────
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Repeater {
                model: seriesNames

                Row {
                    spacing: 6
                    Rectangle {
                        width: 18; height: 3; radius: 1
                        color: seriesColors[index]
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: modelData
                        color: "#cdd6f4"
                        font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        SplineChartSideLegendDescription {}
    }
}
