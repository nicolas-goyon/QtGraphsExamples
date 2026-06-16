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
            text: "Demonstrates a stacked area chart using three AreaSeries. "
                + "Qt Graphs has no built-in stacked area type; stacking is achieved "
                + "by computing cumulative sums in QML and wiring each layer's lowerSeries "
                + "to the upperSeries of the layer below. "
                + "The three boundary LineSeries (organicBound, orgDirectBound, totalBound) "
                + "are declared outside GraphsView so they act purely as data containers — "
                + "if placed inside GraphsView they would also be rendered as visible lines. "
                + "Each AreaSeries uses a semi-transparent fill (#40RRGGBB) so overlapping "
                + "edges stay readable."
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
                    "qml/2d/areachart/stacked/AreaChartStackedExample.qml",
                    "qml/2d/areachart/stacked/AreaChartStackedDataProvider.h",
                    "qml/2d/areachart/stacked/AreaChartStackedDataProvider.cpp",
                    "qml/2d/areachart/stacked/AreaChartStackedDescription.qml"
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
