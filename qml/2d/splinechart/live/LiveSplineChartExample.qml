import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs

Item {
    id: root

    property real heartRate: 72.0
    property int  tick:      0
    readonly property int window: 30

    // ── Live update ───────────────────────────────────────────────────────────
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            root.tick++
            root.heartRate = Math.max(50, Math.min(110, root.heartRate + (Math.random() - 0.5) * 10))
            bpmSeries.append(root.tick, root.heartRate)
            if (bpmSeries.count > root.window) bpmSeries.remove(0)
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
                    text: "Live Spline Chart — Simulated Heart Rate"
                    font { pixelSize: 16; bold: true }
                    color: "#cdd6f4"
                    anchors.verticalCenter: parent.verticalCenter
                }
                // Live BPM badge
                Rectangle {
                    width: badge.width + 16; height: 24; radius: 4
                    color: "#313244"
                    border.color: "#f38ba8"; border.width: 1
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: badge
                        anchors.centerIn: parent
                        text: root.heartRate.toFixed(0) + " BPM"
                        color: "#f38ba8"
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
                    min: 30; max: 130
                    tickInterval: 20
                    labelFormat: "%g"
                }

                SplineSeries {
                    id: bpmSeries
                    name: "Heart Rate"
                    color: "#f38ba8"
                    width: 2

                    Component.onCompleted: {
                        for (var i = 0; i < root.window; i++) {
                            root.heartRate = Math.max(50, Math.min(110, root.heartRate + (Math.random() - 0.5) * 10))
                            append(i, root.heartRate)
                        }
                        root.tick = root.window - 1
                    }
                }
            }

            LiveSplineChartDescription {}
        }
    }
}
