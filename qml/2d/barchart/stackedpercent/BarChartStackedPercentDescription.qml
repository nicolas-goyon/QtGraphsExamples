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
            text: "Uses BarSeries { barsType: BarSeries.BarsType.StackedPercent } to render a 100% stacked bar chart showing device-type session counts over six quarters. The raw counts (Mobile, Desktop, Tablet, Other) are passed directly to each BarSet — Qt Graphs automatically normalises each column to sum to 100%, so the Y axis always shows 0–100%. This makes it easy to compare proportional composition across time even when absolute totals change significantly. Use StackedPercent when the relative share matters more than absolute volume."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/barchart/stackedpercent/BarChartStackedPercentExample.qml",
                    "qml/2d/barchart/stackedpercent/BarChartStackedPercentDataProvider.h",
                    "qml/2d/barchart/stackedpercent/BarChartStackedPercentDataProvider.cpp",
                    "qml/2d/barchart/stackedpercent/BarChartStackedPercentDescription.qml"
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
