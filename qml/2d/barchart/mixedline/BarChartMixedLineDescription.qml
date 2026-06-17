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
            text: "Combines a BarSeries (monthly revenue) and a LineSeries (3-month rolling average) in the same GraphsView. The key requirement is that both axisX (BarCategoryAxis) and axisY (ValueAxis) are set at the GraphsView level — not inside the BarSeries — so the LineSeries can share the same axis space. BarCategoryAxis maps category strings to integer positions 0, 1, 2 … n-1, so the LineSeries x values use the same integer indices. The rolling average smooths out month-to-month noise to reveal the underlying revenue trend."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/barchart/mixedline/BarChartMixedLineExample.qml",
                    "qml/2d/barchart/mixedline/BarChartMixedLineDataProvider.h",
                    "qml/2d/barchart/mixedline/BarChartMixedLineDataProvider.cpp",
                    "qml/2d/barchart/mixedline/BarChartMixedLineDescription.qml"
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
