import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphsExamples

// Parent that wires DataProvider → ListModel → Graph + Table.
// Flow:
//   1. DataProvider.initialData() supplies [{month, value}, ...]
//   2. Component.onCompleted populates dataModel (ListModel) and calls graph.loadData()
//   3. Table emits valueChanged(index, value) → graph.updatePoint() rescales + redraws
Item {
    id: root

    // ── Data ─────────────────────────────────────────────────────────────────
    LineChartTableDataProvider { id: dp }

    ListModel { id: dataModel }

    Component.onCompleted: {
        var data = dp.initialData()
        for (var i = 0; i < data.length; i++)
            dataModel.append(data[i])
        graph.loadData(data)
    }

    // ── Layout ────────────────────────────────────────────────────────────────
    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        contentHeight: content.implicitHeight + 32

        ColumnLayout {
            id: content
            x: 16; y: 16
            width: parent.width - 32
            spacing: 8

            Text {
                text: "Line Chart — Monthly Unit Sales (editable table)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // ── Graph component ───────────────────────────────────────────────────
            LineChartTableGraph {
                id: graph
                Layout.fillWidth: true
            }

            // ── Hint label ────────────────────────────────────────────────────────
            Text {
                text: "Edit any value — the chart rescales and redraws instantly"
                color: "#6c7086"
                font.pixelSize: 11
            }

            // ── Table component ───────────────────────────────────────────────────
            LineChartTableTable {
                id: table
                Layout.fillWidth: true
                tableModel: dataModel
                onValueChanged: (idx, val) => graph.updatePoint(idx, val)
            }

            // ── Description ───────────────────────────────────────────────────────
            LineChartTableDescription {}
        }
    }
}
