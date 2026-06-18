import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root
    SplineChartLegendDataProvider { id: dataProvider }

    // Series colours — keep in sync with the legend overlay below
    readonly property var seriesColors: ["#89b4fa", "#f38ba8", "#a6e3a1"]
    readonly property var seriesNames:  ["Paris", "Miami", "Tokyo"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Spline Chart — Monthly Average Temperatures (°C) with Inline Legend"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        // Wrap chart + overlay in a plain Item so the legend can float inside it
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            GraphsView {
                id: chart
                anchors.fill: parent

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

            // ── Inline legend overlay (top-right inside the chart area) ───────
            Rectangle {
                anchors { top: parent.top; right: parent.right; margins: 14 }
                width: 90
                height: legendCol.implicitHeight + 16
                color: "#dd1e1e2e"
                radius: 6
                border.color: "#45475a"; border.width: 1

                Column {
                    id: legendCol
                    anchors { fill: parent; margins: 8 }
                    spacing: 5

                    Repeater {
                        model: seriesNames

                        Row {
                            spacing: 6
                            Rectangle {
                                width: 14; height: 3; radius: 1
                                color: seriesColors[index]
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: modelData
                                color: "#cdd6f4"
                                font.pixelSize: 11
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
        }

        SplineChartInlineLegendDescription {}
    }
}
