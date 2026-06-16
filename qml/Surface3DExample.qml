import QtQuick
import QtQuick.Layouts
import QtGraphs


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
                id: surfaceSeries
                drawMode: Surface3DSeries.DrawSurfaceAndWireframe
                //flatShadingEnabled: false
                baseColor: "#89b4fa"

                ItemModelSurfaceDataProxy {
                    itemModel: surfaceModel
                    rowRole: "z"
                    columnRole: "x"
                    yPosRole: "y"
                }
            }

            Component.onCompleted: {
                const steps = 30
                const range = Math.PI
                for (let iz = 0; iz <= steps; ++iz) {
                    const z = -range + (2 * range * iz / steps)
                    for (let ix = 0; ix <= steps; ++ix) {
                        const x = -range + (2 * range * ix / steps)
                        const y = Math.sin(x) * Math.cos(z)
                        surfaceModel.append({"x": x.toFixed(4), "z": z.toFixed(4), "y": y.toFixed(4)})
                    }
                }
            }
        }

        // ── Build a sin(x)*cos(z) surface programmatically ──────────────
        ListModel { id: surfaceModel }

        function buildSurface() {
            const steps = 30
            const range = Math.PI
            for (let iz = 0; iz <= steps; ++iz) {
                const z = -range + (2 * range * iz / steps)
                for (let ix = 0; ix <= steps; ++ix) {
                    const x = -range + (2 * range * ix / steps)
                    const y = Math.sin(x) * Math.cos(z)
                    surfaceModel.append({ "x": x.toFixed(4), "z": z.toFixed(4), "y": y.toFixed(4) })
                }
            }
        }
    }
}
