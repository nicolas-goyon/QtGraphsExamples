import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

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
            lightStrength:        10
            ambientLightStrength: 0
            shadowQuality:        Graphs3D.ShadowQuality.Medium
            shadowStrength:       10

            cameraXRotation: -25
            cameraYRotation: 30

            columnAxis: Category3DAxis { labels: ["Q1", "Q2", "Q3", "Q4"] }
            rowAxis:    Category3DAxis { labels: ["North", "South", "East", "West"] }

            Bar3DSeries {
                itemLabelFormat: "@rowLabel / @colLabel: @valueLabel"
                baseColor: "#2072fb"

                ItemModelBarDataProxy {
                    itemModel:  Bars3DDataProvider {}
                    rowRole:    "row"
                    columnRole: "col"
                    valueRole:  "value"
                }
            }
        }
    }
}
