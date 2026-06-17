import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    Surface3DLegendDataProvider { id: dataProvider }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "3D Surface — Double-Peak Gaussian with Inline Gradient Legend"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Surface3D {
                anchors.fill: parent

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                }

                cameraXRotation: 30
                cameraYRotation: 20

                shadowQuality: Graphs3D.ShadowQuality.Medium
                shadowStrength:       8
                lightStrength:        8
                ambientLightStrength: 0.3

                axisX: Value3DAxis { min: -3; max: 3; title: "X"; titleVisible: true }
                axisZ: Value3DAxis { min: -3; max: 3; title: "Z"; titleVisible: true }
                axisY: Value3DAxis { min:  0; max: 2; title: "Height"; titleVisible: true }

                Surface3DSeries {
                    name: "Terrain"
                    colorStyle: GraphsTheme.ColorStyle.RangeGradient
                    baseGradient: Gradient {
                        GradientStop { position: 0.0; color: "#2255cc" }
                        GradientStop { position: 0.3; color: "#22aacc" }
                        GradientStop { position: 0.6; color: "#44cc44" }
                        GradientStop { position: 1.0; color: "#dd2222" }
                    }

                    ItemModelSurfaceDataProxy {
                        itemModel:  dataProvider
                        rowRole:    "xPos"
                        columnRole: "zPos"
                        yPosRole:   "yPos"
                        xPosRole:   "xPos"
                        zPosRole:   "zPos"
                    }
                }
            }

            // ── Inline gradient colour-bar legend (right side, inside 3D view) ─
            Item {
                anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: 14 }
                width: 28
                height: 160

                Rectangle {
                    id: gradBar
                    anchors { fill: parent; bottomMargin: 20; topMargin: 20 }
                    radius: 3
                    border.color: "#313244"; border.width: 1
                    gradient: Gradient {
                        orientation: Gradient.Vertical
                        GradientStop { position: 0.0; color: "#dd2222" }
                        GradientStop { position: 0.4; color: "#44cc44" }
                        GradientStop { position: 0.7; color: "#22aacc" }
                        GradientStop { position: 1.0; color: "#2255cc" }
                    }
                }

                Text {
                    anchors { bottom: gradBar.top; horizontalCenter: parent.horizontalCenter; bottomMargin: 2 }
                    text: "2.0"; color: "#cdd6f4"; font.pixelSize: 9
                }
                Text {
                    anchors { top: gradBar.bottom; horizontalCenter: parent.horizontalCenter; topMargin: 2 }
                    text: "0.0"; color: "#cdd6f4"; font.pixelSize: 9
                }
                Text {
                    anchors { right: gradBar.left; verticalCenter: gradBar.verticalCenter; rightMargin: 2 }
                    text: "Height"
                    color: "#6c7086"
                    font.pixelSize: 9
                    rotation: -90
                    transformOrigin: Item.Center
                }
            }
        }

        Surface3DInlineLegendDescription {}
    }
}
