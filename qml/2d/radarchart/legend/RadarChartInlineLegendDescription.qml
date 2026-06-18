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
            text: "Shows the inline (floating) legend pattern applied to a multi-series radar chart. The chart Rectangle and the legend Rectangle are both children of a plain Item that fills the available space. The legend is anchored to the top-right corner and floats over the chart.\n\nThe seriesColors and seriesNames arrays are declared as properties on the root item so both the RadarChart series list and the Repeater-driven legend swatches reference the same values — the two are guaranteed to stay in sync. The legend uses a semi-transparent dark background so the chart is still partially visible underneath."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/radarchart/RadarChart.qml",
                    "qml/2d/radarchart/legend/RadarChartInlineLegendExample.qml",
                    "qml/2d/radarchart/legend/RadarChartInlineLegendDescription.qml"
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
