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
            text: "Each ScatterSeries uses a pointDelegate: Component to replace the default round marker with a custom shape. Blog: filled circle (Rectangle with radius). Social: diamond (Rectangle rotated 45 degrees). Email: cross (two overlapping Rectangles). The series color is set to transparent so Qt Graphs draws nothing — all rendering comes from the delegate."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: ["qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersExample.qml","qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersDataProvider.h","qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersDataProvider.cpp","qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersDescription.qml"]
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
