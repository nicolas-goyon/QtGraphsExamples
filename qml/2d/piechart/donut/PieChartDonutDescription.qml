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
            text: "Demonstrates how to turn a PieSeries into a donut (ring) chart by setting the holeSize property to a value between 0.0 and 1.0. A holeSize of 0.45 punches a hole that is 45% of the chart's diameter, leaving a ring of 40% width (pieSize 0.85 minus holeSize 0.45).\n\nAll other PieSeries and PieSlice properties are identical to the basic pie chart — labels, colors, and values work exactly the same way. The donut shape is purely a visual variation controlled by a single property change.\n\nKey properties:\n• holeSize (0.0–1.0, default 0): radius of the inner hole as a fraction of the view size. Must be less than pieSize.\n• pieSize (0.0–1.0, default ~0.7): outer radius of the ring as a fraction of the view size."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/piechart/donut/PieChartDonutExample.qml",
                    "qml/2d/piechart/donut/PieChartDonutDescription.qml"
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
