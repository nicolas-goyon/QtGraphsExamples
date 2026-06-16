import QtQuick
import QtQuick.Layouts

// Description panel for LineChartBasicExample.
// Keep chart logic in LineChartBasicExample.qml / LineChartBasicDataProvider.
Rectangle {
    Layout.fillWidth: true
    implicitHeight: inner.implicitHeight + 24
    color: "#181825"
    radius: 8
    border.color: "#313244"
    border.width: 1

    ColumnLayout {
        id: inner
        anchors { fill: parent; margins: 12 }
        spacing: 8

        Text {
            text: "About this example"
            color: "#89b4fa"
            font { pixelSize: 13; bold: true }
        }

        TextEdit {
            Layout.fillWidth: true
            readOnly: true
            selectByMouse: true
            selectionColor: "#89b4fa"
            selectedTextColor: "#1e1e2e"
            wrapMode: TextEdit.WordWrap
            text: "A basic line chart with three series using Qt Graphs' GraphsView and LineSeries. "
                + "Plots monthly average temperatures (°C) for London, Madrid, and Helsinki across a full year. "
                + "Data is loaded from LineChartBasicDataProvider — swap that class to pull from a file or network."
            color: "#cdd6f4"
            font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }

        Text {
            text: "SOURCE FILES"
            color: "#6c7086"
            font { pixelSize: 10; bold: true; letterSpacing: 1 }
        }

        Column {
            Layout.fillWidth: true
            spacing: 3

            Repeater {
                model: [
                    "qml/2d/linechart/basic/LineChartBasicExample.qml",
                    "qml/2d/linechart/basic/LineChartBasicDataProvider.h",
                    "qml/2d/linechart/basic/LineChartBasicDataProvider.cpp",
                    "qml/2d/linechart/basic/LineChartBasicDescription.qml"
                ]
                TextEdit {
                    width: parent.width
                    readOnly: true
                    selectByMouse: true
                    selectionColor: "#89b4fa"
                    selectedTextColor: "#1e1e2e"
                    text: "▸  " + modelData
                    color: "#a6e3a1"
                    font { pixelSize: 11; family: "Consolas" }
                }
            }
        }
    }
}
