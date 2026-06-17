import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    BarChartStackedPercentDataProvider { id: dataProvider }

    // Pre-computed totals per category used by barDelegate to calculate percentages
    property var catTotals: []
    Component.onCompleted: catTotals = dataProvider.categoryTotals()

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
                text: "Bar Chart — Device Usage Share by Quarter (100% Stacked)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    seriesColors: ["#89b4fa", "#a6e3a1", "#f9e2af", "#f38ba8"]
                }

                axisX: BarCategoryAxis {
                    categories: ["Q1 '22", "Q2 '22", "Q3 '22", "Q4 '22", "Q1 '23", "Q2 '23"]
                }
                axisY: ValueAxis { min: 0; max: 100; tickInterval: 20; labelFormat: "%g%%" }

                BarSeries {
                    barsType: BarSeries.BarsType.StackedPercent

                    // Custom bar delegate: draws the bar and shows raw count + percentage
                    barDelegate: Component {
                        Rectangle {
                            property color barColor
                            property real  barValue
                            property int   barIndex

                            color: barColor
                            radius: 2

                            Text {
                                anchors.centerIn: parent
                                visible: parent.height > 22
                                text: {
                                    var total = catTotals.length > barIndex ? catTotals[barIndex] : 0
                                    if (total <= 0) return ""
                                    var pct = (barValue / total * 100).toFixed(1)
                                    return barValue.toFixed(0) + "\n" + pct + "%"
                                }
                                color: "#1e1e2e"
                                font { pixelSize: 9; bold: true }
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }

                    BarSet {
                        label: "Mobile"
                        Component.onCompleted: values = dataProvider.mobileData()
                    }
                    BarSet {
                        label: "Desktop"
                        Component.onCompleted: values = dataProvider.desktopData()
                    }
                    BarSet {
                        label: "Tablet"
                        Component.onCompleted: values = dataProvider.tabletData()
                    }
                    BarSet {
                        label: "Other"
                        Component.onCompleted: values = dataProvider.otherData()
                    }
                }
            }

            BarChartStackedPercentDescription {}
        }
    }
}
