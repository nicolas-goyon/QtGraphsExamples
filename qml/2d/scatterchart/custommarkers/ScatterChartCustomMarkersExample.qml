import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    ScatterChartCustomMarkersDataProvider { id: dataProvider }

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
                text: "Scatter Chart — Traffic (k visits) vs Conversion Rate (%)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisX: ValueAxis { min: 0;  max: 130; tickInterval: 20; labelFormat: "%g k" }
                axisY: ValueAxis { min: 0;  max: 15;  tickInterval: 3;  labelFormat: "%g%%" }

                // ── Blog — filled circle ──────────────────────────────────────
                ScatterSeries {
                    name: "Blog"
                    color: "transparent"
                    Component.onCompleted: {
                        var pts = dataProvider.blogData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 16; height: 16
                            Rectangle {
                                anchors.centerIn: parent
                                width: 14; height: 14; radius: 7
                                color: "#89b4fa"
                            }
                        }
                    }
                }

                // ── Social — diamond (rotated square) ─────────────────────────
                ScatterSeries {
                    name: "Social"
                    color: "transparent"
                    Component.onCompleted: {
                        var pts = dataProvider.socialData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 16; height: 16
                            Rectangle {
                                anchors.centerIn: parent
                                width: 10; height: 10
                                color: "#a6e3a1"
                                rotation: 45
                            }
                        }
                    }
                }

                // ── Email — cross (two overlapping rectangles) ────────────────
                ScatterSeries {
                    name: "Email"
                    color: "transparent"
                    Component.onCompleted: {
                        var pts = dataProvider.emailData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 16; height: 16
                            Rectangle {
                                anchors.centerIn: parent
                                width: 14; height: 4; radius: 2
                                color: "#f38ba8"
                            }
                            Rectangle {
                                anchors.centerIn: parent
                                width: 4; height: 14; radius: 2
                                color: "#f38ba8"
                            }
                        }
                    }
                }
            }

            ScatterChartCustomMarkersDescription {}
        }
    }
}
