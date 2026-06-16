import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    LineChartStackedDataProvider { id: dataProvider }

    // ── Cumulative boundary series (defined outside GraphsView) ───────────────
    // Not children of GraphsView → not rendered as independent lines.
    LineSeries { id: mktLine    }  // Marketing               (bottom)
    LineSeries { id: mktEngLine }  // Marketing + Engineering (middle)
    LineSeries { id: totalLine  }  // Marketing + Eng + Sales (top)

    Component.onCompleted: {
        var mkt = dataProvider.marketingData()
        var eng = dataProvider.engineeringData()
        var sal = dataProvider.salesData()
        for (var i = 0; i < mkt.length; i++) {
            mktLine.append(i,    mkt[i])
            mktEngLine.append(i, mkt[i] + eng[i])
            totalLine.append(i,  mkt[i] + eng[i] + sal[i])
        }
    }

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
                text: "Line Chart — Stacked Team Activity"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                    grid.mainWidth: 0.5
                }

                axisX: ValueAxis {
                    min: 0; max: 5
                    tickInterval: 1
                    labelFormat: "%g"
                    gridVisible: false
                }
                axisY: ValueAxis {
                    min: 0; max: 130
                    tickInterval: 20
                    labelFormat: "%g"
                }

                LineSeries {
                    name: "Marketing"
                    color: "#89b4fa"
                    width: 2
                    Component.onCompleted: {
                        for (var i = 0; i < mktLine.count; i++) append(mktLine.at(i).x, mktLine.at(i).y)
                    }
                }

                LineSeries {
                    name: "Mkt + Eng"
                    color: "#a6e3a1"
                    width: 2
                    Component.onCompleted: {
                        for (var i = 0; i < mktEngLine.count; i++) append(mktEngLine.at(i).x, mktEngLine.at(i).y)
                    }
                }

                LineSeries {
                    name: "Total"
                    color: "#f38ba8"
                    width: 2
                    Component.onCompleted: {
                        for (var i = 0; i < totalLine.count; i++) append(totalLine.at(i).x, totalLine.at(i).y)
                    }
                }
            }

            LineChartStackedDescription {}
        }
    }
}
