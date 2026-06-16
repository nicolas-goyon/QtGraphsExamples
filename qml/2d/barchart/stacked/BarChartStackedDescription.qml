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
            text: "Stacked bar chart showing monthly revenue broken down by plan tier "
                + "(Starter, Pro, Enterprise). Three BarSet objects are added to a single "
                + "BarSeries with barsType set to BarSeries.BarsType.Stacked — Qt Graphs "
                + "stacks the sets vertically within each category so totals are easy to "
                + "compare at a glance. Other available modes are BarsType.Groups (default, "
                + "side-by-side) and BarsType.StackedPercent (100 % normalised)."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/barchart/stacked/BarChartStackedExample.qml",
                    "qml/2d/barchart/stacked/BarChartStackedDataProvider.h",
                    "qml/2d/barchart/stacked/BarChartStackedDataProvider.cpp"
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
