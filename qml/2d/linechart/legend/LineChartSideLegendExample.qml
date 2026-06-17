import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root
    LineChartLegendDataProvider { id: dataProvider }

    readonly property var seriesColors: ["#89b4fa", "#a6e3a1", "#f9e2af", "#f38ba8", "#cba6f7"]
    readonly property var seriesNames:  ["Apple", "Google", "Microsoft", "Amazon", "Meta"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Line Chart — Revenue Growth (%) with Legend Below"
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

        LineChartSideLegendDescription {}
    }
}
