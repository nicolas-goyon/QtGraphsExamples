// EditorToggle.qml
// Labelled boolean toggle switch for the Live Editor inspector panel.
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property string propLabel: ""
    property bool   propValue: false
    signal commit(bool val)

    Layout.fillWidth: true
    spacing: 8

    Text {
        Layout.preferredWidth: 84
        text: root.propLabel
        color: "#6c7086"; font.pixelSize: 11
        horizontalAlignment: Text.AlignRight
    }

    Rectangle {
        id: track
        width: 36; height: 20; radius: 10
        color: root.propValue ? "#89b4fa" : "#313244"
        Behavior on color { ColorAnimation { duration: 120 } }

        Rectangle {
            id: knob
            width: 14; height: 14; radius: 7
            anchors.verticalCenter: parent.verticalCenter
            x: root.propValue ? parent.width - width - 3 : 3
            color: "#cdd6f4"
            Behavior on x { NumberAnimation { duration: 120 } }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.commit(!root.propValue)
        }
    }

    Item { Layout.fillWidth: true }
}
