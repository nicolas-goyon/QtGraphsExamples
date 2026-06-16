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
            text: "Demonstrates live two-way binding between an editable table and a LineSeries. "
                + "The example is split into three QML components: "
                + "LineChartTableGraph (GraphsView + LineSeries + axis rescaling), "
                + "LineChartTableTable (the editable grid), and "
                + "LineChartTableExample (the parent that wires them together). "
                + "Initial data comes from the C++ LineChartTableDataProvider. "
                + "On every keystroke the Table emits valueChanged(index, value); "
                + "the Example forwards it to graph.updatePoint(), which calls "
                + "series.replace(index, x, newY) — the confirmed XYSeries API — then "
                + "rescans all points via series.at(i) to recompute yAxis.min/max. "
                + "ValueAxis has no autoScale property; tickInterval: 0 lets Qt Graphs "
                + "choose tick spacing automatically once min/max are set. "
                + "TextInput inside Rectangle is used instead of TextField to avoid "
                + "the native-style background customisation warning."
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
                    "qml/2d/linechart/table/LineChartTableExample.qml",
                    "qml/2d/linechart/table/LineChartTableGraph.qml",
                    "qml/2d/linechart/table/LineChartTableTable.qml",
                    "qml/2d/linechart/table/LineChartTableDataProvider.h",
                    "qml/2d/linechart/table/LineChartTableDataProvider.cpp",
                    "qml/2d/linechart/table/LineChartTableDescription.qml"
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
