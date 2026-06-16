import QtQuick
import QtQuick.Layouts

// Description panel for Bars3DBasicExample.
// Keep chart logic in Bars3DBasicExample.qml / Bars3DBasicDataProvider.
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
            text: "A basic 3D bar chart using Qt Graphs' Bars3D, Bar3DSeries, and ItemModelBarDataProxy. "
                + "Displays sales figures across four regions (North, South, East, West) and four quarters (Q1–Q4). "
                + "Data is supplied via Bars3DBasicDataProvider (a QAbstractListModel) — swap it to load from a file or network."
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
                    "qml/3d/bars3d/basic/Bars3DBasicExample.qml",
                    "qml/3d/bars3d/basic/Bars3DBasicDataProvider.h",
                    "qml/3d/bars3d/basic/Bars3DBasicDataProvider.cpp",
                    "qml/3d/bars3d/basic/Bars3DBasicDescription.qml"
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
