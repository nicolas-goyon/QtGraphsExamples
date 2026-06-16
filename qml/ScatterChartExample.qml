import QtQuick
import QtQuick.Layouts
import QtGraphs

Item {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Scatter Chart — Height vs Weight by Group"
            font { pixelSize: 16; bold: true }
            color: "#cdd6f4"
        }

        GraphsView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            theme: GraphsTheme {
                colorScheme: GraphsTheme.ColorScheme.Dark
            }

            axisX: ValueAxis {
                min: 140
                max: 210
                tickInterval: 10
                labelFormat: "%g cm"
            }

            axisY: ValueAxis {
                min: 40
                max: 130
                tickInterval: 10
                labelFormat: "%g kg"
            }

            ScatterSeries {
                name: "Group A"
                XYPoint { x: 158; y: 55 }
                XYPoint { x: 162; y: 58 }
                XYPoint { x: 165; y: 61 }
                XYPoint { x: 168; y: 63 }
                XYPoint { x: 155; y: 52 }
                XYPoint { x: 170; y: 66 }
                XYPoint { x: 163; y: 57 }
                XYPoint { x: 159; y: 56 }
            }

            ScatterSeries {
                name: "Group B"
                XYPoint { x: 175; y: 75 }
                XYPoint { x: 180; y: 80 }
                XYPoint { x: 185; y: 85 }
                XYPoint { x: 178; y: 78 }
                XYPoint { x: 182; y: 82 }
                XYPoint { x: 190; y: 92 }
                XYPoint { x: 176; y: 76 }
                XYPoint { x: 183; y: 84 }
            }

            ScatterSeries {
                name: "Group C"
                XYPoint { x: 192; y: 100 }
                XYPoint { x: 195; y: 105 }
                XYPoint { x: 200; y: 110 }
                XYPoint { x: 188; y: 95  }
                XYPoint { x: 197; y: 108 }
                XYPoint { x: 204; y: 115 }
                XYPoint { x: 191; y: 98  }
                XYPoint { x: 198; y: 107 }
            }
        }
    }
}
