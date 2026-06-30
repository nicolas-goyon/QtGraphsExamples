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
            text: "This variant shows a PARTIAL intermediate layer — a stage that only some flows pass through. The example is a monthly cashflow. Salary and Freelance (earned income) are routed through a 'Tax' node that occupies a layer of its own; the Tax node then splits into Taxes Paid (money that leaves the system) and the remainder that continues to the Net Budget. Investments and Gift are not taxed here, so their links skip the Tax layer and connect straight from the income column to the Net Budget — these are 'skip-links' that span two layers at once and are drawn slightly lighter so the taxed flows read as primary.\n\nThe key idea is that nothing special is needed to make a layer partial. The renderer is the same generic layered Sankey as the Multi-Layer variant, where a link may connect any two layers, not just adjacent ones. A node placed in an intermediate layer therefore only affects the flows whose links actually touch it; every other flow simply routes around it as a longer ribbon. Ribbons are drawn before nodes, so a skip-link passes behind the partial node rather than over it.\n\nFlows are conserved at every node and overall ($4,500 of income equals $900 taxes plus $3,600 of spending). To make any layer partial, just route some links through a node in it and let the others span across. Qt Graphs has no Sankey series, so the figure is drawn with the Qt Quick 2D Canvas API — no GraphsView."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/flowchart/partial/FlowChartPartialExample.qml",
                    "qml/2d/flowchart/partial/FlowChartPartialDescription.qml"
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
