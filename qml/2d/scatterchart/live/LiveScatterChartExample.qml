import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs

Item {
    id: root

    // Process A: CPU-heavy (high CPU, moderate memory)
    property real cpuA: 72.0
    property real memA: 3200.0

    // Process B: Memory-heavy (low CPU, high memory)
    property real cpuB: 12.0
    property real memB: 6400.0

    // ── Live update ───────────────────────────────────────────────────────────
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            root.cpuA = Math.max(45, Math.min(95,   root.cpuA + (Math.random() - 0.5) * 12))
            root.memA = Math.max(1500, Math.min(5000, root.memA + (Math.random() - 0.5) * 300))
            seriesA.append(root.cpuA, root.memA)
            if (seriesA.count > 20) seriesA.remove(0)

            root.cpuB = Math.max(3, Math.min(30,    root.cpuB + (Math.random() - 0.5) * 5))
            root.memB = Math.max(5000, Math.min(8000, root.memB + (Math.random() - 0.5) * 200))
            seriesB.append(root.cpuB, root.memB)
            if (seriesB.count > 20) seriesB.remove(0)
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
                text: "Live Scatter Chart — CPU % vs Memory MB (2 processes)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // Live value badges
            Row {
                spacing: 16

                Row {
                    spacing: 6
                    Rectangle { width: 10; height: 10; radius: 5; color: "#89b4fa"; anchors.verticalCenter: parent.verticalCenter }
                    Text {
                        text: "Process A — " + root.cpuA.toFixed(1) + "% / " + root.memA.toFixed(0) + " MB"
                        color: "#89b4fa"; font { pixelSize: 12; bold: true }
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row {
                    spacing: 6
                    Rectangle { width: 10; height: 10; radius: 5; color: "#f38ba8"; anchors.verticalCenter: parent.verticalCenter }
                    Text {
                        text: "Process B — " + root.cpuB.toFixed(1) + "% / " + root.memB.toFixed(0) + " MB"
                        color: "#f38ba8"; font { pixelSize: 12; bold: true }
                        anchors.verticalCenter: parent.verticalCenter
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

                axisX: ValueAxis { min: 0;    max: 100;  tickInterval: 20; labelFormat: "%g%%" }
                axisY: ValueAxis { min: 0;    max: 9000; tickInterval: 1000; labelFormat: "%g MB" }

                // ── Process A — filled circles ────────────────────────────────
                ScatterSeries {
                    id: seriesA
                    name: "Process A"
                    color: "#89b4fa"
                    //markerSize: 10

                    Component.onCompleted: {
                        for (var i = 0; i < 20; i++) {
                            root.cpuA = Math.max(45, Math.min(95,   root.cpuA + (Math.random()-0.5)*12))
                            root.memA = Math.max(1500, Math.min(5000, root.memA + (Math.random()-0.5)*300))
                            append(root.cpuA, root.memA)
                        }
                    }
                }

                // ── Process B — filled circles ────────────────────────────────
                ScatterSeries {
                    id: seriesB
                    name: "Process B"
                    color: "#f38ba8"
                    //markerSize: 10

                    Component.onCompleted: {
                        for (var i = 0; i < 20; i++) {
                            root.cpuB = Math.max(3, Math.min(30,    root.cpuB + (Math.random()-0.5)*5))
                            root.memB = Math.max(5000, Math.min(8000, root.memB + (Math.random()-0.5)*200))
                            append(root.cpuB, root.memB)
                        }
                    }
                }
            }

            LiveScatterChartDescription {}
        }
    }
}
