import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    LineChartBasicDataProvider { id: dataProvider }

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
                text: "Line Chart — Monthly Temperature (°C)"
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

                axisX: ValueAxis { min: 0; max: 11; tickInterval: 1; labelFormat: "%g" }
                axisY: ValueAxis { min: -5; max: 40; tickInterval: 5; labelFormat: "%g °C" }

                LineSeries {
                    name: "London"
                    Component.onCompleted: {
                        var pts = dataProvider.londonData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: "Madrid"
                    Component.onCompleted: {
                        var pts = dataProvider.madridData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: "Helsinki"
                    Component.onCompleted: {
                        var pts = dataProvider.helsinkiData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
            }

            LineChartBasicDescription {}
        }
    }
}
