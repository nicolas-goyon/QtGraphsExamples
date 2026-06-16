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
            text: "3D Surface Chart — sin(x) * cos(z)"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        Surface3D {
            id: surfaceGraph
            Layout.fillWidth: true
            Layout.fillHeight: true

            theme: GraphsTheme {
                colorScheme: GraphsTheme.ColorScheme.Dark
            }

            cameraXRotation: -45
            cameraYRotation: 30

            axisX: Value3DAxis { min: -3.14; max: 3.14; title: "X"; titleVisible: true }
            axisY: Value3DAxis { min: -1.0;  max: 1.0;  title: "Y"; titleVisible: true }
            axisZ: Value3DAxis { min: -3.14; max: 3.14; title: "Z"; titleVisible: true }

            Surface3DSeries {
                drawMode: Surface3DSeries.DrawSurfaceAndWireframe
                baseColor: "#89b4fa"

                ItemModelSurfaceDataProxy {
                    itemModel:  Surface3DDataProvider {}
                    rowRole:    "z"
                    columnRole: "x"
                    xPosRole:   "x"
                    yPosRole:   "y"
                    zPosRole:   "z"
                }
            }
        }
    }
}
