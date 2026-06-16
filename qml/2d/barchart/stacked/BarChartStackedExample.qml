import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    BarChartStackedDataProvider { id: dataProvider }

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
                text: "Bar Chart — Stacked SaaS Revenue by Plan (k$)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisY: ValueAxis { min: 0; max: 160; tickInterval: 20; labelFormat: "$%g k" }

                BarSeries {
                    barsType: BarSeries.BarsType.Stacked
                    axisX: BarCategoryAxis {
                        Component.onCompleted: categories = dataProvider.categories()
                    }
                    BarSet {
                        label: "Starter"
                        Component.onCompleted: values = dataProvider.starterValues()
                    }
                    BarSet {
                        label: "Pro"
                        Component.onCompleted: values = dataProvider.proValues()
                    }
                    BarSet {
                        label: "Enterprise"
                        Component.onCompleted: values = dataProvider.enterpriseValues()
                    }
                }
            }

            BarChartStackedDescription {}
        }
    }
}
