import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    AreaChartPointLabelsDataProvider { id: dataProvider }

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
                text: "Area Chart — Monthly Recurring Revenue (MRR)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                    grid.mainWidth : 0
                    grid.subWidth : 0
                }

                axisX: ValueAxis {
                    min: 0; max: 5
                    gridVisible: false
                    tickInterval: 1
                    labelFormat: "%g"
                }
                axisY: ValueAxis {
                    min: 0; max: 1100
                    gridVisible: false
                    tickInterval: 200
                    labelFormat: "$%g"
                }

                // ── Upper boundary line with custom point markers ─────────────
                // pointDelegate is defined here (on LineSeries / XYSeries).
                // The delegate Item's centre is placed at each data point.
                // Dynamic properties declared inside the Item are injected by
                // Qt Graphs: pointValueX, pointValueY, pointColor.
                LineSeries {
                    id: mrrLine
                    color: "#cba6f7"
                    width: 2

                    Component.onCompleted: {
                        var pts = dataProvider.mrrData()
                        for (var i = 0; i < pts.length; i++) append(i, pts[i])
                    }

                    pointDelegate: Component {
                        Item {
                            // Dynamic properties injected by Qt Graphs
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY

                            // Size the item to hold the circle + label above it.
                            // The item is centred on the data point, so the
                            // label (upper half) and circle (lower half) straddle it.
                            width:  64
                            height: 44

                            // Value label — upper half of the item
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: dot.top
                                anchors.bottomMargin: 4
                                text: "$" + Math.round(pointValueY)
                                color: "#cdd6f4"
                                font { pixelSize: 11; bold: true }
                            }

                            // Circle marker centred on the data point
                            Rectangle {
                                id: dot
                                width: 10; height: 10; radius: 5
                                anchors.centerIn: parent
                                color:        "#1e1e2e"   // dark fill → open-circle look
                                border.color: "#cba6f7"   // purple border matches line
                                border.width: 2
                            }
                        }
                    }
                }

                // ── Filled area below the line ────────────────────────────────
                // lowerSeries omitted → fills from graph bottom to mrrLine.
                AreaSeries {
                    name: "MRR"
                    color:       "#40cba6f7"    // purple ~25 % opacity
                    borderColor: "transparent"  // border drawn by mrrLine above
                    upperSeries: mrrLine
                }
            }

            AreaChartPointLabelsDescription {}
        }
    }
}
