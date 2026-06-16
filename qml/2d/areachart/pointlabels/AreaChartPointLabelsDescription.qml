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
            text: "Demonstrates per-point circle markers with value labels using XYSeries.pointDelegate. "
                + "Qt Graphs has no pointLabelsVisible or pointLabelsFormat properties (those belonged "
                + "to the older Qt Charts module). Instead, a fully custom QML Component is assigned "
                + "to pointDelegate on the LineSeries. Qt Graphs instantiates it once per data point "
                + "and centres the Item on the point coordinates. Dynamic properties injected into the "
                + "delegate are: pointColor, pointValueX, pointValueY (and pointIndex since 6.9). "
                + "These must be declared with 'property <type> <name>' inside the Item to receive values. "
                + "The AreaSeries references the same LineSeries as upperSeries and uses a "
                + "transparent borderColor so only the LineSeries border (and its point delegates) "
                + "are visible, avoiding a doubled border line."
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
                    "qml/2d/areachart/pointlabels/AreaChartPointLabelsExample.qml",
                    "qml/2d/areachart/pointlabels/AreaChartPointLabelsDataProvider.h",
                    "qml/2d/areachart/pointlabels/AreaChartPointLabelsDataProvider.cpp",
                    "qml/2d/areachart/pointlabels/AreaChartPointLabelsDescription.qml"
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
