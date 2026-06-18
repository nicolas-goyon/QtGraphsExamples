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
            text: "Shows how to overlay a custom legend inside the chart area. The GraphsView and the legend Rectangle are both children of a plain Item set to fill the available space. The legend anchors to the top-right corner with a small margin and floats over the chart.\n\nThe legend is built from a Repeater over seriesNames, with matching seriesColors kept as a property on the root item. The same color array is passed to GraphsTheme.seriesColors so the series colors and legend swatches always stay in sync.\n\nSplineSeries is used instead of LineSeries to produce smooth Catmull-Rom curves through the data points."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/splinechart/legend/SplineChartInlineLegendExample.qml",
                    "qml/2d/splinechart/legend/SplineChartLegendDataProvider.h",
                    "qml/2d/splinechart/legend/SplineChartLegendDataProvider.cpp",
                    "qml/2d/splinechart/legend/SplineChartInlineLegendDescription.qml"
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
