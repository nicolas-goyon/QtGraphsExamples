// BasicBars3D.qml
// Graph configuration for the Basic 3D Bars example.
// Data is injected by BasicBars3DExample.cpp as QML context properties:
//   - barData3D   : list of {rowLabel, colLabel, val} maps (flat 4×4 grid)
//   - rowLabels3D : QStringList {"2021","2022","2023","2024"}
//   - colLabels3D : QStringList {"Q1","Q2","Q3","Q4"}

import QtGraphs
import QtQuick

Bars3D {
    anchors.fill: parent

    rowAxis: CategoryAxis3D {
        labels: rowLabels3D
        title: qsTr("Year")
        titleVisible: true
    }

    columnAxis: CategoryAxis3D {
        labels: colLabels3D
        title: qsTr("Quarter")
        titleVisible: true
    }

    valueAxis: ValueAxis3D {
        title: qsTr("Sales (M units)")
        titleVisible: true
    }

    Bar3DSeries {
        ItemModelBarDataProxy {
            itemModel: ListModel { id: barsModel }
            rowRole: "rowLabel"
            columnRole: "colLabel"
            valueRole: "val"
        }

        Component.onCompleted: {
            for (let item of barData3D)
                barsModel.append(item)
        }
    }
}
