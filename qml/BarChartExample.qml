import QtQuick
import QtQuick.Layouts
import QtGraphs

Item {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Bar Chart — Quarterly Revenue (M$)"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        GraphsView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            theme: GraphsTheme {
                colorScheme: GraphsTheme.ColorScheme.Dark
            }

            axisY: ValueAxis {
                min: 0
                max: 120
                tickInterval: 20
                labelFormat: "$%g M"
            }

            BarSeries {
                axisX: BarCategoryAxis {
                    categories: ["Q1", "Q2", "Q3", "Q4"]
                }

                BarSet {
                    label: "Product A"
                    values: [52, 61, 74, 88]
                }
                BarSet {
                    label: "Product B"
                    values: [38, 45, 55, 70]
                }
                BarSet {
                    label: "Product C"
                    values: [21, 29, 40, 58]
                }
            }
        }
    }
}
