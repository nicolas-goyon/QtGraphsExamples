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
            text: "Demonstrates a legend panel placed to the right of a scatter chart. A RowLayout "
                + "puts the GraphsView on the left and a fixed-width Rectangle column on the right, "
                + "listing each ScatterSeries with a circular swatch. Four series plot age vs. "
                + "annual income ($K) for Tech, Healthcare, Education, and Finance workers. "
                + "This side-panel layout suits wide screens where horizontal space is available."
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
                    "qml/2d/scatterchart/legend/ScatterChartSideLegendExample.qml",
                    "qml/2d/scatterchart/legend/ScatterChartLegendDataProvider.h",
                    "qml/2d/scatterchart/legend/ScatterChartLegendDataProvider.cpp",
                    "qml/2d/scatterchart/legend/ScatterChartSideLegendDescription.qml"
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
