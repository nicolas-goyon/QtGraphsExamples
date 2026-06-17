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
            text: "Demonstrates an inline legend on a Bars3D chart. Because 3D graph types do not "
                + "expose a native legend property, a semi-transparent Rectangle overlay is anchored "
                + "to the top-right corner of the parent Item and layered above the Bars3D view. "
                + "Two Bar3DSeries compare Urban vs. Rural population (millions, 2020) across "
                + "six countries. Each series uses a distinct baseColor matched by the swatch in the overlay."
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
                    "qml/3d/bars3d/legend/Bars3DInlineLegendExample.qml",
                    "qml/3d/bars3d/legend/Bars3DLegendDataProvider.h",
                    "qml/3d/bars3d/legend/Bars3DLegendDataProvider.cpp",
                    "qml/3d/bars3d/legend/Bars3DInlineLegendDescription.qml"
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
