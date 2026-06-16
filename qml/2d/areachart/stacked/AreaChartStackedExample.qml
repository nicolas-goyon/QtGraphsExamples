import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    AreaChartStackedDataProvider { id: dataProvider }

    // ── Boundary LineSeries — defined OUTSIDE GraphsView ─────────────────────
    // If they were GraphsView children they would be rendered as visible lines
    // in addition to the area fills. Keeping them outside means their data is
    // accessible as upperSeries / lowerSeries but they are never drawn.
    //
    //  organicBound     = cumulative[Organic]
    //  orgDirectBound   = cumulative[Organic + Direct]
    //  totalBound       = cumulative[Organic + Direct + Social]

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

    // ── Layout ────────────────────────────────────────────────────────────────
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
                text: "Area Chart — Monthly Website Traffic by Source (stacked)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                }

                axisX: ValueAxis {
                    min: 0; max: 11
                    tickInterval: 1
                    labelFormat: "%g"
                }
                axisY: ValueAxis {
                    min: 0; max: 1400
                    gridVisible: false
                    tickInterval: 200
                    labelFormat: "%g"
                }

                // ── Organic (bottom layer) ────────────────────────────────────
                // lowerSeries omitted → fills from graph bottom to organicBound
                AreaSeries {
                    name: "Organic"
                    color: "#4089b4fa"       // blue  ~25 % opacity
                    borderColor: "#89b4fa"
                    borderWidth: 1
                    upperSeries: organicBound
                }

                // ── Direct (middle layer) ─────────────────────────────────────
                // lower = organic, upper = organic + direct
                AreaSeries {
                    name: "Direct"
                    color: "#40a6e3a1"       // green ~25 % opacity
                    borderColor: "#a6e3a1"
                    borderWidth: 1
                    upperSeries: orgDirectBound
                    lowerSeries: organicBound
                }

                // ── Social (top layer) ────────────────────────────────────────
                // lower = organic + direct, upper = total
                AreaSeries {
                    name: "Social"
                    color: "#40f38ba8"       // pink  ~25 % opacity
                    borderColor: "#f38ba8"
                    borderWidth: 1
                    upperSeries: totalBound
                    lowerSeries: orgDirectBound
                }
            }

            AreaChartStackedDescription {}
        }
    }
}
