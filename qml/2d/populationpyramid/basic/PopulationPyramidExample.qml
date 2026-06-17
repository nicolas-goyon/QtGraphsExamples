import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphsExamples

Item {
    PopulationPyramidDataProvider { id: dataProvider }

    property var ageGroups: []
    property var womenVals: []
    property var menVals:   []

    Component.onCompleted: {
        ageGroups = dataProvider.ageGroups()
        womenVals = dataProvider.womenValues()
        menVals   = dataProvider.menValues()
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
                text: "Population Pyramid — Age Distribution by Gender (millions)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // Legend
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 24

                Row {
                    spacing: 6
                    Rectangle {
                        width: 14; height: 14; radius: 3
                        color: "#f38ba8"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "Women"
                        color: "#cdd6f4"; font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row {
                    spacing: 6
                    Rectangle {
                        width: 14; height: 14; radius: 3
                        color: "#89b4fa"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "Men"
                        color: "#cdd6f4"; font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // Column headers
            Item {
                Layout.fillWidth: true
                height: 18

                property real bArea: (width - 52) / 2

                Text {
                    x: 0; width: parent.bArea
                    text: "← Women"
                    horizontalAlignment: Text.AlignRight
                    color: "#f38ba8"; font { pixelSize: 11; bold: true }
                }
                Text {
                    x: parent.bArea + 52
                    width: parent.bArea
                    text: "Men →"
                    horizontalAlignment: Text.AlignLeft
                    color: "#89b4fa"; font { pixelSize: 11; bold: true }
                }
            }

            // Pyramid body
            Item {
                id: pyramidItem
                Layout.fillWidth: true
                implicitHeight: 16 * 26 + 15 * 3   // 16 bars × 26px + 15 gaps × 3px

                // maxVal slightly above the largest bar (4.1M men) for visual headroom
                readonly property real maxVal: 4.5
                // Width reserved per side for the value label text
                readonly property real textReserve: 36
                // Usable bar width per side
                property real bArea: (width - 52) / 2
                property real barMaxPx: Math.max(0, bArea - textReserve)

                Column {
                    anchors.fill: parent
                    spacing: 3

                    Repeater {
                        model: 16

                        Item {
                            width: pyramidItem.width
                            height: 26

                            readonly property real wVal: womenVals.length > index ? womenVals[index] : 0
                            readonly property real mVal: menVals.length > index   ? menVals[index]   : 0
                            readonly property real wPx:  Math.max(0, (wVal / pyramidItem.maxVal) * pyramidItem.barMaxPx)
                            readonly property real mPx:  Math.max(0, (mVal / pyramidItem.maxVal) * pyramidItem.barMaxPx)
                            readonly property real bArea: pyramidItem.bArea

                            // ── Women side (bar grows right→left from centre) ──────────────
                            Item {
                                x: 0; y: 0
                                width: bArea; height: parent.height
                                clip: true

                                // Bar: right-aligned (root at centre, tip towards left)
                                Rectangle {
                                    id: wBar
                                    width: wPx; height: 18; radius: 3
                                    color: "#f38ba8"
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                // Value at the left tip of the bar
                                Text {
                                    text: wVal.toFixed(1) + "M"
                                    color: "#cdd6f4"; font.pixelSize: 9
                                    anchors.right: wBar.left
                                    anchors.rightMargin: 4
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            // ── Age-group label (centre column, 52px) ────────────────────
                            Item {
                                x: bArea; y: 0
                                width: 52; height: parent.height

                                Text {
                                    anchors.centerIn: parent
                                    text: ageGroups.length > index ? ageGroups[index] : ""
                                    color: "#a6adc8"; font.pixelSize: 9
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }

                            // ── Men side (bar grows left→right from centre) ───────────────
                            Item {
                                x: bArea + 52; y: 0
                                width: bArea; height: parent.height
                                clip: true

                                // Bar: left-aligned (root at centre, tip towards right)
                                Rectangle {
                                    id: mBar
                                    width: mPx; height: 18; radius: 3
                                    color: "#89b4fa"
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                // Value at the right tip of the bar
                                Text {
                                    text: mVal.toFixed(1) + "M"
                                    color: "#cdd6f4"; font.pixelSize: 9
                                    anchors.left: mBar.right
                                    anchors.leftMargin: 4
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }
                }
            }

            PopulationPyramidDescription {}
        }
    }
}
