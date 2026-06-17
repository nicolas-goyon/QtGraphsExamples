// EditorSectionLabel.qml
// Accent-coloured section header with a hairline divider below it.
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    property string title: ""

    Layout.fillWidth: true
    Layout.topMargin: 8
    spacing: 4

    Text {
        text: title
        color: "#89b4fa"
        font { pixelSize: 10; bold: true; letterSpacing: 1 }
    }
    Rectangle {
        Layout.fillWidth: true
        height: 1; color: "#313244"
    }
}
