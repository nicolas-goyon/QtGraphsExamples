import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    // Per-trendline visibility state
    property bool showLinear:      true
    property bool showQuadratic:   true
    property bool showExponential: true
    property bool showLogarithmic: true

    ScatterChartTrendLinesDataProvider { id: dataProvider }

    // Clickable legend row: wraps Row + MouseArea inside an Item so
    // anchors.fill on the MouseArea is never a direct child of Row/Column.
    component TrendToggle: Item {
        property alias label: lbl.text
        property color seriesColor: "white"
        property bool  active: true
        signal toggled()

        implicitWidth:  row.implicitWidth
        implicitHeight: row.implicitHeight

        Row {
            id: row
            spacing: 6

            Rectangle {
                width: 16; height: 3; radius: 1
                color: active ? seriesColor : "#45475a"
                anchors.verticalCenter: parent.verticalCenter
                Behavior on color { ColorAnimation { duration: 120 } }
            }
            Text {
                id: lbl
                color: active ? "#cdd6f4" : "#585b70"
                font.pixelSize: 11
                Behavior on color { ColorAnimation { duration: 120 } }
            }
        }

        // MouseArea parent is the Item above — anchors.fill is safe here.
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: toggled()
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        contentHeight: content.implicitHeight + 32

        ColumnLayout {
            id: content
            x: 16; y: 16
            width: parent.width - 32
            spacing: 8

            Text {
                text: "Scatter Chart — Data with Multiple Regression Fits"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // Chart + inline legend overlay
            Item {
                Layout.fillWidth: true
                implicitHeight: 340

                GraphsView {
                    anchors.fill: parent

                    theme: GraphsTheme {
                        colorScheme: GraphsTheme.ColorScheme.Dark
                        seriesColors: ["#cdd6f4", "#89b4fa", "#a6e3a1", "#f9e2af", "#f38ba8"]
                    }

                    axisX: ValueAxis { min: 0; max: 14; tickInterval: 2; labelFormat: "%g" }
                    axisY: ValueAxis { min: 0; max: 70; tickInterval: 10; labelFormat: "%g" }

                    ScatterSeries {
                        name: "Data"
                        Component.onCompleted: {
                            var pts = dataProvider.scatterData()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }

                    LineSeries {
                        name: "Linear"
                        color: "#89b4fa"; width: 2
                        visible: root.showLinear
                        Component.onCompleted: {
                            var pts = dataProvider.linearTrend()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }

                    LineSeries {
                        name: "Quadratic"
                        color: "#a6e3a1"; width: 2
                        visible: root.showQuadratic
                        Component.onCompleted: {
                            var pts = dataProvider.quadraticTrend()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }

                    LineSeries {
                        name: "Exponential"
                        color: "#f9e2af"; width: 2
                        visible: root.showExponential
                        Component.onCompleted: {
                            var pts = dataProvider.exponentialTrend()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }

                    LineSeries {
                        name: "Logarithmic"
                        color: "#f38ba8"; width: 2
                        visible: root.showLogarithmic
                        Component.onCompleted: {
                            var pts = dataProvider.logarithmicTrend()
                            for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                        }
                    }
                }

                // Inline legend overlay (top-left)
                Rectangle {
                    x: 56; y: 12
                    width: legendCol.implicitWidth + 16
                    height: legendCol.implicitHeight + 12
                    color: "#181825cc"; radius: 6
                    border.color: "#313244"; border.width: 1

                    Column {
                        id: legendCol
                        x: 8; y: 6
                        spacing: 4

                        // Non-toggleable data marker
                        Row {
                            spacing: 6
                            Rectangle {
                                width: 10; height: 10; radius: 5; color: "#cdd6f4"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text { text: "Data"; color: "#cdd6f4"; font.pixelSize: 11 }
                        }

                        // One explicit instance per trendline — direct property bindings
                        // so QML's reactive system tracks changes correctly.
                        TrendToggle {
                            label: "Linear";      seriesColor: "#89b4fa"
                            active: root.showLinear
                            onToggled: root.showLinear = !root.showLinear
                        }
                        TrendToggle {
                            label: "Quadratic";   seriesColor: "#a6e3a1"
                            active: root.showQuadratic
                            onToggled: root.showQuadratic = !root.showQuadratic
                        }
                        TrendToggle {
                            label: "Exponential"; seriesColor: "#f9e2af"
                            active: root.showExponential
                            onToggled: root.showExponential = !root.showExponential
                        }
                        TrendToggle {
                            label: "Logarithmic"; seriesColor: "#f38ba8"
                            active: root.showLogarithmic
                            onToggled: root.showLogarithmic = !root.showLogarithmic
                        }
                    }
                }
            }

            ScatterChartTrendLinesDescription {}
        }
    }
}
