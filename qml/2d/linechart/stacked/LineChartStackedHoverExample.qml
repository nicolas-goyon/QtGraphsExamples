import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    LineChartStackedDataProvider { id: dataProvider }

    // ── Shared hover state ────────────────────────────────────────────────────
    property int hoveredX: -1

    // Debounce: prevents flicker when mouse moves between delegates in the same
    // column (one exits before the next enters). Entering delegates cancel it.
    Timer {
        id: clearHoverTimer
        interval: 30
        onTriggered: root.hoveredX = -1
    }

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
                text: "Line Chart — Stacked Team Activity (hover for values)"
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

                // ── Marketing (bottom cumulative line) ────────────────────────
                LineSeries {
                    name: "Marketing"
                    color: "#89b4fa"
                    width: 2
                    Component.onCompleted: {
                        for (var i = 0; i < mktLine.count; i++) append(mktLine.at(i).x, mktLine.at(i).y)
                    }
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 50; height: 50
                            HoverHandler {
                                onHoveredChanged: {
                                    if (hovered) { clearHoverTimer.stop(); root.hoveredX = Math.round(pointValueX) }
                                    else { clearHoverTimer.restart() }
                                }
                            }
                            property bool showMarker: root.hoveredX === Math.round(pointValueX)
                            Rectangle {
                                id: dot1
                                visible: showMarker
                                width: 10; height: 10; radius: 5
                                anchors.centerIn: parent
                                color: "#1e1e2e"
                                border.color: "#89b4fa"; border.width: 2
                            }
                            Text {
                                visible: showMarker
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: dot1.top; anchors.bottomMargin: 4
                                text: Math.round(pointValueY).toString()
                                color: "#89b4fa"
                                font { pixelSize: 11; bold: true }
                            }
                        }
                    }
                }

                // ── Marketing + Engineering (middle cumulative line) ───────────
                LineSeries {
                    name: "Mkt + Eng"
                    color: "#a6e3a1"
                    width: 2
                    Component.onCompleted: {
                        for (var i = 0; i < mktEngLine.count; i++) append(mktEngLine.at(i).x, mktEngLine.at(i).y)
                    }
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 50; height: 50
                            HoverHandler {
                                onHoveredChanged: {
                                    if (hovered) { clearHoverTimer.stop(); root.hoveredX = Math.round(pointValueX) }
                                    else { clearHoverTimer.restart() }
                                }
                            }
                            property bool showMarker: root.hoveredX === Math.round(pointValueX)
                            Rectangle {
                                id: dot2
                                visible: showMarker
                                width: 10; height: 10; radius: 5
                                anchors.centerIn: parent
                                color: "#1e1e2e"
                                border.color: "#a6e3a1"; border.width: 2
                            }
                            Text {
                                visible: showMarker
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: dot2.top; anchors.bottomMargin: 4
                                text: Math.round(pointValueY).toString()
                                color: "#a6e3a1"
                                font { pixelSize: 11; bold: true }
                            }
                        }
                    }
                }

                // ── Total (top cumulative line) ───────────────────────────────
                LineSeries {
                    name: "Total"
                    color: "#f38ba8"
                    width: 2
                    Component.onCompleted: {
                        for (var i = 0; i < totalLine.count; i++) append(totalLine.at(i).x, totalLine.at(i).y)
                    }
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 50; height: 50
                            HoverHandler {
                                onHoveredChanged: {
                                    if (hovered) { clearHoverTimer.stop(); root.hoveredX = Math.round(pointValueX) }
                                    else { clearHoverTimer.restart() }
                                }
                            }
                            property bool showMarker: root.hoveredX === Math.round(pointValueX)
                            Rectangle {
                                id: dot3
                                visible: showMarker
                                width: 10; height: 10; radius: 5
                                anchors.centerIn: parent
                                color: "#1e1e2e"
                                border.color: "#f38ba8"; border.width: 2
                            }
                            Text {
                                visible: showMarker
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: dot3.top; anchors.bottomMargin: 4
                                text: Math.round(pointValueY).toString()
                                color: "#f38ba8"
                                font { pixelSize: 11; bold: true }
                            }
                        }
                    }
                }
            }

            LineChartStackedHoverDescription {}
        }
    }
}
