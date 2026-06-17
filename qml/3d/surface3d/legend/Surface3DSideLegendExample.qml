import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    Surface3DLegendDataProvider { id: dataProvider }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8

            Text {
                text: "3D Surface — Double-Peak Gaussian with Legend Aside"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            Surface3D {
                Layout.fillWidth: true
                Layout.fillHeight: true

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

            Surface3DSideLegendDescription {}
        }

        // ── Gradient colour-bar legend (right column, outside the 3D view) ───
        Rectangle {
            Layout.preferredWidth: 64
            Layout.fillHeight: true
            color: "#1e1e2e"
            radius: 6
            border.color: "#313244"; border.width: 1

            Item {
                anchors.centerIn: parent
                width: 40
                height: 200

                Rectangle {
                    id: sideGradBar
                    anchors { fill: parent; bottomMargin: 24; topMargin: 24 }
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
                    anchors { bottom: sideGradBar.top; horizontalCenter: parent.horizontalCenter; bottomMargin: 2 }
                    text: "2.0"; color: "#cdd6f4"; font.pixelSize: 10; font.bold: true
                }
                Text {
                    anchors { top: sideGradBar.bottom; horizontalCenter: parent.horizontalCenter; topMargin: 2 }
                    text: "0.0"; color: "#cdd6f4"; font.pixelSize: 10; font.bold: true
                }
                Text {
                    anchors { right: sideGradBar.left; verticalCenter: sideGradBar.verticalCenter; rightMargin: 4 }
                    text: "Height"
                    color: "#a6adc8"
                    font.pixelSize: 10
                    rotation: -90
                    transformOrigin: Item.Center
                }
            }
        }
    }
}
