import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    ScatterChartAveragesDataProvider { id: dataProvider }

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
                text: "Scatter Chart — Monthly Sales with Averages"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // Chart + inline legend overlay
            Item {
                Layout.fillWidth: true
                implicitHeight: 340

                GraphsView {
                    anchors.fill: parent

                    theme: GraphsTheme {
                        colorScheme: GraphsTheme.ColorScheme.Dark
                        seriesColors: ["#cdd6f4", "#f38ba8", "#a6e3a1"]
                    }

                    axisX: ValueAxis { min: -1; max: 30; tickInterval: 5; labelFormat: "Month %g" }
                    axisY: ValueAxis { min: 20; max: 100; tickInterval: 10; labelFormat: "%g" }

                    ScatterSeries {
                        name: "Monthly Sales"
                        Component.onCompleted: {
                            var pts = dataProvider.scatterData()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }

                    LineSeries {
                        name: "Overall Mean"
                        color: "#f38ba8"
                        width: 2
                        Component.onCompleted: {
                            var pts = dataProvider.overallAverage()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }

                    SplineSeries {
                        name: "5-Month Rolling Avg"
                        color: "#a6e3a1"
                        width: 2
                        Component.onCompleted: {
                            var pts = dataProvider.rollingAverage()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }
                }

                // Inline legend overlay (top-left)
                Rectangle {
                    x: 100; y: 12
                    width: avgLegendCol.implicitWidth + 16
                    height: avgLegendCol.implicitHeight + 12
                    color: "#181825cc"; radius: 6
                    border.color: "#313244"; border.width: 1

                    Column {
                        id: avgLegendCol
                        x: 8; y: 6
                        spacing: 4

                        Repeater {
                            model: [
                                { label: "Monthly Sales",       color: "#cdd6f4" },
                                { label: "Overall Mean",        color: "#f38ba8" },
                                { label: "5-Month Rolling Avg", color: "#a6e3a1" }
                            ]
                            Row {
                                spacing: 6
                                Rectangle {
                                    width: 16; height: 3
                                    radius: 1
                                    color: modelData.color
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text {
                                    text: modelData.label
                                    color: "#cdd6f4"; font.pixelSize: 11
                                }
                            }
                        }
                    }
                }
            }

            ScatterChartAveragesDescription {}
        }
    }
}
