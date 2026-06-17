import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root
    BarChartLegendDataProvider { id: dataProvider }

    readonly property var seriesColors: ["#f9e2af", "#89b4fa", "#a6e3a1", "#f38ba8"]
    readonly property var seriesNames:  ["Solar", "Wind", "Nuclear", "Gas"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Bar Chart — Monthly Electricity Generation (GWh) with Inline Legend"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        // Wrap chart + overlay in a plain Item so the legend can float inside it
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

                axisX: BarCategoryAxis {
                    categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
                }
                axisY: ValueAxis {
                    min: 0; max: 600
                    tickInterval: 100
                    labelFormat: "%g"
                }

                BarSeries {
                    BarSet {
                        label: "Solar"
                        Component.onCompleted: values = dataProvider.solarData()
                    }
                    BarSet {
                        label: "Wind"
                        Component.onCompleted: values = dataProvider.windData()
                    }
                    BarSet {
                        label: "Nuclear"
                        Component.onCompleted: values = dataProvider.nuclearData()
                    }
                    BarSet {
                        label: "Gas"
                        Component.onCompleted: values = dataProvider.gasData()
                    }
                }
            }

            // ── Inline legend overlay (top-right inside the chart area) ───────
            Rectangle {
                anchors { top: parent.top; right: parent.right; margins: 14 }
                width: 100
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
                                width: 12; height: 12; radius: 2
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

        BarChartInlineLegendDescription {}
    }
}
