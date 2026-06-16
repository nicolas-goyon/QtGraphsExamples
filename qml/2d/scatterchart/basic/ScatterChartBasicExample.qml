import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    ScatterChartBasicDataProvider { id: dataProvider }

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
                text: "Scatter Chart — Height vs Weight by Group"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340

                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }

                axisX: ValueAxis { min: 140; max: 210; tickInterval: 10; labelFormat: "%g cm" }
                axisY: ValueAxis { min: 40;  max: 130; tickInterval: 10; labelFormat: "%g kg" }

                ScatterSeries {
                    name: "Group A"
                    color: "#0051ff"
                    Component.onCompleted: {
                        var pts = dataProvider.groupAData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                ScatterSeries {
                    name: "Group B"
                    color: "#ff0015"
                    Component.onCompleted: {
                        var pts = dataProvider.groupBData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                ScatterSeries {
                    name: "Group C"
                    color: "#00ff00"
                    Component.onCompleted: {
                        var pts = dataProvider.groupCData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
            }

            ScatterChartBasicDescription {}
        }
    }
}
