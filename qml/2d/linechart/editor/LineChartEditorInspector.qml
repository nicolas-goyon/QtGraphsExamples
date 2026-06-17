// LineChartEditorInspector.qml
// The property panel for the Live Editor example.
// Accepts series state and axis state as QtObject references so that edits
// propagate back to the parent without extra signal plumbing.
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtGraphsExamples

Rectangle {
    id: root

    // ── Series state objects ──────────────────────────────────────────────
    // Each must expose: string name, string color, real lineWidth, real opacity
    // plus the dlg* point-delegate properties (see LineChartEditorExample.qml).
    property QtObject series0
    property QtObject series1
    property QtObject series2

    // ── Axis state objects ────────────────────────────────────────────────
    // Must expose: real min, real max, real tick, int sub, string fmt
    property QtObject xAxisState
    property QtObject yAxisState

    color: "#181825"; radius: 6
    border.color: "#313244"; border.width: 1
    clip: true

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width - 28
            x: 14; y: 14
            spacing: 6

            // ── Series ────────────────────────────────────────────────────
            EditorSectionLabel { title: "SERIES" }

            EditorSeriesPanel { series: root.series0 }
            EditorSeriesPanel { series: root.series1 }
            EditorSeriesPanel { series: root.series2 }

            // ── Axis X ────────────────────────────────────────────────────
            EditorSectionLabel { title: "AXIS X" }

            EditorNumericField {
                propLabel: "min"
                propValue: root.xAxisState ? root.xAxisState.min : 0
                step: 1; decimals: 0
                onCommit: function(val) {
                    if (root.xAxisState && val < root.xAxisState.max)
                        root.xAxisState.min = val
                }
            }
            EditorNumericField {
                propLabel: "max"
                propValue: root.xAxisState ? root.xAxisState.max : 10
                step: 1; decimals: 0
                onCommit: function(val) {
                    if (root.xAxisState && val > root.xAxisState.min)
                        root.xAxisState.max = val
                }
            }
            EditorNumericField {
                propLabel: "tickInterval"
                propValue: root.xAxisState ? root.xAxisState.tick : 1
                step: 0.5; decimals: 1; minValue: 0
                onCommit: function(val) {
                    if (root.xAxisState && val >= 0) root.xAxisState.tick = val
                }
            }
            EditorNumericField {
                propLabel: "subTickCount"
                propValue: root.xAxisState ? root.xAxisState.sub : 0
                step: 1; decimals: 0; minValue: 0; maxValue: 20
                onCommit: function(val) {
                    if (root.xAxisState) root.xAxisState.sub = Math.round(val)
                }
            }
            EditorPropField {
                propLabel: "labelFormat"
                propValue: root.xAxisState ? root.xAxisState.fmt : "%g"
                onCommit: function(val) { if (root.xAxisState) root.xAxisState.fmt = val }
            }

            // ── Axis Y ────────────────────────────────────────────────────
            EditorSectionLabel { title: "AXIS Y" }

            EditorNumericField {
                propLabel: "min"
                propValue: root.yAxisState ? root.yAxisState.min : 0
                step: 1; decimals: 0
                onCommit: function(val) {
                    if (root.yAxisState && val < root.yAxisState.max)
                        root.yAxisState.min = val
                }
            }
            EditorNumericField {
                propLabel: "max"
                propValue: root.yAxisState ? root.yAxisState.max : 40
                step: 1; decimals: 0
                onCommit: function(val) {
                    if (root.yAxisState && val > root.yAxisState.min)
                        root.yAxisState.max = val
                }
            }
            EditorNumericField {
                propLabel: "tickInterval"
                propValue: root.yAxisState ? root.yAxisState.tick : 5
                step: 0.5; decimals: 1; minValue: 0
                onCommit: function(val) {
                    if (root.yAxisState && val >= 0) root.yAxisState.tick = val
                }
            }
            EditorNumericField {
                propLabel: "subTickCount"
                propValue: root.yAxisState ? root.yAxisState.sub : 0
                step: 1; decimals: 0; minValue: 0; maxValue: 20
                onCommit: function(val) {
                    if (root.yAxisState) root.yAxisState.sub = Math.round(val)
                }
            }
            EditorPropField {
                propLabel: "labelFormat"
                propValue: root.yAxisState ? root.yAxisState.fmt : "%g"
                onCommit: function(val) { if (root.yAxisState) root.yAxisState.fmt = val }
            }

            Item { Layout.fillWidth: true; implicitHeight: 14 }
        }
    }
}
