import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs

Item {
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
                text: "Pie Chart (Donut) — Browser Market Share (2024)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                PieSeries {
                    pieSize: 0.85
                    holeSize: 0.45   // non-zero holeSize turns the pie into a donut

                    PieSlice { label: "Chrome";  value: 65.2; color: "#89b4fa"; labelVisible: true }
                    PieSlice { label: "Safari";  value: 18.9; color: "#a6e3a1"; labelVisible: true }
                    PieSlice { label: "Edge";    value:  5.1; color: "#f9e2af"; labelVisible: true }
                    PieSlice { label: "Firefox"; value:  2.8; color: "#f38ba8"; labelVisible: true }
                    PieSlice { label: "Samsung"; value:  2.5; color: "#cba6f7"; labelVisible: true }
                    PieSlice { label: "Other";   value:  5.5; color: "#fab387"; labelVisible: true }
                }
            }

            PieChartDonutDescription {}
        }
    }
}
