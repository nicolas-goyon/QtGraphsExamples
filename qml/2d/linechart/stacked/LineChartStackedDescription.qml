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
            text: "Demonstrates a stacked line chart with hover-activated point labels. "
                + "Each LineSeries shows a cumulative sum: Marketing alone, Marketing+Engineering, "
                + "and the total (all three teams). The C++ provider returns individual values; "
                + "QML computes cumulative sums into three helper LineSeries defined outside "
                + "GraphsView (so they are not rendered), then copies their data into the "
                + "visible LineSeries at Component.onCompleted. "
                + "Grid: axisX.gridVisible is set to false to keep horizontal lines only. "
                + "Grid line thickness is reduced via GraphsTheme.grid.mainWidth. "
                + "Hover: each LineSeries has a pointDelegate with a HoverHandler. "
                + "All delegates share a root.hoveredX property — when any delegate at index X "
                + "is hovered, every series shows its circle and label at that X simultaneously. "
                + "A 30 ms debounce Timer on the root Item prevents flicker when the mouse "
                + "moves between delegates in the same column."
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
                    "qml/2d/linechart/stacked/LineChartStackedExample.qml",
                    "qml/2d/linechart/stacked/LineChartStackedDataProvider.h",
                    "qml/2d/linechart/stacked/LineChartStackedDataProvider.cpp",
                    "qml/2d/linechart/stacked/LineChartStackedDescription.qml"
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
