import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1000
    height: 680
    title: "Qt Graphs Examples"

    // ── Top tab bar ───────────────────────────────────────────────────────────
    TabBar {
        id: topTabBar
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: 44
        background: Rectangle { color: "#181825" }

        Repeater {
            model: ["2D Charts", "3D Charts"]
            TabButton {
                text: modelData
                width: implicitWidth + 32
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? "#89b4fa" : "#6c7086"
                    font { pixelSize: 14; bold: parent.checked }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: "transparent"
                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width; height: 2
                        color: parent.parent.checked ? "#89b4fa" : "transparent"
                    }
                }
            }
        }
    }

    Rectangle {
        id: tabDivider
        anchors { top: topTabBar.bottom; left: parent.left; right: parent.right }
        height: 1; color: "#313244"
    }

    // ── Tab content ───────────────────────────────────────────────────────────
    StackLayout {
        anchors { top: tabDivider.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
        currentIndex: topTabBar.currentIndex

        // ── 2D Charts ─────────────────────────────────────────────────────────
        ChartPage {
            navItems: [
                { label: "Line Chart",         variants: ["Basic Example", "With Table", "With Target Line", "With Range", "Stacked", "Stacked + Hover", "Legend Inline", "Legend Below", "Live", "Live Editor"] },
                { label: "Spline Chart",       variants: ["Basic Example", "Legend Inline", "Legend Below", "Live"] },
                { label: "Area Chart",         variants: ["Basic Example", "Stacked", "With Point Labels", "Stacked + Side Legend", "Stacked + Inline Labels", "Live"] },
                { label: "Bar Chart",          variants: ["Basic Example", "Stacked", "With Labels", "With Target Line", "Stacked 100%", "Horizontal", "Mixed + Line", "Legend Inline", "Legend Below"] },
                { label: "Scatter Chart",      variants: ["Basic Example", "With Trend Line", "Custom Markers", "With Hover", "Multi Trendlines", "Averages", "Legend Inline", "Legend Aside", "Live"] },
                { label: "Population Pyramid", variants: ["Basic Example"] },
                { label: "Heatmap",            variants: ["Basic Example"] },
                { label: "Pie Chart",          variants: ["Basic Example", "Donut"] },
                { label: "Radar Chart",        variants: ["Basic Example", "Multi-Series", "Legend Inline", "Legend Below"] }
            ]
            LineChartBasicExample        {}
            LineChartTableExample        {}
            LineChartTargetExample       {}
            LineChartRangeExample        {}
            LineChartStackedExample      {}
            LineChartStackedHoverExample {}
            LineChartInlineLegendExample {}
            LineChartSideLegendExample   {}
            LiveLineChartExample         {}
            LineChartEditorExample       {}
            SplineChartBasicExample          {}
            SplineChartInlineLegendExample   {}
            SplineChartSideLegendExample     {}
            LiveSplineChartExample           {}
            AreaChartBasicExample               {}
            AreaChartStackedExample             {}
            AreaChartPointLabelsExample         {}
            AreaChartStackedSideLegendExample   {}
            AreaChartStackedInlineLabelsExample {}
            LiveAreaChartExample                {}
            BarChartBasicExample          {}
            BarChartStackedExample        {}
            BarChartLabelsExample         {}
            BarChartTargetLineExample     {}
            BarChartStackedPercentExample {}
            BarChartHorizontalExample     {}
            BarChartMixedLineExample      {}
            BarChartInlineLegendExample   {}
            BarChartSideLegendExample     {}
            ScatterChartBasicExample          {}
            ScatterChartTrendLineExample      {}
            ScatterChartCustomMarkersExample  {}
            ScatterChartHoverExample          {}
            ScatterChartTrendLinesExample     {}
            ScatterChartAveragesExample       {}
            ScatterChartInlineLegendExample   {}
            ScatterChartSideLegendExample     {}
            LiveScatterChartExample           {}
            PopulationPyramidExample {}
            HeatmapExample           {}
            PieChartBasicExample     {}
            PieChartDonutExample     {}
            RadarChartBasicExample          {}
            RadarChartMultiLineExample      {}
            RadarChartInlineLegendExample   {}
            RadarChartSideLegendExample     {}
        }

        // ── 3D Charts ─────────────────────────────────────────────────────────
        ChartPage {
            navItems: [
                { label: "3D Bars",    variants: ["Basic Example", "Legend Inline", "Legend Below"] },
                { label: "3D Surface", variants: ["Basic Example", "Legend Inline", "Legend Aside"] }
            ]
            Bars3DBasicExample        {}
            Bars3DInlineLegendExample {}
            Bars3DSideLegendExample   {}
            Surface3DBasicExample        {}
            Surface3DInlineLegendExample {}
            Surface3DSideLegendExample   {}
        }
    }
}
