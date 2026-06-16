import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs

Item {
    id: root

    property real usage:          52.0   // current memory usage %
    property int  tick:           0
    readonly property int window: 30

    // ── Boundary series (outside GraphsView — updated by timer) ───────────────
    // AreaSeries inside GraphsView references this as upperSeries.
    LineSeries { id: upperBound }

    Component.onCompleted: {
        for (var i = 0; i < root.window; i++) {
            root.usage = Math.max(10, Math.min(90, root.usage + (Math.random() - 0.5) * 5))
            upperBound.append(i, root.usage)
        }
        root.tick = root.window - 1
    }

    // ── Live update ───────────────────────────────────────────────────────────
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            root.tick++
            root.usage = Math.max(10, Math.min(90, root.usage + (Math.random() - 0.5) * 5))
            upperBound.append(root.tick, root.usage)
            if (upperBound.count > root.window) upperBound.remove(0)
            areaAxisX.min = root.tick - root.window + 1
            areaAxisX.max = root.tick
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
                    text: "Live Area Chart — Server Memory Usage"
                    font { pixelSize: 16; bold: true }
                    color: "#cdd6f4"
                    anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle {
                    width: badge.width + 16; height: 24; radius: 4
                    color: "#313244"
                    border.color: "#a6e3a1"; border.width: 1
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: badge
                        anchors.centerIn: parent
                        text: root.usage.toFixed(1) + "%"
                        color: "#a6e3a1"
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
                    id: areaAxisX
                    min: 0; max: root.window - 1
                    tickInterval: 5
                    labelFormat: "%g s"
                }
                axisY: ValueAxis {
                    min: 0; max: 100
                    tickInterval: 20
                    labelFormat: "%g%"
                }

                AreaSeries {
                    name: "Memory"
                    color: "#40a6e3a1"
                    borderColor: "#a6e3a1"
                    borderWidth: 2
                    upperSeries: upperBound
                }
            }

            LiveAreaChartDescription {}
        }
    }
}
