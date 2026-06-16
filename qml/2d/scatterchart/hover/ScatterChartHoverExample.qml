import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    ScatterChartHoverDataProvider { id: dataProvider }

    // Shared hover state — stores the hovered point's data
    property string hoveredName: ""
    property real   hoveredCpu:  -1
    property real   hoveredMem:  -1

    Timer {
        id: clearTimer
        interval: 40
        onTriggered: { root.hoveredName = ""; root.hoveredCpu = -1; root.hoveredMem = -1 }
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
                text: "Scatter Chart — CPU vs Memory per Process (hover for details)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisX: ValueAxis { min: 0; max: 28;   tickInterval: 4;   labelFormat: "%g%%" }
                axisY: ValueAxis { min: 0; max: 2800;  tickInterval: 400; labelFormat: "%g MB" }

                ScatterSeries {
                    name: "Processes"
                    color: "transparent"
                    Component.onCompleted: {
                        var procs = dataProvider.processData()
                        for (var i = 0; i < procs.length; i++) append(procs[i].cpu, procs[i].mem)
                    }

                    pointDelegate: Component {
                        Item {
                            // Standard point properties
                            property color  pointColor
                            property real   pointValueX   // CPU %
                            property real   pointValueY   // Memory MB
                            // Extra data injected at model level isn't available here,
                            // so the tooltip shows the numeric values directly.

                            width: 48; height: 48

                            HoverHandler {
                                onHoveredChanged: {
                                    if (hovered) {
                                        clearTimer.stop()
                                        root.hoveredCpu = pointValueX
                                        root.hoveredMem = pointValueY
                                    } else {
                                        clearTimer.restart()
                                    }
                                }
                            }

                            property bool active: root.hoveredCpu === pointValueX
                                               && root.hoveredMem === pointValueY

                            // Dot
                            Rectangle {
                                id: dot
                                anchors.centerIn: parent
                                width: active ? 14 : 10
                                height: active ? 14 : 10
                                radius: width / 2
                                color: active ? "#cba6f7" : "#89b4fa"
                                Behavior on width  { NumberAnimation { duration: 80 } }
                                Behavior on height { NumberAnimation { duration: 80 } }
                            }

                            // Tooltip bubble (shown on hover)
                            Rectangle {
                                visible: active
                                anchors.bottom: dot.top
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottomMargin: 6
                                width: label.width + 16
                                height: label.height + 10
                                radius: 4
                                color: "#313244"
                                border.color: "#cba6f7"
                                border.width: 1

                                Text {
                                    id: label
                                    anchors.centerIn: parent
                                    text: pointValueX.toFixed(1) + "% CPU\n"
                                        + pointValueY.toFixed(0) + " MB"
                                    color: "#cdd6f4"
                                    font { pixelSize: 10; bold: true }
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }
                }
            }

            ScatterChartHoverDescription {}
        }
    }
}
