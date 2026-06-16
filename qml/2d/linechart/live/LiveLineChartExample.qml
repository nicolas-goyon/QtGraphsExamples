import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs

Item {
    id: root

    property real price:          65.0
    property int  tick:           0
    readonly property int window: 30

    // ── Live update ───────────────────────────────────────────────────────────
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            root.tick++
            root.price = Math.max(15, Math.min(115, root.price + (Math.random() - 0.5) * 8))
            priceLine.append(root.tick, root.price)
            if (priceLine.count > root.window) priceLine.remove(0)
            axisX.min = root.tick - root.window + 1
            axisX.max = root.tick
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

            Row {
                spacing: 12
                Text {
                    text: "Live Line Chart — Simulated Stock Price"
                    font { pixelSize: 16; bold: true }
                    color: "#cdd6f4"
                    anchors.verticalCenter: parent.verticalCenter
                }
                // Live price badge
                Rectangle {
                    width: badge.width + 16; height: 24; radius: 4
                    color: "#313244"
                    border.color: "#89b4fa"; border.width: 1
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: badge
                        anchors.centerIn: parent
                        text: "$" + root.price.toFixed(2)
                        color: "#89b4fa"
                        font { pixelSize: 12; bold: true }
                    }
                }
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
                    id: axisX
                    min: 0; max: root.window - 1
                    tickInterval: 5
                    labelFormat: "%g s"
                }
                axisY: ValueAxis {
                    min: 0; max: 130
                    tickInterval: 20
                    labelFormat: "$%g"
                }

                LineSeries {
                    id: priceLine
                    name: "Price"
                    color: "#89b4fa"
                    width: 2

                    Component.onCompleted: {
                        for (var i = 0; i < root.window; i++) {
                            root.price = Math.max(15, Math.min(115, root.price + (Math.random() - 0.5) * 8))
                            append(i, root.price)
                        }
                        root.tick = root.window - 1
                    }
                }
            }

            LiveLineChartDescription {}
        }
    }
}
