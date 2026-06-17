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
            text: "Demonstrates a gradient colour-bar legend placed beside a Surface3D chart. A "
                + "RowLayout puts the Surface3D on the left and a fixed-width Rectangle panel on "
                + "the right, containing a vertical gradient bar with min/max height labels. "
                + "The terrain is a double-peak Gaussian surface coloured from deep blue (low) "
                + "to red (high). Placing the legend outside the 3D viewport keeps the view "
                + "unobscured regardless of camera angle."
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
                    "qml/3d/surface3d/legend/Surface3DSideLegendExample.qml",
                    "qml/3d/surface3d/legend/Surface3DLegendDataProvider.h",
                    "qml/3d/surface3d/legend/Surface3DLegendDataProvider.cpp",
                    "qml/3d/surface3d/legend/Surface3DSideLegendDescription.qml"
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
