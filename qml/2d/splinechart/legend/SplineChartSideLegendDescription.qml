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
            text: "Shows how to add a legend row below the chart. The ColumnLayout contains the chart (Layout.fillHeight: true) followed by a Row of legend items. Each legend item pairs a color swatch Rectangle with a Text label.\n\nThe seriesColors array is kept as a property on the root item and is passed to both GraphsTheme.seriesColors (so the series pick up the right colors) and to the legend Repeater (so the swatches match).\n\nSplineSeries is used instead of LineSeries to produce smooth Catmull-Rom curves through the data points."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/splinechart/legend/SplineChartSideLegendExample.qml",
                    "qml/2d/splinechart/legend/SplineChartLegendDataProvider.h",
                    "qml/2d/splinechart/legend/SplineChartLegendDataProvider.cpp",
                    "qml/2d/splinechart/legend/SplineChartSideLegendDescription.qml"
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
