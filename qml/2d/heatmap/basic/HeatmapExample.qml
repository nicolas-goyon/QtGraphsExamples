import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    // Traffic data: 7 days x 24 hours (row-major: day 0=Mon .. 6=Sun, hour 0..23)
    // Values 0-100 representing relative traffic intensity
    readonly property var trafficData: [
        // Mon (day 0)
         8, 6, 5, 4, 5, 8,20,45,75,88,90,92,90,88,85,82,78,65,50,38,28,22,16,12,
        // Tue (day 1)
         9, 7, 5, 4, 5, 9,22,48,78,90,92,94,92,90,87,84,80,67,52,40,30,24,17,11,
        // Wed (day 2)
        10, 7, 6, 4, 5, 8,21,46,76,89,91,93,91,89,86,83,79,66,51,39,29,23,16,12,
        // Thu (day 3)
         9, 7, 5, 4, 6, 9,23,50,80,91,93,95,93,91,88,85,81,68,53,41,31,25,18,13,
        // Fri (day 4)
        10, 8, 6, 5, 6,10,24,52,82,92,93,94,92,90,86,82,76,62,55,48,40,34,26,18,
        // Sat (day 5)
        15,10, 8, 6, 7,10,16,25,38,50,60,68,70,68,65,60,54,46,40,34,28,22,18,14,
        // Sun (day 6)
        14, 9, 7, 6, 7,10,14,22,34,46,55,62,65,63,60,56,50,43,36,30,24,20,16,12
    ]

    readonly property var dayLabels:  ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    readonly property var hourLabels: ["0","1","2","3","4","5","6","7","8","9","10","11",
                                       "12","13","14","15","16","17","18","19","20","21","22","23"]

    function heatColor(v) {
        // 0-25: blue -> cyan
        // 25-50: cyan -> green
        // 50-75: green -> yellow
        // 75-100: yellow -> red
        var r, g, b, t
        if (v <= 25) {
            t = v / 25.0
            r = Qt.rgba(0x22/255, 0x55/255 + t*(0xaa/255 - 0x55/255), 0xcc/255, 1.0)
            return r
        } else if (v <= 50) {
            t = (v - 25) / 25.0
            return Qt.rgba(0x22/255, 0xaa/255 + t*(0xcc/255 - 0xaa/255), 0xcc/255 - t*(0xcc/255), 1.0)
        } else if (v <= 75) {
            t = (v - 50) / 25.0
            return Qt.rgba(0x22/255 + t*(0xf9/255 - 0x22/255), 0xcc/255 + t*(0xe2/255 - 0xcc/255), t*(0xaf/255), 1.0)
        } else {
            t = (v - 75) / 25.0
            return Qt.rgba(0xf9/255 + t*(0xdd/255 - 0xf9/255), 0xe2/255 - t*(0xe2/255), 0xaf/255 - t*(0xaf/255), 1.0)
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
                text: "Heatmap — Website Traffic by Hour & Day of Week"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // Heatmap container
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: heatmapCol.implicitHeight + 16
                color: "#181825"; radius: 8
                border.color: "#313244"; border.width: 1

                Column {
                    id: heatmapCol
                    x: 8; y: 8
                    spacing: 2

                    // Hour header row
                    Row {
                        spacing: 2
                        // Day label spacer
                        Item { width: 36; height: 18 }
                        Repeater {
                            model: hourLabels
                            Text {
                                width: 28; height: 18
                                text: modelData
                                color: "#6c7086"; font.pixelSize: 9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    // Data rows (one per day)
                    Repeater {
                        model: 7
                        Row {
                            spacing: 2
                            readonly property int dayIndex: index

                            // Day label
                            Text {
                                width: 36; height: 28
                                text: dayLabels[dayIndex]
                                color: "#cdd6f4"; font.pixelSize: 11
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                rightPadding: 4
                            }

                            // 24 hour cells
                            Repeater {
                                model: 24
                                Rectangle {
                                    width: 28; height: 28
                                    radius: 3
                                    readonly property int val: trafficData[dayIndex * 24 + index]
                                    color: heatColor(val)

                                    ToolTip.visible: hoverHandler.hovered
                                    ToolTip.text: dayLabels[dayIndex] + " " + hourLabels[index] + ":00 — " + val + "%"
                                    ToolTip.delay: 400

                                    HoverHandler { id: hoverHandler }
                                }
                            }
                        }
                    }

                    // Color legend
                    Item { width: 1; height: 8 }

                    Row {
                        x: 38
                        spacing: 0

                        Text {
                            text: "Low"
                            color: "#6c7086"; font.pixelSize: 10
                            anchors.verticalCenter: parent.verticalCenter
                            rightPadding: 6
                        }

                        // Gradient bar
                        Rectangle {
                            width: 200; height: 14; radius: 3
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop { position: 0.0;  color: Qt.rgba(0x22/255, 0x55/255, 0xcc/255, 1) }
                                GradientStop { position: 0.25; color: Qt.rgba(0x22/255, 0xaa/255, 0xcc/255, 1) }
                                GradientStop { position: 0.50; color: Qt.rgba(0x22/255, 0xcc/255, 0x00,      1) }
                                GradientStop { position: 0.75; color: Qt.rgba(0xf9/255, 0xe2/255, 0xaf/255,  1) }
                                GradientStop { position: 1.0;  color: Qt.rgba(0xdd/255, 0x22/255, 0x22/255,  1) }
                            }
                        }

                        Text {
                            text: "High"
                            color: "#6c7086"; font.pixelSize: 10
                            anchors.verticalCenter: parent.verticalCenter
                            leftPadding: 6
                        }
                    }
                }
            }

            HeatmapDescription {}
        }
    }
}
