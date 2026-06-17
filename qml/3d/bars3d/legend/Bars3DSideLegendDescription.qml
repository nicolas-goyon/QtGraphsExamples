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
            text: "Demonstrates a legend placed below a Bars3D chart. A custom Row of coloured-square "
                + "swatch + label pairs is rendered in the ColumnLayout beneath the Bars3D Item. "
                + "Two Bar3DSeries compare Urban vs. Rural population (millions, 2020) across "
                + "six countries. Placing the legend outside the 3D viewport avoids occluding the bars "
                + "and works regardless of camera angle."
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
                    "qml/3d/bars3d/legend/Bars3DSideLegendExample.qml",
                    "qml/3d/bars3d/legend/Bars3DLegendDataProvider.h",
                    "qml/3d/bars3d/legend/Bars3DLegendDataProvider.cpp",
                    "qml/3d/bars3d/legend/Bars3DSideLegendDescription.qml"
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
