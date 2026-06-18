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
            text: "Radar Chart — Athlete Comparison with Legend Below"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
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

        // ── Legend row below the chart ────────────────────────────────────────
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 24

            Repeater {
                model: seriesNames

                Row {
                    spacing: 8
                    Rectangle {
                        width: 18; height: 3; radius: 1
                        color: seriesColors[index]
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: modelData
                        color: "#cdd6f4"
                        font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        RadarChartSideLegendDescription {}
    }
}
