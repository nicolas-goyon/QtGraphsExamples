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
            text: "Extends the basic radar chart to show multiple overlapping series. Three athlete archetypes are compared across the same five metrics: a Sprinter (fast, agile), a Powerlifter (dominant strength, lower endurance), and a Triathlete (balanced across all attributes).\n\nOverlapping polygons make strengths and gaps immediately visible. Each series is filled with a semi-transparent color so both shapes remain readable even when they overlap. The RadarChart component accepts any number of series and automatically assigns consistent colors, strokes, and dots per series.\n\nData points are rendered as small circles on each spoke so the exact value is clear even without hover interaction. For interactive tooltips and precise readout, the series data can be wired to a QML HoverHandler."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/radarchart/RadarChart.qml",
                    "qml/2d/radarchart/multiline/RadarChartMultiLineExample.qml",
                    "qml/2d/radarchart/multiline/RadarChartMultiLineDescription.qml"
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
