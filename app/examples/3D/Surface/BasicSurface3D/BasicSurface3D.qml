// BasicSurface3D.qml
// Graph configuration for the Basic 3D Surface example.
// The sinc (sin(r)/r) surface data is generated entirely in QML JavaScript —
// no C++ context property needed for this example.

import QtGraphs
import QtQuick

Surface3D {
    anchors.fill: parent

    axisX: ValueAxis3D { title: qsTr("X"); titleVisible: true; min: -5; max: 5 }
    axisY: ValueAxis3D { title: qsTr("Y"); titleVisible: true; min: -0.5; max: 1.0 }
    axisZ: ValueAxis3D { title: qsTr("Z"); titleVisible: true; min: -5; max: 5 }

    Surface3DSeries {
        drawMode: Surface3DSeries.DrawSurfaceAndWireframe
        flatShadingEnabled: false

        baseGradient: Gradient {
            GradientStop { position: 0.0; color: "blue"  }
            GradientStop { position: 0.5; color: "green" }
            GradientStop { position: 1.0; color: "red"   }
        }
        colorStyle: GraphsTheme.ColorStyle.RangeGradient

        ItemModelSurfaceDataProxy {
            id: surfaceProxy
            itemModel: ListModel { id: surfaceModel }
            xPosRole:    "posX"
            yPosRole:    "posY"
            zPosRole:    "posZ"
            rowRole:     "rowIdx"
            columnRole:  "colIdx"
        }

        // Generate sinc (sin(r)/r) surface on a 20×20 grid in [-5, 5]
        Component.onCompleted: {
            const rows = 20, cols = 20
            const xMin = -5, xMax = 5, zMin = -5, zMax = 5

            for (let r = 0; r < rows; ++r) {
                const z = zMin + r * (zMax - zMin) / (rows - 1)
                for (let c = 0; c < cols; ++c) {
                    const x = xMin + c * (xMax - xMin) / (cols - 1)
                    const dist = Math.sqrt(x * x + z * z)
                    const y = dist < 1e-4 ? 1.0 : Math.sin(dist) / dist
                    surfaceModel.append({
                        "rowIdx": r,
                        "colIdx": c,
                        "posX":   x,
                        "posY":   y,
                        "posZ":   z
                    })
                }
            }
        }
    }
}
