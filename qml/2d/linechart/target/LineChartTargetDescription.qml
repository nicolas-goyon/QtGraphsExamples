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
            text: "Demonstrates how to overlay a horizontal reference line on a LineSeries chart. "
                + "Yearly sales data (2015–2024) is provided by the C++ LineChartTargetDataProvider. "
                + "The target line is a second LineSeries with only two points — one at the left "
                + "edge of the X axis and one at the right — both at the target Y value (100 k$). "
                + "Both series share the same ValueAxis pair, so the reference line is always "
                + "perfectly aligned with the data axis. A contrasting colour (red-pink) "
                + "distinguishes the target from the actual sales series (blue)."
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
                    "qml/2d/linechart/target/LineChartTargetExample.qml",
                    "qml/2d/linechart/target/LineChartTargetDataProvider.h",
                    "qml/2d/linechart/target/LineChartTargetDataProvider.cpp",
                    "qml/2d/linechart/target/LineChartTargetDescription.qml"
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
