import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1000
    height: 680
    title: "Qt Graphs Examples"

    // ── Sidebar ──────────────────────────────────────────────
    Rectangle {
        id: sidebar
        width: 180
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        color: "#1e1e2e"

        Column {
            anchors.fill: parent
            anchors.topMargin: 16
            spacing: 4

            Text {
                text: "Qt Graphs"
                color: "#cdd6f4"
                font { pixelSize: 18; bold: true }
                anchors.horizontalCenter: parent.horizontalCenter
                bottomPadding: 12
            }

            Repeater {
                model: ["Line Chart", "Bar Chart", "Scatter Chart", "3D Bars", "3D Surface"]
                delegate: Rectangle {
                    width: sidebar.width - 16
                    height: 40
                    radius: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: stack.currentIndex === index ? "#89b4fa" : "transparent"

                    Text {
                        text: modelData
                        color: stack.currentIndex === index ? "#1e1e2e" : "#cdd6f4"
                        font.pixelSize: 13
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: stack.currentIndex = index
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }

    // ── Content area ─────────────────────────────────────────
    StackLayout {
        id: stack
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: sidebar.right
            right: parent.right
        }

        LineChartExample  {}
        BarChartExample   {}
        ScatterChartExample {}
        Bars3DExample     {}
        Surface3DExample  {}
    }
}
