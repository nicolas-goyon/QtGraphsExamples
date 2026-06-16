import QtQuick
import QtQuick.Layouts

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
            text: "Demonstrates AreaSeries with both upperSeries and lowerSeries set. "
                + "The filled region between the two LineSeries shows London's monthly "
                + "temperature band (daily high vs daily low). "
                + "AreaSeries requires at least upperSeries to be set; "
                + "if lowerSeries is omitted the fill extends to the bottom of the graph. "
                + "The boundary LineSeries are defined as children of GraphsView so they "
                + "are visible as independent lines. To hide the boundary lines, define "
                + "them outside GraphsView (see the Stacked variant) and set only their "
                + "data via append()."
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
                    "qml/2d/areachart/basic/AreaChartBasicExample.qml",
                    "qml/2d/areachart/basic/AreaChartBasicDataProvider.h",
                    "qml/2d/areachart/basic/AreaChartBasicDataProvider.cpp",
                    "qml/2d/areachart/basic/AreaChartBasicDescription.qml"
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
