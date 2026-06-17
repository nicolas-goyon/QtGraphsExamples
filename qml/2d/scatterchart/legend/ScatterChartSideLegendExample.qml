import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root
    ScatterChartLegendDataProvider { id: dataProvider }

    readonly property var seriesColors: ["#89b4fa", "#a6e3a1", "#f9e2af", "#f38ba8"]
    readonly property var seriesNames:  ["Tech", "Healthcare", "Education", "Finance"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Scatter Chart — Age vs. Income by Sector with Legend Aside"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        // ── Chart + side legend ───────────────────────────────────────────────
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 12

            GraphsView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                    seriesColors: root.seriesColors
                }

                axisX: ValueAxis {
                    min: 22; max: 62
                    tickInterval: 5
                    labelFormat: "%g yrs"
                }
                axisY: ValueAxis {
                    min: 0; max: 330
                    tickInterval: 50
                    labelFormat: "$%gK"
                }

                ScatterSeries {
                    name: "Tech"
                    Component.onCompleted: {
                        var pts = dataProvider.techData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                ScatterSeries {
                    name: "Healthcare"
                    Component.onCompleted: {
                        var pts = dataProvider.healthcareData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                ScatterSeries {
                    name: "Education"
                    Component.onCompleted: {
                        var pts = dataProvider.educationData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                ScatterSeries {
                    name: "Finance"
                    Component.onCompleted: {
                        var pts = dataProvider.financeData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
            }

            // ── Legend column (right of chart only) ───────────────────────────
            Rectangle {
                Layout.preferredWidth: 120
                Layout.fillHeight: true
                color: "#1e1e2e"
                radius: 6
                border.color: "#313244"; border.width: 1

                Column {
                    anchors { top: parent.top; left: parent.left; right: parent.right; margins: 12 }
                    spacing: 12

                    Text {
                        text: "Sectors"
                        color: "#89b4fa"
                        font { bold: true; pixelSize: 11 }
                    }

                    Repeater {
                        model: seriesNames

                        Row {
                            spacing: 6
                            Rectangle {
                                width: 10; height: 10; radius: 5
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

        ScatterChartSideLegendDescription {}
    }
}
