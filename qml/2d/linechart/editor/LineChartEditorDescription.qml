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
            text: "An interactive property explorer for LineSeries and ValueAxis. Edit any field and press Enter (or Tab away) to apply the change live to the chart.\n\nThe panel on the right covers:\n\n• Series — three collapsible cards, one per series (London, Madrid, Helsinki). Each exposes name, color (hex string), width, and an opacity range picker.\n• Axis X / Axis Y — min, max, tickInterval, subTickCount, labelFormat\n\nColour values follow CSS hex notation (e.g. \"#89b4fa\"). The labelFormat field accepts printf-style format strings as documented by ValueAxis. Non-ASCII characters such as ° are not supported in labelFormat."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/linechart/editor/LineChartEditorExample.qml",
                    "qml/2d/linechart/editor/LineChartEditorInspector.qml",
                    "qml/2d/linechart/editor/LineChartEditorDataProvider.h",
                    "qml/2d/linechart/editor/components/EditorSeriesPanel.qml",
                    "qml/2d/linechart/editor/components/EditorPropField.qml",
                    "qml/2d/linechart/editor/components/EditorPropSlider.qml",
                    "qml/2d/linechart/editor/components/EditorSectionLabel.qml"
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
