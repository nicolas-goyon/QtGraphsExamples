// BasicLine.qml
// Graph configuration for the Basic Line Chart example.
// Data is injected by BasicLineExample.cpp as QML context properties:
//   - helsinkiPoints : list of {x, y} objects (QList<QPointF>)
//   - madridPoints   : list of {x, y} objects (QList<QPointF>)

import QtGraphs
import QtQuick

GraphsView {
    anchors.fill: parent

    theme: GraphsTheme {
        colorScheme: GraphsTheme.ColorScheme.Dark
        theme: GraphsTheme.Theme.QtGreen
    }

    axisX: ValueAxis {
        min: 1
        max: 12
        tickInterval: 1
        title: qsTr("Month")
    }

    axisY: ValueAxis {
        min: -10
        max: 30
        tickInterval: 5
        title: qsTr("Temperature (°C)")
    }

    LineSeries {
        name: "Helsinki"
        Component.onCompleted: {
            for (let pt of helsinkiPoints)
                append(pt.x, pt.y)
        }
    }

    LineSeries {
        name: "Madrid"
        Component.onCompleted: {
            for (let pt of madridPoints)
                append(pt.x, pt.y)
        }
    }
}
