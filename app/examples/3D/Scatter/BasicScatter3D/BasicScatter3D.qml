// BasicScatter3D.qml
// Graph configuration for the Basic 3D Scatter example.
// Data is injected by BasicScatter3DExample.cpp as QML context properties:
//   - clusterAData : list of {x, y, z} maps
//   - clusterBData : list of {x, y, z} maps

import QtGraphs
import QtQuick

Scatter3D {
    anchors.fill: parent

    axisX: ValueAxis3D { title: qsTr("X"); titleVisible: true }
    axisY: ValueAxis3D { title: qsTr("Y"); titleVisible: true }
    axisZ: ValueAxis3D { title: qsTr("Z"); titleVisible: true }

    Scatter3DSeries {
        name: "Cluster A"
        itemSize: 0.15

        ItemModelScatterDataProxy {
            itemModel: ListModel { id: clusterAModel }
            xPosRole: "x"
            yPosRole: "y"
            zPosRole: "z"
        }

        Component.onCompleted: {
            for (let pt of clusterAData)
                clusterAModel.append(pt)
        }
    }

    Scatter3DSeries {
        name: "Cluster B"
        itemSize: 0.15

        ItemModelScatterDataProxy {
            itemModel: ListModel { id: clusterBModel }
            xPosRole: "x"
            yPosRole: "y"
            zPosRole: "z"
        }

        Component.onCompleted: {
            for (let pt of clusterBData)
                clusterBModel.append(pt)
        }
    }
}
