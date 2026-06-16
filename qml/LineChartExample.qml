import QtQuick
import QtQuick.Layouts
import QtGraphs

Item {

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

            axisX: ValueAxis {
                min: 0
                max: 11
                tickInterval: 1
                labelFormat: "%g"
            }

            axisY: ValueAxis {
                min: -5
                max: 40
                tickInterval: 5
                labelFormat: "%g °C"
            }

            // City 1 — London
            LineSeries {
                name: "London"
                XYPoint { x: 0;  y: 5.0  }
                XYPoint { x: 1;  y: 5.5  }
                XYPoint { x: 2;  y: 7.5  }
                XYPoint { x: 3;  y: 10.0 }
                XYPoint { x: 4;  y: 13.5 }
                XYPoint { x: 5;  y: 16.5 }
                XYPoint { x: 6;  y: 18.5 }
                XYPoint { x: 7;  y: 18.5 }
                XYPoint { x: 8;  y: 15.5 }
                XYPoint { x: 9;  y: 12.0 }
                XYPoint { x: 10; y: 8.0  }
                XYPoint { x: 11; y: 5.5  }
            }

            // City 2 — Madrid
            LineSeries {
                name: "Madrid"
                XYPoint { x: 0;  y: 9.0  }
                XYPoint { x: 1;  y: 10.5 }
                XYPoint { x: 2;  y: 13.5 }
                XYPoint { x: 3;  y: 15.5 }
                XYPoint { x: 4;  y: 19.0 }
                XYPoint { x: 5;  y: 24.0 }
                XYPoint { x: 6;  y: 29.0 }
                XYPoint { x: 7;  y: 28.5 }
                XYPoint { x: 8;  y: 24.0 }
                XYPoint { x: 9;  y: 18.5 }
                XYPoint { x: 10; y: 13.0 }
                XYPoint { x: 11; y: 9.5  }
            }

            // City 3 — Helsinki
            LineSeries {
                name: "Helsinki"
                XYPoint { x: 0;  y: -3.5 }
                XYPoint { x: 1;  y: -4.5 }
                XYPoint { x: 2;  y: -1.5 }
                XYPoint { x: 3;  y: 3.5  }
                XYPoint { x: 4;  y: 9.5  }
                XYPoint { x: 5;  y: 14.5 }
                XYPoint { x: 6;  y: 17.5 }
                XYPoint { x: 7;  y: 16.0 }
                XYPoint { x: 8;  y: 11.0 }
                XYPoint { x: 9;  y: 6.0  }
                XYPoint { x: 10; y: 1.0  }
                XYPoint { x: 11; y: -2.0 }
            }
        }
    }
}
