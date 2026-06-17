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
            text: "Scatter Chart — Age vs. Income by Sector with Inline Legend"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            GraphsView {
                anchors.fill: parent

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

            // ── Inline legend overlay (top-left inside the chart area) ────────
            Rectangle {
                anchors { top: parent.top; left: parent.left; margins: 14 }
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

        ScatterChartInlineLegendDescription {}
    }
}
