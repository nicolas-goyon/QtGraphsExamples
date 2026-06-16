import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    BarChartBasicDataProvider { id: dataProvider }

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
                text: "Bar Chart — Quarterly Revenue (M$)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

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
}
