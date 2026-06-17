// EditorPropField.qml
// A labelled text-input row used in the Live Editor inspector panel.
// Emits commit(string) when the user presses Enter or tabs away.
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property string propLabel: ""
    property string propValue: ""
    signal commit(string val)

    Layout.fillWidth: true
    spacing: 8

    // Sync the field whenever external state changes, but never interrupt
    // a user who is actively typing.
    onPropValueChanged: function() { if (!ti.activeFocus) ti.text = propValue }

    Text {
        Layout.preferredWidth: 84
        text: root.propLabel
        color: "#6c7086"
        font.pixelSize: 11
        horizontalAlignment: Text.AlignRight
        elide: Text.ElideRight
    }

    // Plain Rectangle + TextInput — avoids the native-style restriction
    // that TextField carries when a custom background is needed.
    Rectangle {
        Layout.fillWidth: true
        implicitHeight: 24
        color: "#313244"
        radius: 4
        border.color: ti.activeFocus ? "#89b4fa" : "transparent"
        border.width: 1

        TextInput {
            id: ti
            anchors {
                left: parent.left; right: parent.right
                verticalCenter: parent.verticalCenter
                leftMargin: 7; rightMargin: 7
            }
            color: "#cdd6f4"
            font.pixelSize: 12
            selectByMouse: true
            clip: true
            Component.onCompleted: text = root.propValue
            onEditingFinished: root.commit(text)
        }
    }
}
