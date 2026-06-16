// BasicScatter.qml
// Graph configuration for the Basic Scatter Chart example.
// Data is injected by BasicScatterExample.cpp as QML context properties:
//   - runAPoints : list of {x, y} objects (QList<QPointF>)
//   - runBPoints : list of {x, y} objects (QList<QPointF>)

import QtGraphs
import QtQuick

GraphsView {
    anchors.fill: parent

    theme: GraphsTheme {
        colorScheme: GraphsTheme.ColorScheme.Dark
        theme: GraphsTheme.Theme.QtGreen
    }

    axisX: ValueAxis {
        min: 0
        max: 9
        tickInterval: 1
        title: qsTr("X")
    }

    axisY: ValueAxis {
        min: 0
        max: 9
        tickInterval: 1
        title: qsTr("Y")
    }

    ScatterSeries {
        name: "Run A"
        markerShape: ScatterSeries.MarkerShapeCircle
        markerSize: 10
        Component.onCompleted: {
            for (let pt of runAPoints)
                append(pt.x, pt.y)
        }
    }

    ScatterSeries {
        name: "Run B"
        markerShape: ScatterSeries.MarkerShapeRectangle
        markerSize: 10
        Component.onCompleted: {
            for (let pt of runBPoints)
                append(pt.x, pt.y)
        }
    }
}
