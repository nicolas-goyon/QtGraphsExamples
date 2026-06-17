import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root
    LineChartLegendDataProvider { id: dataProvider }

    // Series colours — keep in sync with the legend overlay below
    readonly property var seriesColors: ["#89b4fa", "#a6e3a1", "#f9e2af", "#f38ba8", "#cba6f7"]
    readonly property var seriesNames:  ["Apple", "Google", "Microsoft", "Amazon", "Meta"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Line Chart — Revenue Growth (%) with Inline Legend"
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

                axisX: ValueAxis {
                    min: 0; max: 4
                    tickInterval: 1
                    labelFormat: "%g"
                }
                axisY: ValueAxis {
                    min: -15; max: 50
                    tickInterval: 10
                    labelFormat: "%g%%"
                }

                LineSeries {
                    name: "Apple"
                    Component.onCompleted: {
                        var pts = dataProvider.appleData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: "Google"
                    Component.onCompleted: {
                        var pts = dataProvider.googleData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: "Microsoft"
                    Component.onCompleted: {
                        var pts = dataProvider.microsoftData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: "Amazon"
                    Component.onCompleted: {
                        var pts = dataProvider.amazonData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: "Meta"
                    Component.onCompleted: {
                        var pts = dataProvider.metaData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
            }

            // ── Inline legend overlay (top-right inside the chart area) ───────
            Rectangle {
                anchors { top: parent.top; right: parent.right; margins: 14 }
                width: 110
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

        LineChartInlineLegendDescription {}
    }
}
