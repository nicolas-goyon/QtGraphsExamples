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
            text: "The same data-driven multi-layer Sankey as the Multi-Layer variant, with hover interaction added. A MouseArea over the Canvas tracks the cursor and hit-tests both nodes and flows. Hovering a node highlights it (bright outline) and brings forward every flow touching it; hovering a flow brings just that ribbon forward. Everything else dims, and a floating tooltip shows the exact value — so individual flow values stay revealed-on-demand instead of cluttering the diagram.\n\nHit-testing a node is a simple rectangle bounds check. Hit-testing a flow is the interesting part: each ribbon is a filled band between two cubic-bezier edges that share the same x(t) (the control points sit at the midpoint x). For a cursor at position px, a 24-step binary search solves x(t) = px for the curve parameter t, then the band's top edge y(t) and bottom edge y(t) are evaluated; the cursor hits the flow when its y lies between them. This is exact for the band shape and needs no per-pixel painting.\n\nOn each mouse move the handler recomputes the layout, runs the hit test, updates the hover state, and calls requestPaint(); the paint pass redraws ribbons with per-flow opacity based on what is hovered. Qt Graphs has no Sankey series — nodes, ribbons, and hit-testing are all implemented with the Qt Quick 2D Canvas API, no GraphsView."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/flowchart/hover/FlowChartHoverExample.qml",
                    "qml/2d/flowchart/hover/FlowChartHoverDescription.qml"
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
