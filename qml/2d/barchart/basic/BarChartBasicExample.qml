import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    BarChartBasicDataProvider { id: dataProvider }

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

            theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

            axisY: ValueAxis { min: 0; max: 120; tickInterval: 20; labelFormat: "$%g M" }

            BarSeries {
                axisX: BarCategoryAxis {
                    Component.onCompleted: categories = dataProvider.categories()
                }
                BarSet {
                    label: "Product A"
                    Component.onCompleted: values = dataProvider.productAValues()
                }
                BarSet {
                    label: "Product B"
                    Component.onCompleted: values = dataProvider.productBValues()
                }
                BarSet {
                    label: "Product C"
                    Component.onCompleted: values = dataProvider.productCValues()
                }
            }
        }

        BarChartBasicDescription {}
    }
}
