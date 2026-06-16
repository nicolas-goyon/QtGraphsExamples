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
                { label: "Line Chart",    variants: ["Basic Example", "With Table", "With Target Line", "With Range", "Stacked", "Stacked + Hover"] },
                { label: "Area Chart",    variants: ["Basic Example", "Stacked", "With Point Labels", "Stacked + Side Legend", "Stacked + Inline Labels"] },
                { label: "Bar Chart",     variants: ["Basic Example"] },
                { label: "Scatter Chart", variants: ["Basic Example"] }
            ]
            LineChartBasicExample        {}
            LineChartTableExample        {}
            LineChartTargetExample       {}
            LineChartRangeExample        {}
            LineChartStackedExample      {}
            LineChartStackedHoverExample {}
            AreaChartBasicExample        {}
            AreaChartStackedExample      {}
            AreaChartPointLabelsExample          {}
            AreaChartStackedSideLegendExample    {}
            AreaChartStackedInlineLabelsExample  {}
            BarChartBasicExample                 {}
            ScatterChartBasicExample     {}
        }

        // ── 3D Charts ─────────────────────────────────────────────────────────
        ChartPage {
            navItems: [
                { label: "3D Bars",    variants: ["Basic Example"] },
                { label: "3D Surface", variants: ["Basic Example"] }
            ]
            Bars3DBasicExample    {}
            Surface3DBasicExample {}
        }
    }
}
