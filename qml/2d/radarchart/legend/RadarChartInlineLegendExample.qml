import QtQuick
import QtQuick.Layouts
import QtGraphsExamples

Item {
    id: root

    readonly property var seriesColors: ["#89b4fa", "#f38ba8", "#a6e3a1"]
    readonly property var seriesNames:  ["Sprinter", "Powerlifter", "Triathlete"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Radar Chart — Athlete Comparison with Inline Legend"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        // Chart + floating legend share the same Item
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                color: "#181825"
                radius: 8
                border.color: "#313244"; border.width: 1

                RadarChart {
                    anchors.fill: parent
                    anchors.margins: 16

                    axes: ["Speed", "Strength", "Endurance", "Agility", "Accuracy"]

                    series: [
                        { name: "Sprinter",    color: root.seriesColors[0], values: [95, 72, 55, 85, 78] },
                        { name: "Powerlifter", color: root.seriesColors[1], values: [60, 98, 45, 50, 62] },
                        { name: "Triathlete",  color: root.seriesColors[2], values: [75, 65, 92, 70, 80] }
                    ]
                }
            }

            // ── Inline legend overlay (top-right) ────────────────────────────
            Rectangle {
                anchors { top: parent.top; right: parent.right; margins: 20 }
                width: 120
                height: legendCol.implicitHeight + 16
                color: "#cc1e1e2e"
                radius: 6
                border.color: "#313244"; border.width: 1

                Column {
                    id: legendCol
                    anchors { fill: parent; margins: 8 }
                    spacing: 6

                    Text {
                        text: "Legend"
                        color: "#89b4fa"
                        font { bold: true; pixelSize: 11 }
                    }

                    Repeater {
                        model: seriesNames

                        Row {
                            spacing: 6
                            Rectangle {
                                width: 14; height: 3; radius: 1
                                color: seriesColors[index]
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: modelData
                                color: "#cdd6f4"
                                font.pixelSize: 11
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
        }

        RadarChartInlineLegendDescription {}
    }
}
