import QtQuick
import QtQuick.Layouts
import QtGraphs

Item {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "3D Bar Chart — Sales per Region & Quarter"
            font { pixelSize: 16; bold: true }
            color: "#95e3de"
        }

        Bars3D {
            Layout.fillWidth: true
            Layout.fillHeight: true

            theme: GraphsTheme {
                colorScheme: GraphsTheme.ColorScheme.Dark
            }
            lightStrength : 10
            ambientLightStrength: 0

            shadowQuality: Graphs3D.ShadowQuality.Medium
            shadowStrength : 10

            // Camera starting position (angles instead of preset enum)
            cameraXRotation: -25
            cameraYRotation: 30

            columnAxis: Category3DAxis {
                labels: ["Q1", "Q2", "Q3", "Q4"]
            }

            rowAxis: Category3DAxis {
                labels: ["North", "South", "East", "West"]
            }

            Bar3DSeries {
                itemLabelFormat: "@rowLabel / @colLabel: @valueLabel"
                baseColor: "#2072fb"

                ItemModelBarDataProxy {
                    itemModel: ListModel {
                        // North
                        ListElement { row: "North"; col: "Q1"; value: 3.5 }
                        ListElement { row: "North"; col: "Q2"; value: 4.2 }
                        ListElement { row: "North"; col: "Q3"; value: 5.8 }
                        ListElement { row: "North"; col: "Q4"; value: 7.1 }
                        // South
                        ListElement { row: "South"; col: "Q1"; value: 2.8 }
                        ListElement { row: "South"; col: "Q2"; value: 3.6 }
                        ListElement { row: "South"; col: "Q3"; value: 4.9 }
                        ListElement { row: "South"; col: "Q4"; value: 6.3 }
                        // East
                        ListElement { row: "East"; col: "Q1"; value: 4.0 }
                        ListElement { row: "East"; col: "Q2"; value: 5.5 }
                        ListElement { row: "East"; col: "Q3"; value: 6.2 }
                        ListElement { row: "East"; col: "Q4"; value: 8.0 }
                        // West
                        ListElement { row: "West"; col: "Q1"; value: 3.2 }
                        ListElement { row: "West"; col: "Q2"; value: 4.8 }
                        ListElement { row: "West"; col: "Q3"; value: 5.5 }
                        ListElement { row: "West"; col: "Q4"; value: 6.9 }
                    }
                    rowRole: "row"
                    columnRole: "col"
                    valueRole: "value"
                }
            }
        }
    }
}
