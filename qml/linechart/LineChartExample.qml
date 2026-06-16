import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {

    LineChartDataProvider { id: dataProvider }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Line Chart — Monthly Temperature (°C)"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        GraphsView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            theme: GraphsTheme {
                colorScheme: GraphsTheme.ColorScheme.Dark
                plotAreaBackgroundVisible: true
            }

            axisX: ValueAxis { min: 0; max: 11; tickInterval: 1; labelFormat: "%g" }
            axisY: ValueAxis { min: -5; max: 40; tickInterval: 5; labelFormat: "%g °C" }

            LineSeries {
                id: londonSeries
                name: "London"
                Component.onCompleted: {
                    var pts = dataProvider.londonData()
                    for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                }
            }

            LineSeries {
                id: madridSeries
                name: "Madrid"
                Component.onCompleted: {
                    var pts = dataProvider.madridData()
                    for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                }
            }

            LineSeries {
                id: helsinkiSeries
                name: "Helsinki"
                Component.onCompleted: {
                    var pts = dataProvider.helsinkiData()
                    for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                }
            }
        }
    }
}
