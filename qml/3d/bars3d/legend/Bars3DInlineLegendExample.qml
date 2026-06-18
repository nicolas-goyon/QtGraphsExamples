import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root
    Bars3DLegendDataProvider { id: dataProvider }

    // Keep in sync with Bar3DSeries baseColor below
    readonly property var seriesColors: ["#6ab187", "#d45f5f"]
    readonly property var seriesNames:  ["Urban (M)", "Rural (M)"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "3D Bars — Urban vs. Rural Population with Inline Legend"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Bars3D {
                anchors.fill: parent

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                }

                cameraXRotation: 20
                cameraYRotation: 30

                shadowQuality: Graphs3D.ShadowQuality.Medium
                shadowStrength:       10
                lightStrength:        10
                ambientLightStrength:  0

                rowAxis: Category3DAxis {
                    title: "Country"
                    titleVisible: true
                }
                columnAxis: Category3DAxis {
                    title: "Population Type"
                    titleVisible: true
                }
                valueAxis: Value3DAxis {
                    title: "Population (M)"
                    titleVisible: true
                    min: 0; max: 1000
                }

                Bar3DSeries {
                    name: "Urban (M)"
                    baseColor: "#6ab187"
                    ItemModelBarDataProxy {
                        itemModel: dataProvider
                        rowRole:   "country"
                        columnRole: "country"
                        columnRolePattern: /^.*$/
                        columnRoleReplace: "Population"
                        valueRole: "urban"
                    }
                }

                Bar3DSeries {
                    name: "Rural (M)"
                    baseColor: "#d45f5f"
                    ItemModelBarDataProxy {
                        itemModel: dataProvider
                        rowRole:   "country"
                        columnRole: "country"
                        columnRolePattern: /^.*$/
                        columnRoleReplace: "Population"
                        valueRole: "rural"
                    }
                }
            }

            // ── Inline legend overlay (top-right inside the 3D view) ──────────
            Rectangle {
                anchors { top: parent.top; right: parent.right; margins: 12 }
                width: 120
                height: legendCol.implicitHeight + 16
                color: "#cc1e1e2e"
                radius: 6
                border.color: "#313244"; border.width: 1

                Column {
                    id: legendCol
                    anchors { fill: parent; margins: 8 }
                    spacing: 6

                    Text {
                        text: "Legend"
                        color: "#89b4fa"
                        font { bold: true; pixelSize: 11 }
                    }

                    Repeater {
                        model: seriesNames

                        Row {
                            spacing: 6
                            Rectangle {
                                width: 14; height: 14; radius: 2
                                color: seriesColors[index]
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: modelData
                                color: "#cdd6f4"
                                font.pixelSize: 11
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
        }

        Bars3DInlineLegendDescription {}
    }
}
