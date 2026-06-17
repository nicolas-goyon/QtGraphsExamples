import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    BarChartLabelsDataProvider { id: dataProvider }

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
                text: "Bar Chart — Monthly Defect Rate % (with value labels)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisX: BarCategoryAxis {
                    Component.onCompleted: categories = dataProvider.categories()
                }
                axisY: ValueAxis { min: 0; max: 8; tickInterval: 1; labelFormat: "%g%%" }

                BarSeries {
                    labelsVisible: true
                    labelsFormat: "@value"
                    labelsPrecision: 2

                    BarSet {
                        label: "Defect Rate (%)"
                        Component.onCompleted: values = dataProvider.values()
                        color: "#6755e3"
                    }
                }
            }

            BarChartLabelsDescription {}
        }
    }
}
