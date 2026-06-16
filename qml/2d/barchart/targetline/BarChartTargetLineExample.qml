import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    BarChartTargetLineDataProvider { id: dataProvider }

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
                text: "Bar Chart — Quarterly Sales vs Target (M$)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisY: ValueAxis { min: 0; max: 130; tickInterval: 20; labelFormat: "$%g M" }

                // ── Bars ──────────────────────────────────────────────────────
                BarSeries {
                    axisX: BarCategoryAxis {
                        Component.onCompleted: categories = dataProvider.categories()
                    }
                    BarSet {
                        label: "Quarterly Sales"
                        Component.onCompleted: values = dataProvider.salesValues()
                    }
                }

                // ── Target line ───────────────────────────────────────────────
                // The BarCategoryAxis maps each bar to integer positions 0..n-1,
                // so the target line spans from -0.5 to n-0.5 to cover all bars.
                LineSeries {
                    name: "Target ($85 M)"
                    color: "#f38ba8"
                    width: 2
                    Component.onCompleted: {
                        var t = dataProvider.targetValue()
                        var n = dataProvider.categories().length
                        append(-0.5, t)
                        append(n - 0.5, t)
                    }
                }
            }

            BarChartTargetLineDescription {}
        }
    }
}
