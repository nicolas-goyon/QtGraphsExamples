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
            text: "Stacked area chart with labels placed directly inside each colored band. "
                + "Technique: three transparent single-point LineSeries are added inside "
                + "GraphsView, each with its one point positioned at the vertical midpoint "
                + "of its band (x=5, mid-chart). Their pointDelegate renders only a bold "
                + "text label with no dot — since color is \"transparent\" and the delegate "
                + "has no Rectangle, nothing extra is drawn. Qt Graphs positions the delegate "
                + "item centered on the chart coordinate, placing the label naturally inside "
                + "the corresponding area."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }

        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/areachart/stackedlabels/AreaChartStackedInlineLabelsExample.qml",
                    "qml/2d/areachart/stackedlabels/AreaChartStackedInlineLabelsDescription.qml",
                    "qml/2d/areachart/stacked/AreaChartStackedDataProvider.h  (shared)"
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
