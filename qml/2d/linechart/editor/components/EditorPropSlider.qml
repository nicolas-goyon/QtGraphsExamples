// EditorPropSlider.qml
// A labelled range picker (0.0 – 1.0) used in the Live Editor inspector panel.
// Built entirely from Qt Quick primitives — no QtQuick.Controls style dependency.
// Emits commit(real) continuously while dragging and on click.
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property string propLabel: ""
    property real   propValue: 1.0      // clamped to [0, 1]
    signal commit(real val)

    Layout.fillWidth: true
    spacing: 8

    Text {
        Layout.preferredWidth: 84
        text: root.propLabel
        color: "#6c7086"
        font.pixelSize: 11
        horizontalAlignment: Text.AlignRight
    }

    Item {
        id: sliderItem
        Layout.fillWidth: true
        implicitHeight: 24

        // Track background
        Rectangle {
            anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter }
            height: 4; radius: 2; color: "#313244"
        }

        // Filled portion — from left edge to the left edge of the handle
        Rectangle {
            anchors { left: parent.left; verticalCenter: parent.verticalCenter }
            width: handle.x
            height: 4; radius: 2; color: "#89b4fa"
        }

        // Draggable handle
        Rectangle {
            id: handle
            width: 16; height: 16; radius: 8
            anchors.verticalCenter: parent.verticalCenter
            color: "#cdd6f4"
            border.color: "#1e1e2e"; border.width: 2

            // When idle, pin the handle to the current value
            Binding {
                target: handle; property: "x"
                value: root.propValue * (sliderItem.width - handle.width)
                when: !dragArea.drag.active
                restoreMode: Binding.RestoreNone
            }
        }

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: handle; drag.axis: Drag.XAxis
            drag.minimumX: 0; drag.maximumX: sliderItem.width - handle.width

            // Report value changes while dragging
            onPositionChanged: {
                if (drag.active) {
                    var maxX = sliderItem.width - handle.width
                    if (maxX > 0)
                        root.commit(Math.max(0, Math.min(1, handle.x / maxX)))
                }
            }

            // Click anywhere on the track to jump to that position
            onClicked: {
                var maxX = sliderItem.width - handle.width
                if (maxX > 0) {
                    var v = Math.max(0, Math.min(1, (mouseX - handle.width / 2) / maxX))
                    handle.x = v * maxX
                    root.commit(v)
                }
            }
        }
    }

    // Numeric readout
    Text {
        text: root.propValue.toFixed(2)
        color: "#a6adc8"
        font.pixelSize: 11
        Layout.preferredWidth: 32
    }
}
