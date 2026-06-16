import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1000
    height: 680
    title: "Qt Graphs Examples"

    // ── Top tab bar ───────────────────────────────────────────
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

    // ── Tab content ───────────────────────────────────────────
    StackLayout {
        anchors { top: tabDivider.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
        currentIndex: topTabBar.currentIndex

        ChartPage {
            navItems: [
                { label: "Line Chart",    variants: ["Basic Example", "With Table", "With Target Line"] },
                { label: "Area Chart",    variants: ["Basic Example", "Stacked"] },
                { label: "Bar Chart",     variants: ["Basic Example"] },
                { label: "Scatter Chart", variants: ["Basic Example"] }
            ]
            LineChartBasicExample    {}
            LineChartTableExample    {}
            LineChartTargetExample   {}
            AreaChartBasicExample    {}
            AreaChartStackedExample  {}
            BarChartBasicExample     {}
            ScatterChartBasicExample {}
        }

        ChartPage {
            navItems: [
                { label: "3D Bars",    variants: ["Basic Example"] },
                { label: "3D Surface", variants: ["Basic Example"] }
            ]
            Bars3DBasicExample    {}
            Surface3DBasicExample {}
        }
    }

    // ── Reusable page: sidebar with dropdowns + chart stack ───
    component ChartPage: Item {
        id: page
        property var navItems: []
        default property alias charts: chartStack.children

        // Which group headers are open (array of bool, one per group)
        property var expanded: []
        // Flat index into chartStack
        property int currentIndex: 0

        Component.onCompleted: {
            var arr = []
            for (var i = 0; i < navItems.length; i++) arr.push(true)
            expanded = arr
            // Select the very first variant by default
            currentIndex = 0
        }

        // Flat position of variant [variantPos] inside group [groupPos]
        function flatIndex(groupPos, variantPos) {
            var n = 0
            for (var i = 0; i < groupPos; i++) n += navItems[i].variants.length
            return n + variantPos
        }

        function toggleGroup(groupPos) {
            var arr = expanded.slice()   // copy so the binding fires
            arr[groupPos] = !arr[groupPos]
            expanded = arr
        }

        RowLayout {
            anchors.fill: parent
            spacing: 0

            // ── Sidebar ───────────────────────────────────────
            Rectangle {
                Layout.preferredWidth: 200
                Layout.fillHeight: true
                color: "#1e1e2e"

                ScrollView {
                    anchors.fill: parent
                    contentWidth: availableWidth
                    clip: true

                    Column {
                        width: parent.width
                        topPadding: 10

                        Repeater {
                            model: page.navItems.length

                            // Outer delegate — captures its own group index
                            delegate: Column {
                                id: groupDelegate
                                readonly property int groupPos: index
                                width: parent ? parent.width : 0

                                // ── Group header ──────────────
                                Rectangle {
                                    width: parent.width
                                    height: 42
                                    color: "transparent"

                                    Row {
                                        anchors {
                                            verticalCenter: parent.verticalCenter
                                            left: parent.left; leftMargin: 14
                                        }
                                        spacing: 8

                                        Text {
                                            text: page.expanded[groupDelegate.groupPos] ? "▾" : "▸"
                                            color: "#6c7086"
                                            font.pixelSize: 11
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                        Text {
                                            text: page.navItems[groupDelegate.groupPos].label
                                            color: "#cdd6f4"
                                            font { pixelSize: 13; bold: true }
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: page.toggleGroup(groupDelegate.groupPos)
                                    }
                                }

                                // ── Variants (collapsible) ────
                                Column {
                                    width: parent.width
                                    visible: page.expanded.length > groupDelegate.groupPos
                                             && page.expanded[groupDelegate.groupPos]

                                    Repeater {
                                        model: page.navItems[groupDelegate.groupPos].variants

                                        delegate: Rectangle {
                                            readonly property int variantPos: index
                                            readonly property int flatIdx:
                                                page.flatIndex(groupDelegate.groupPos, variantPos)
                                            readonly property bool active: page.currentIndex === flatIdx

                                            width: parent ? parent.width - 16 : 0
                                            height: 34
                                            radius: 6
                                            anchors.right: parent ? parent.right : undefined
                                            anchors.rightMargin: 8
                                            color: active ? "#89b4fa" : "transparent"

                                            Row {
                                                anchors {
                                                    verticalCenter: parent.verticalCenter
                                                    left: parent.left; leftMargin: 28
                                                }
                                                spacing: 6
                                                Text {
                                                    text: "•"
                                                    color: active ? "#1e1e2e" : "#6c7086"
                                                    font.pixelSize: 10
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                                Text {
                                                    text: modelData
                                                    color: active ? "#1e1e2e" : "#a6adc8"
                                                    font.pixelSize: 12
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: page.currentIndex = flatIdx
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle { Layout.preferredWidth: 1; Layout.fillHeight: true; color: "#313244" }

            // ── Chart area ────────────────────────────────────
            StackLayout {
                id: chartStack
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: page.currentIndex
            }
        }
    }
}
