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
            text: "Overlays four different regression curves on a ScatterSeries to illustrate how the same dataset can be described by different mathematical models. The 25 data points follow a roughly quadratic pattern with noise (x in [1,13]). Four LineSeries render the fitted trend lines — click any legend entry to toggle it on or off:\n\n• Linear (y = a + bx): ordinary least-squares straight-line fit.\n• Quadratic (y = a + bx + cx²): OLS via 3×3 normal equations — best match for this data.\n• Exponential (y = A·eᵇˣ): fit by linearising as ln(y) = ln(A) + bx.\n• Logarithmic (y = a + b·ln x): fit by substituting u = ln(x).\n\nAll coefficients are computed directly from the data at runtime using least-squares regression. Each curve uses 50 evenly-spaced points for visual smoothness."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/scatterchart/trendlines/ScatterChartTrendLinesExample.qml",
                    "qml/2d/scatterchart/trendlines/ScatterChartTrendLinesDataProvider.h",
                    "qml/2d/scatterchart/trendlines/ScatterChartTrendLinesDataProvider.cpp",
                    "qml/2d/scatterchart/trendlines/ScatterChartTrendLinesDescription.qml"
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
