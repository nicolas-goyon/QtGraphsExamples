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
            text: "This is a Sankey-style flow diagram showing the inputs and outputs of a system — here, a national energy balance. Five primary-energy INPUTS on the left (Coal, Natural Gas, Oil, Nuclear, Renewables) flow into a central 'Energy System' node, which then splits into five end-use OUTPUTS on the right (Electricity & Heat, Transport, Industry, Buildings, and Conversion Losses). The same structure works for a cash-flow statement or a CO₂ budget — just relabel the nodes.\n\nQt Graphs has no flow / Sankey series type, so the whole figure is drawn with the Qt Quick 2D Canvas API — the same pure-QML approach used by the heatmap and radar examples, with no GraphsView. Node bars are filled rectangles whose height is proportional to value; the connecting ribbons are filled cubic-bezier bands whose thickness equals the flow value. A single scale factor (pixels per unit) is shared by both columns and the centre node, so the segments meet flush.\n\nKey detail — conservation: the inputs sum to 340 PJ and so do the outputs, which equals the centre node's height. Because energy in must equal energy out, the input ribbons exactly tile the centre node's left edge and the output ribbons exactly tile its right edge, with no leftover gaps. If you change the data, keep sum(inputs) == sum(outputs) or the centre node's two edges will not line up. The layout recomputes on resize via requestPaint(), and the diagram is static (no hover interaction)."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/flowchart/basic/FlowChartExample.qml",
                    "qml/2d/flowchart/basic/FlowChartDescription.qml"
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
