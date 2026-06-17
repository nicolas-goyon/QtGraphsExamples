import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    BarChartHorizontalDataProvider { id: dataProvider }

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
                text: "Horizontal Bar — GDP by Country (Trillion USD, 2023)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                orientation: Qt.Horizontal

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    seriesColors: ["#89b4fa"]
                }

                // With orientation: Qt.Horizontal, axisX is the category axis
                // rendered vertically, axisY is the value axis rendered horizontally.
                axisX: BarCategoryAxis {
                    Component.onCompleted: categories = dataProvider.countries()
                }
                axisY: ValueAxis { min: 0; max: 28; tickInterval: 5; labelFormat: "$%g T" }

                BarSeries {
                    BarSet {
                        label: "GDP"
                        Component.onCompleted: values = dataProvider.gdpValues()
                    }
                }
            }

            BarChartHorizontalDescription {}
        }
    }
}
