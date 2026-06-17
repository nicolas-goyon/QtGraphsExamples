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
            text: "Sets GraphsView { orientation: Qt.Horizontal } to flip the bar chart so bars grow left-to-right. In horizontal mode, axisX becomes the vertical category axis (countries) and axisY becomes the horizontal value axis. Countries are ordered from smallest GDP at the top to largest at the bottom, which is the conventional ranking layout for this type of chart. Horizontal bars are preferable when category labels are long (country names, product names, etc.) because they read naturally left-to-right rather than being rotated."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/barchart/horizontal/BarChartHorizontalExample.qml",
                    "qml/2d/barchart/horizontal/BarChartHorizontalDataProvider.h",
                    "qml/2d/barchart/horizontal/BarChartHorizontalDataProvider.cpp",
                    "qml/2d/barchart/horizontal/BarChartHorizontalDescription.qml"
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
