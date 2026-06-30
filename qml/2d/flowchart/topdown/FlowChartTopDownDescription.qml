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
            text: "A top-down (vertical) Sankey. It uses the same data-driven layered model as the Multi-Layer variant — nodes with a layer index plus value-weighted links — but the orientation is rotated 90°: layers run from top to bottom, node bars are horizontal rectangles (width proportional to value), and flows are downward cubic-bezier ribbons. The geometry is the mirror of the horizontal renderer with the x and y axes swapped: a single pixels-per-unit scale is shared across rows, each row is centred horizontally, and links are stacked along each node's bottom edge (outgoing) and top edge (incoming), ordered by the opposite endpoint's centre x to limit crossings.\n\nThe data is a web conversion funnel. 1,000 sessions arrive from four traffic sources and funnel into Browse; 650 bounce while 350 add to cart; of those, 180 purchase and 170 are abandoned. Visitors leave the funnel as 'sink' nodes (Bounce, Purchase, Abandoned) at different layers, which is why the rows narrow as you go down — the classic funnel shape falls out naturally from a conserved Sankey. Totals balance: 1,000 in equals 1,000 out.\n\nTop-down orientation suits funnels, org charts, and process flows that are conventionally read downward. Qt Graphs has no Sankey series, so the diagram is drawn entirely with the Qt Quick 2D Canvas API — no GraphsView."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/flowchart/topdown/FlowChartTopDownExample.qml",
                    "qml/2d/flowchart/topdown/FlowChartTopDownDescription.qml"
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
