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
            text: "Shows a line chart with a colored range band in the background. "
                + "The red zone marks the comfort temperature range (10–22 °C); the blue "
                + "line shows the monthly average temperature. When the line exits the "
                + "band the temperature is outside the comfortable zone. "
                + "Technique: two boundary LineSeries (minBound / maxBound) are declared "
                + "outside GraphsView so they act as data containers without being "
                + "rendered as lines. An AreaSeries inside GraphsView references them via "
                + "lowerSeries / upperSeries to fill only the colored band. The actual "
                + "data LineSeries is then drawn on top."
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
                    "qml/2d/linechart/range/LineChartRangeExample.qml",
                    "qml/2d/linechart/range/LineChartRangeDataProvider.h",
                    "qml/2d/linechart/range/LineChartRangeDataProvider.cpp",
                    "qml/2d/linechart/range/LineChartRangeDescription.qml"
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
