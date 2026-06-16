import QtQuick
import QtQuick.Controls

// Standalone editable table component.
// API:
//   property var tableModel  — a ListModel with {month, value} items
//   signal valueChanged(int index, real value)  — emitted on every valid keystroke
//
// Uses TextInput inside Rectangle (not TextField) to avoid the native-style
// background customisation warning from QtQuick.Controls.
Item {
    id: root

    property var tableModel: null

    signal valueChanged(int index, real value)

    implicitHeight: contentRow.implicitHeight + 20

    ScrollView {
        anchors.fill: parent
        clip: true

        Row {
            id: contentRow
            spacing: 6
            leftPadding: 2
            rightPadding: 2

            Repeater {
                model: root.tableModel

                // One column per month
                Column {
                    spacing: 4
                    width: 68

                    // ── Month label ───────────────────────────────
                    Rectangle {
                        width: parent.width
                        height: 24
                        color: "#313244"
                        radius: 4

                        Text {
                            anchors.centerIn: parent
                            text: model.month
                            color: "#89b4fa"
                            font { pixelSize: 11; bold: true }
                        }
                    }

                    // ── Editable value cell ───────────────────────
                    // TextInput + Rectangle instead of TextField so we can
                    // customise the background freely without triggering the
                    // "native style does not support customization" warning.
                    Rectangle {
                        id: cellBg
                        width: parent.width
                        height: 32
                        radius: 4
                        color:        cellInput.activeFocus ? "#313244" : "#1e1e2e"
                        border.color: cellInput.activeFocus ? "#89b4fa"  : "#45475a"
                        border.width: 1

                        // Tracks the last value accepted as a valid number so we
                        // can restore it if the user leaves the field with bad input.
                        property real lastValid: 0

                        TextInput {
                            id: cellInput
                            anchors { fill: parent; margins: 4 }
                            horizontalAlignment: TextInput.AlignHCenter
                            verticalAlignment:   TextInput.AlignVCenter
                            font.pixelSize: 12
                            color: "#cdd6f4"
                            selectByMouse: true
                            selectionColor: "#89b4fa"
                            selectedTextColor: "#1e1e2e"

                            // Set initial text once without a live binding to avoid
                            // an update loop (model → text change → signal → model…).
                            Component.onCompleted: {
                                var v = root.tableModel.get(index).value
                                cellBg.lastValid = v
                                text = v.toString()
                            }

                            // Live update on every keystroke.
                            onTextChanged: {
                                var v = parseFloat(text)
                                if (!isNaN(v) && v >= 0) {
                                    cellBg.lastValid = v
                                    root.valueChanged(index, v)
                                }
                            }

                            // Restore last accepted value when focus leaves on
                            // an invalid or empty entry.
                            onEditingFinished: {
                                var v = parseFloat(text)
                                if (isNaN(v) || v < 0)
                                    text = cellBg.lastValid.toString()
                            }
                        }
                    }
                }
            }
        }
    }
}
