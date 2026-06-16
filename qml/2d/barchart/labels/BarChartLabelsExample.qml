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
                text: "Bar Chart — Monthly Defect Count (with value labels)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisY: ValueAxis { min: 0; max: 80; tickInterval: 10; labelFormat: "%g" }

                BarSeries {
                    labelsVisible: true
                    labelsFormat: "@value"

                    axisX: BarCategoryAxis {
                        Component.onCompleted: categories = dataProvider.categories()
                    }
                    BarSet {
                        label: "Defects"
                        Component.onCompleted: values = dataProvider.values()
                        color :"#6755e3"
                    }
                }
            }

            BarChartLabelsDescription {}
        }
    }
}
