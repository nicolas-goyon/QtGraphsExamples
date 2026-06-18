import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphsExamples

Item {

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
                text: "Radar Chart — Athlete Performance Profile"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // Dark card containing the chart
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 400
                color: "#181825"
                radius: 8
                border.color: "#313244"; border.width: 1

                RadarChart {
                    anchors.fill: parent
                    anchors.margins: 16

                    axes: ["Speed", "Strength", "Endurance", "Agility", "Accuracy"]

                    series: [
                        {
                            name:   "Sprinter",
                            color:  "#89b4fa",
                            values: [95, 72, 55, 85, 78]
                        }
                    ]
                }
            }

            RadarChartBasicDescription {}
        }
    }
}
