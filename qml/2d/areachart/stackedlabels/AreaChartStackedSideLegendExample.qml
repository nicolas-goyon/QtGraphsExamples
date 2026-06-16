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
                text: "Area Chart — Stacked with Side Legend"
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
            }

            // ── Legend row (below chart) ──────────────────────────────────────
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 32

                Repeater {
                    model: [
                        { label: "Organic", color: "#89b4fa", fill: "#4089b4fa" },
                        { label: "Direct",  color: "#a6e3a1", fill: "#40a6e3a1" },
                        { label: "Social",  color: "#f38ba8", fill: "#40f38ba8" }
                    ]

                    Row {
                        spacing: 8

                        // Colored swatch matching the area fill + border
                        Rectangle {
                            width: 14; height: 14; radius: 3
                            color: modelData.fill
                            border.color: modelData.color
                            border.width: 1
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: modelData.label
                            color: "#cdd6f4"
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }

            AreaChartStackedSideLegendDescription {}
        }
    }
}
