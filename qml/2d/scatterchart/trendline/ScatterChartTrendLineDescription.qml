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
            text: "Overlays a LineSeries on the ScatterSeries to show the linear regression. The trend line endpoints are pre-computed in C++ (slope 7.64, intercept 41.12 for the study-hours/score dataset) and returned as two {x,y} points. Qt Graphs draws both series on the same axes automatically."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: ["qml/2d/scatterchart/trendline/ScatterChartTrendLineExample.qml","qml/2d/scatterchart/trendline/ScatterChartTrendLineDataProvider.h","qml/2d/scatterchart/trendline/ScatterChartTrendLineDataProvider.cpp","qml/2d/scatterchart/trendline/ScatterChartTrendLineDescription.qml"]
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
