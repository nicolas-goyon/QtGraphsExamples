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
            text: "This heatmap is a pure QML custom implementation — it does not use GraphsView or any Qt Graphs series type. Instead, a Repeater inside a Column of Rows renders 7×24 = 168 colored rectangles, one per (day, hour) cell. Cell colors are computed by a JavaScript heatColor() function that linearly interpolates through a four-stop blue→cyan→green→yellow→red palette based on the traffic value (0–100). Tooltips show the exact value on hover.\n\nWhen to use this approach: Qt Graphs does not have a native heatmap series. Use this pattern for small-to-medium grids (up to a few thousand cells). For very large grids or animated heatmaps, consider a Canvas or ShaderEffect instead. The main limitation is that this implementation has no built-in zoom/pan or axis interaction."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/heatmap/basic/HeatmapExample.qml",
                    "qml/2d/heatmap/basic/HeatmapDescription.qml"
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
