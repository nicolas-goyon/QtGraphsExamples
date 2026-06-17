// EditorNumericField.qml
// Labelled numeric input with up/down arrow buttons and mouse-wheel support.
// - Click ▲ / ▼ or scroll the wheel to step the value.
// - Type directly and press Enter or Tab to commit.
// - Emits commit(real) when any change is confirmed.
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property string propLabel: ""
    property real   propValue: 0
    property real   step:      1.0
    property int    decimals:  1       // digits after decimal point in the display
    property real   minValue:  -1e9
    property real   maxValue:   1e9
    signal commit(real val)

    Layout.fillWidth: true
    spacing: 8

    // Sync display when external state changes, but never overwrite live typing.
    onPropValueChanged: function() {
        if (!ti.activeFocus)
            ti.text = root.propValue.toFixed(root.decimals)
    }

    function clamp(v) {
        return Math.max(root.minValue, Math.min(root.maxValue, v))
    }
    function increment() {
        var v = clamp(root.propValue + root.step)
        root.commit(v)
        ti.text = v.toFixed(root.decimals)
    }
    function decrement() {
        var v = clamp(root.propValue - root.step)
        root.commit(v)
        ti.text = v.toFixed(root.decimals)
    }

    Text {
        Layout.preferredWidth: 84
        text: root.propLabel
        color: "#6c7086"; font.pixelSize: 11
        horizontalAlignment: Text.AlignRight; elide: Text.ElideRight
    }

    Rectangle {
        id: fieldRect
        Layout.fillWidth: true
        implicitHeight: 24
        color: "#313244"; radius: 4
        border.color: ti.activeFocus ? "#89b4fa" : "transparent"
        border.width: 1

        // Mouse wheel anywhere over the field increments/decrements
        WheelHandler {
            onWheel: function(event) {
                if (event.angleDelta.y > 0) root.increment()
                else root.decrement()
                event.accepted = true
            }
        }

        TextInput {
            id: ti
            anchors {
                left: parent.left; right: arrows.left
                verticalCenter: parent.verticalCenter
                leftMargin: 7; rightMargin: 2
            }
            color: "#cdd6f4"; font.pixelSize: 12
            selectByMouse: true; clip: true
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            Component.onCompleted: text = root.propValue.toFixed(root.decimals)
            onEditingFinished: {
                var v = parseFloat(text)
                var committed = isNaN(v) ? root.propValue : root.clamp(v)
                if (!isNaN(v)) root.commit(committed)
                text = committed.toFixed(root.decimals)
            }
        }

        // Stacked ▲ / ▼ buttons
        Column {
            id: arrows
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom; rightMargin: 2 }
            width: 16

            Rectangle {
                width: parent.width; height: parent.height / 2
                radius: 2
                color: upHov.containsMouse ? "#45475a" : "transparent"
                Text {
                    anchors.centerIn: parent
                    text: "▲"; color: "#585b70"; font.pixelSize: 7
                }
                MouseArea {
                    id: upHov
                    anchors.fill: parent; hoverEnabled: true
                    cursorShape: Qt.ArrowCursor
                    onClicked: root.increment()
                }
            }

            Rectangle {
                width: parent.width; height: parent.height / 2
                radius: 2
                color: downHov.containsMouse ? "#45475a" : "transparent"
                Text {
                    anchors.centerIn: parent
                    text: "▼"; color: "#585b70"; font.pixelSize: 7
                }
                MouseArea {
                    id: downHov
                    anchors.fill: parent; hoverEnabled: true
                    cursorShape: Qt.ArrowCursor
                    onClicked: root.decrement()
                }
            }
        }
    }
}
