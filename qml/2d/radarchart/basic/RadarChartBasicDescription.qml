import QtQuick
import QtQuick.Layouts

Rectangle {
    Layout.fillWidth: true
    implicitHeight: inner.implicitHeight + 24
    color: "#181825"; radius: 8
    border.color: "#313244"; border.width: 1

    ColumnLayout {
        id: inner
        anchors { fill: parent; margins: 12 }
        spacing: 8

        Text { text: "About this example"; color: "#89b4fa"; font { pixelSize: 13; bold: true } }

        TextEdit {
            Layout.fillWidth: true
            readOnly: true; selectByMouse: true
            selectionColor: "#89b4fa"; selectedTextColor: "#1e1e2e"
            wrapMode: TextEdit.WordWrap
            text: "Demonstrates a custom radar (spider) chart built with Qt Quick Canvas. Qt Graphs does not provide a native radar type, so the chart is implemented as a reusable RadarChart Canvas component.\n\nA radar chart maps multiple quantitative variables onto axes radiating from a common center point. Each variable's value is plotted as a distance from the center, and consecutive points are connected to form a polygon. The overall shape makes it easy to compare a subject's strengths and weaknesses across all dimensions at a glance.\n\nThis basic example shows a single series (a Sprinter's performance across five athletic metrics). The radial grid, spoke lines, and scale labels are all drawn programmatically using the 2D Canvas API."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/radarchart/RadarChart.qml",
                    "qml/2d/radarchart/basic/RadarChartBasicExample.qml",
                    "qml/2d/radarchart/basic/RadarChartBasicDescription.qml"
                ]
                TextEdit {
                    width: parent.width; readOnly: true; selectByMouse: true
                    selectionColor: "#89b4fa"; selectedTextColor: "#1e1e2e"
                    text: "▸  " + modelData; color: "#a6e3a1"
                    font { pixelSize: 11; family: "Consolas" }
                }
            }
        }
    }
}
