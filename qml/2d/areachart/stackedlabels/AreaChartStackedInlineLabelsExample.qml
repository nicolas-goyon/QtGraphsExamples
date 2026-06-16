import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    AreaChartStackedDataProvider { id: dataProvider }

    // ── Boundary series (outside GraphsView — not rendered as lines) ──────────
    LineSeries { id: organicBound   }
    LineSeries { id: orgDirectBound }
    LineSeries { id: totalBound     }

    Component.onCompleted: {
        var org = dataProvider.organicData()
        var dir = dataProvider.directData()
        var soc = dataProvider.socialData()
        for (var i = 0; i < org.length; i++) {
            organicBound.append(i,   org[i])
            orgDirectBound.append(i, org[i] + dir[i])
            totalBound.append(i,     org[i] + dir[i] + soc[i])
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
                text: "Area Chart — Stacked with Inline Labels"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                    grid.mainWidth: 0.5
                }

                axisX: ValueAxis { min: 0; max: 11; tickInterval: 1; labelFormat: "%g" }
                axisY: ValueAxis { min: 0; max: 1200; tickInterval: 200; labelFormat: "%g" }

                // ── Area fills ────────────────────────────────────────────────
                AreaSeries {
                    name: "Organic"
                    color: "#4089b4fa"; borderColor: "#89b4fa"; borderWidth: 1
                    upperSeries: organicBound
                }
                AreaSeries {
                    name: "Direct"
                    color: "#40a6e3a1"; borderColor: "#a6e3a1"; borderWidth: 1
                    upperSeries: orgDirectBound; lowerSeries: organicBound
                }
                AreaSeries {
                    name: "Social"
                    color: "#40f38ba8"; borderColor: "#f38ba8"; borderWidth: 1
                    upperSeries: totalBound; lowerSeries: orgDirectBound
                }

                // ── Inline label anchors ──────────────────────────────────────
                // Each is a transparent single-point LineSeries positioned at
                // the vertical midpoint of its band at x=5. The pointDelegate
                // renders only a text label — no dot.
                //
                // At x=5: organic=580, direct=330, social=190
                //   Organic band mid Y: 580 / 2 = 290
                //   Direct  band mid Y: 580 + 330 / 2 = 745
                //   Social  band mid Y: 910 + 190 / 2 = 1005

                LineSeries {
                    color: "transparent"
                    Component.onCompleted: append(5, 290)
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 80; height: 24
                            Text {
                                anchors.centerIn: parent
                                text: "Organic"
                                color: "#89b4fa"
                                font { pixelSize: 12; bold: true }
                            }
                        }
                    }
                }

                LineSeries {
                    color: "transparent"
                    Component.onCompleted: append(5, 745)
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 80; height: 24
                            Text {
                                anchors.centerIn: parent
                                text: "Direct"
                                color: "#a6e3a1"
                                font { pixelSize: 12; bold: true }
                            }
                        }
                    }
                }

                LineSeries {
                    color: "transparent"
                    Component.onCompleted: append(5, 1005)
                    pointDelegate: Component {
                        Item {
                            property color pointColor
                            property real  pointValueX
                            property real  pointValueY
                            width: 80; height: 24
                            Text {
                                anchors.centerIn: parent
                                text: "Social"
                                color: "#f38ba8"
                                font { pixelSize: 12; bold: true }
                            }
                        }
                    }
                }
            }

            AreaChartStackedInlineLabelsDescription {}
        }
    }
}
