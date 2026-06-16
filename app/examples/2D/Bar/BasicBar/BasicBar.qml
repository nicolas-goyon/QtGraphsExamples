// BasicBar.qml
// Graph configuration for the Basic Bar Chart example.
// Data is injected by BasicBarExample.cpp as QML context properties:
//   - barCategories    : QStringList  {"Q1","Q2","Q3","Q4"}
//   - widgetsValues    : list of reals
//   - gadgetsValues    : list of reals
//   - doohickeysValues : list of reals

import QtGraphs
import QtQuick

GraphsView {
    anchors.fill: parent

    theme: GraphsTheme {
        colorScheme: GraphsTheme.ColorScheme.Dark
        theme: GraphsTheme.Theme.QtGreen
    }

    axisX: BarCategoryAxis {
        categories: barCategories
        title: qsTr("Quarter")
    }

    axisY: ValueAxis {
        min: 0
        max: 10
        tickInterval: 2
        title: qsTr("Revenue (M€)")
    }

    BarSeries {
        BarSet {
            label: "Widgets"
            Component.onCompleted: {
                for (let v of widgetsValues)
                    append(v)
            }
        }
        BarSet {
            label: "Gadgets"
            Component.onCompleted: {
                for (let v of gadgetsValues)
                    append(v)
            }
        }
        BarSet {
            label: "Doohickeys"
            Component.onCompleted: {
                for (let v of doohickeysValues)
                    append(v)
            }
        }
    }
}
