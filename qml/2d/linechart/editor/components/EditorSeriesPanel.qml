// EditorSeriesPanel.qml
// Bordered card that exposes the editable properties of one LineSeries,
// including an optional point-delegate configuration section.
// Pass a QtObject with the expected properties as `series`.
import QtQuick
import QtQuick.Layouts
import QtGraphsExamples

Rectangle {
    id: root

    // Expected series QtObject properties:
    //   string name, string color, real lineWidth, real opacity
    //   bool   dlgEnabled, bool dlgShowDot, real dlgDotSize
    //   bool   dlgShowLabel, string dlgLabelAxis ("x"|"y"), int dlgLabelDecimals
    //   real   dlgLabelFontSize, string dlgLabelColor, real dlgLabelOffsetY
    property QtObject series

    Layout.fillWidth: true
    color: "#1e1e2e"; radius: 6
    border.color: "#313244"; border.width: 1
    implicitHeight: inner.implicitHeight + 20

    ColumnLayout {
        id: inner
        anchors { left: parent.left; right: parent.right; top: parent.top; margins: 10 }
        spacing: 5

        // ── Header: colour dot + series name ─────────────────────────────
        RowLayout {
            Layout.fillWidth: true; spacing: 6
            Rectangle {
                Layout.preferredWidth: 10; Layout.preferredHeight: 10
                radius: 5
                color: root.series ? root.series.color : "#ffffff"
            }
            Text {
                text: root.series ? root.series.name : ""
                color: "#cdd6f4"; font { pixelSize: 11; bold: true }
                Layout.fillWidth: true
            }
        }

        // ── Series base properties ────────────────────────────────────────
        EditorPropField {
            propLabel: "name"
            propValue: root.series ? root.series.name : ""
            onCommit: function(val) { if (root.series) root.series.name = val }
        }
        EditorPropField {
            propLabel: "color"
            propValue: root.series ? root.series.color : ""
            onCommit: function(val) {
                if (root.series && val.trim()) root.series.color = val.trim()
            }
        }
        EditorNumericField {
            propLabel: "width"
            propValue: root.series ? root.series.lineWidth : 2.0
            step: 0.5; decimals: 1; minValue: 0; maxValue: 20
            onCommit: function(val) { if (root.series) root.series.lineWidth = val }
        }
        EditorPropSlider {
            propLabel: "opacity"
            propValue: root.series ? root.series.opacity : 1.0
            onCommit: function(val) { if (root.series) root.series.opacity = val }
        }

        // ── Point Delegate ────────────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            height: 1; color: "#2a2a3e"
            Layout.topMargin: 2
        }

        // Header row: label + add/remove toggle button
        RowLayout {
            Layout.fillWidth: true; spacing: 6

            Text {
                text: "POINT DELEGATE"
                color: root.series && root.series.dlgEnabled ? "#89b4fa" : "#6c7086"
                font { pixelSize: 9; bold: true; letterSpacing: 1 }
                Layout.fillWidth: true
            }

            Rectangle {
                width: 20; height: 20; radius: 4
                color: toggleBtn.containsMouse ? "#3d3f5a" : "#313244"
                border.color: "#45475a"; border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: root.series && root.series.dlgEnabled ? "×" : "+"
                    color: root.series && root.series.dlgEnabled ? "#f38ba8" : "#a6e3a1"
                    font.pixelSize: 14; font.bold: true
                }
                MouseArea {
                    id: toggleBtn
                    anchors.fill: parent; hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (root.series) root.series.dlgEnabled = !root.series.dlgEnabled
                    }
                }
            }
        }

        // Delegate config section — visible only when enabled
        ColumnLayout {
            visible: root.series ? root.series.dlgEnabled : false
            Layout.fillWidth: true
            spacing: 5

            // ── Dot ───────────────────────────────────────────────────────
            EditorToggle {
                propLabel: "show dot"
                propValue: root.series ? root.series.dlgShowDot : true
                onCommit: function(val) { if (root.series) root.series.dlgShowDot = val }
            }
            EditorNumericField {
                propLabel: "dot size"
                propValue: root.series ? root.series.dlgDotSize : 10
                step: 1; decimals: 0; minValue: 2; maxValue: 40
                onCommit: function(val) { if (root.series) root.series.dlgDotSize = val }
            }

            // ── Label ─────────────────────────────────────────────────────
            EditorToggle {
                propLabel: "show label"
                propValue: root.series ? root.series.dlgShowLabel : true
                onCommit: function(val) { if (root.series) root.series.dlgShowLabel = val }
            }

            // x / y axis segmented picker
            RowLayout {
                Layout.fillWidth: true; spacing: 8
                Text {
                    Layout.preferredWidth: 84
                    text: "label axis"
                    color: "#6c7086"; font.pixelSize: 11
                    horizontalAlignment: Text.AlignRight
                }
                Row {
                    spacing: 3
                    Repeater {
                        model: ["x", "y"]
                        delegate: Rectangle {
                            required property string modelData
                            width: 28; height: 24; radius: 4
                            color: root.series && root.series.dlgLabelAxis === modelData
                                   ? "#89b4fa" : "#313244"
                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: root.series && root.series.dlgLabelAxis === modelData
                                       ? "#1e1e2e" : "#a6adc8"
                                font.pixelSize: 11; font.bold: true
                            }
                            MouseArea {
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                onClicked: { if (root.series) root.series.dlgLabelAxis = modelData }
                            }
                        }
                    }
                }
                Item { Layout.fillWidth: true }
            }

            EditorNumericField {
                propLabel: "decimals"
                propValue: root.series ? root.series.dlgLabelDecimals : 1
                step: 1; decimals: 0; minValue: 0; maxValue: 6
                onCommit: function(val) {
                    if (root.series) root.series.dlgLabelDecimals = Math.round(val)
                }
            }
            EditorNumericField {
                propLabel: "font size"
                propValue: root.series ? root.series.dlgLabelFontSize : 11
                step: 1; decimals: 0; minValue: 6; maxValue: 28
                onCommit: function(val) { if (root.series) root.series.dlgLabelFontSize = val }
            }
            EditorPropField {
                propLabel: "label color"
                propValue: root.series ? root.series.dlgLabelColor : "#cdd6f4"
                onCommit: function(val) {
                    if (root.series && val.trim()) root.series.dlgLabelColor = val.trim()
                }
            }
            EditorNumericField {
                propLabel: "offset Y"
                propValue: root.series ? root.series.dlgLabelOffsetY : 4
                step: 1; decimals: 0; minValue: 0; maxValue: 30
                onCommit: function(val) { if (root.series) root.series.dlgLabelOffsetY = val }
            }
        }
    }
}
