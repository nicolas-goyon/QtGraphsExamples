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
            text: "A generic, multi-layer Sankey diagram. Instead of the basic 'all inputs left, all outputs right' layout, the graph is described as a list of nodes — each tagged with the layer (column) it belongs to — plus a list of value-weighted links between them. This makes it possible to model a real system where flows enter and leave at different stages: Solar & Wind enters at layer 1 (it is an input, but not a primary one), and Conversion Losses leaves at layer 2 (an output that never reaches the final end-use column).\n\nThe renderer is data-driven. For each node it computes the total inflow and outflow and sizes the bar by max(inflow, outflow). Columns are laid out left to right by layer; within a column, nodes are stacked and the whole column is vertically centred. A single pixels-per-unit scale is chosen as the largest value that still lets every column fit the height. Links are then stacked along each node's right edge (outgoing) and left edge (incoming); to reduce visual crossings, the links at a node are ordered by the vertical centre of the node at their other end. Each link is drawn as a filled cubic-bezier ribbon whose thickness equals its value.\n\nThe flow is conserved: every intermediate node has inflow == outflow, and the four inputs (290 PJ total) equal the four outputs (290 PJ). To extend it, add nodes with a layer index and links between adjacent layers — the layout adapts automatically. This variant is static; see the 'With Hover' variant for interactive tooltips. Qt Graphs has no Sankey series, so everything is drawn with the Qt Quick 2D Canvas API — no GraphsView."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/flowchart/multilayer/FlowChartMultiLayerExample.qml",
                    "qml/2d/flowchart/multilayer/FlowChartMultiLayerDescription.qml"
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
