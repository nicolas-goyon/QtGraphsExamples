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
            text: "A population pyramid uses a diverging horizontal bar chart to compare two groups (here: Women and Men) across age cohorts. Women's values are stored as negatives so their bars extend left, while Men's values are positive and extend right. This is achieved using GraphsView { orientation: Qt.Horizontal } which swaps the axis rendering: axisX becomes the vertical category axis (age groups) and axisY becomes the horizontal value axis. A single BarSeries with two BarSets and barsType: Groups renders both sides simultaneously. The zero line in the centre acts as the visual divider between the two genders."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/populationpyramid/basic/PopulationPyramidExample.qml",
                    "qml/2d/populationpyramid/basic/PopulationPyramidDataProvider.h",
                    "qml/2d/populationpyramid/basic/PopulationPyramidDataProvider.cpp",
                    "qml/2d/populationpyramid/basic/PopulationPyramidDescription.qml"
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
