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
            text: "Demonstrates PieSeries inside a GraphsView. PieSeries does not use axisX or axisY — it fills the view area automatically. Each PieSlice declares a label, a value, and a color. Qt Graphs automatically normalises the values to percentages (Chrome 65.2 out of the total), so you pass raw values and the chart handles the proportions.\n\nKey properties:\n• pieSize (0.0–1.0): controls how much of the view the pie occupies.\n• labelVisible: true on each slice to show the label.\n• holeSize (0.0–1.0, default 0): set to a non-zero value (e.g. 0.4) to turn the pie into a donut chart.\n\nThe C++ data provider (PieChartBasicDataProvider) is registered as a QML element for consistency with other examples, though in this case the slices are declared statically in QML for simplicity."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/piechart/basic/PieChartBasicExample.qml",
                    "qml/2d/piechart/basic/PieChartBasicDataProvider.h",
                    "qml/2d/piechart/basic/PieChartBasicDataProvider.cpp",
                    "qml/2d/piechart/basic/PieChartBasicDescription.qml"
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
