import QtQuick
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples

Item {
    id: root

    LineChartEditorDataProvider { id: dp }

    // ── Series state ──────────────────────────────────────────────────────
    // Each QtObject holds the LineSeries visual properties plus a block of
    // "dlg*" properties that drive the per-series pointDelegate Component.
    QtObject {
        id: s0
        property string name:      "London"
        property string color:     "#89b4fa"
        property real   lineWidth: 2.0
        property real   opacity:   1.0
        // Point delegate config
        property bool   dlgEnabled:       false
        property bool   dlgShowDot:       true
        property real   dlgDotSize:       10
        property bool   dlgShowLabel:     true
        property string dlgLabelAxis:     "y"     // "x" or "y"
        property int    dlgLabelDecimals: 1
        property real   dlgLabelFontSize: 11
        property string dlgLabelColor:    "#89b4fa"
        property real   dlgLabelOffsetY:  4       // gap (px) between label and dot
    }
    QtObject {
        id: s1
        property string name:      "Madrid"
        property string color:     "#a6e3a1"
        property real   lineWidth: 2.0
        property real   opacity:   1.0
        property bool   dlgEnabled:       false
        property bool   dlgShowDot:       true
        property real   dlgDotSize:       10
        property bool   dlgShowLabel:     true
        property string dlgLabelAxis:     "y"
        property int    dlgLabelDecimals: 1
        property real   dlgLabelFontSize: 11
        property string dlgLabelColor:    "#a6e3a1"
        property real   dlgLabelOffsetY:  4
    }
    QtObject {
        id: s2
        property string name:      "Helsinki"
        property string color:     "#f38ba8"
        property real   lineWidth: 2.0
        property real   opacity:   1.0
        property bool   dlgEnabled:       false
        property bool   dlgShowDot:       true
        property real   dlgDotSize:       10
        property bool   dlgShowLabel:     true
        property string dlgLabelAxis:     "y"
        property int    dlgLabelDecimals: 1
        property real   dlgLabelFontSize: 11
        property string dlgLabelColor:    "#f38ba8"
        property real   dlgLabelOffsetY:  4
    }

    // ── Axis state ────────────────────────────────────────────────────────
    QtObject {
        id: xState
        property real   min:  0;  property real   max:  11
        property real   tick: 1;  property int    sub:  0
        property string fmt:  "%g"
    }
    QtObject {
        id: yState
        property real   min:  -5; property real   max:  40
        property real   tick: 5;  property int    sub:  0
        // Note: printf-style; non-ASCII chars (e.g. °) are not supported
        property string fmt:  "%g"
    }

    // ── Point delegate Components ─────────────────────────────────────────
    // Each Component closes over its series state object (s0/s1/s2).
    //
    // Injected by Qt Graphs (declare as property to activate):
    //   pointColor, pointBorderColor, pointSelectedColor, pointBorderWidth,
    //   pointValueX, pointValueY, pointSelected, pointIndex
    //
    // IMPORTANT — always assigned, never null:
    //   Setting pointDelegate to null does not make Qt Graphs destroy existing
    //   delegate instances — they stay on screen. The components are therefore
    //   always assigned to each LineSeries, and dlgEnabled drives the
    //   visibility of the children from inside the delegate instead.
    //
    // IMPORTANT — fixed bounding box:
    //   Qt Graphs centres the delegate Item on the data point at creation
    //   time. If width/height change afterwards it does NOT reposition, so
    //   the dot would drift off the line. Fix: constant 120 × 120 px box
    //   (accommodates max dot 40 px + max label 28 px + max offset 30 px).
    //   The dot sits at anchors.centerIn: parent = the data point always.
    Component {
        id: ptComp0
        Item {
            property color pointColor
            property real  pointValueX
            property real  pointValueY

            width: 120; height: 120

            Rectangle {
                id: dot0
                visible: s0.dlgEnabled && s0.dlgShowDot
                width: s0.dlgDotSize; height: s0.dlgDotSize
                radius: s0.dlgDotSize / 2
                anchors.centerIn: parent   // dot centre == item centre == data point
                color: "#1e1e2e"
                border.color: pointColor; border.width: 2
            }

            Text {
                visible: s0.dlgEnabled && s0.dlgShowLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: dot0.top
                anchors.bottomMargin: s0.dlgLabelOffsetY
                text: (s0.dlgLabelAxis === "x" ? pointValueX : pointValueY)
                          .toFixed(s0.dlgLabelDecimals)
                font.pixelSize: s0.dlgLabelFontSize
                font.bold: true
                color: s0.dlgLabelColor
            }
        }
    }

    Component {
        id: ptComp1
        Item {
            property color pointColor
            property real  pointValueX
            property real  pointValueY

            width: 120; height: 120

            Rectangle {
                id: dot1
                visible: s1.dlgEnabled && s1.dlgShowDot
                width: s1.dlgDotSize; height: s1.dlgDotSize
                radius: s1.dlgDotSize / 2
                anchors.centerIn: parent
                color: "#1e1e2e"
                border.color: pointColor; border.width: 2
            }

            Text {
                visible: s1.dlgEnabled && s1.dlgShowLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: dot1.top
                anchors.bottomMargin: s1.dlgLabelOffsetY
                text: (s1.dlgLabelAxis === "x" ? pointValueX : pointValueY)
                          .toFixed(s1.dlgLabelDecimals)
                font.pixelSize: s1.dlgLabelFontSize
                font.bold: true
                color: s1.dlgLabelColor
            }
        }
    }

    Component {
        id: ptComp2
        Item {
            property color pointColor
            property real  pointValueX
            property real  pointValueY

            width: 120; height: 120

            Rectangle {
                id: dot2
                visible: s2.dlgEnabled && s2.dlgShowDot
                width: s2.dlgDotSize; height: s2.dlgDotSize
                radius: s2.dlgDotSize / 2
                anchors.centerIn: parent
                color: "#1e1e2e"
                border.color: pointColor; border.width: 2
            }

            Text {
                visible: s2.dlgEnabled && s2.dlgShowLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: dot2.top
                anchors.bottomMargin: s2.dlgLabelOffsetY
                text: (s2.dlgLabelAxis === "x" ? pointValueX : pointValueY)
                          .toFixed(s2.dlgLabelDecimals)
                font.pixelSize: s2.dlgLabelFontSize
                font.bold: true
                color: s2.dlgLabelColor
            }
        }
    }

    // ── Layout: chart left, inspector right ───────────────────────────────
    RowLayout {
        anchors.fill: parent; anchors.margins: 12; spacing: 12

        // ── Chart + inline legend ─────────────────────────────────────────
        Item {
            Layout.fillWidth: true; Layout.fillHeight: true

            GraphsView {
                anchors.fill: parent

                theme: GraphsTheme {
                    colorScheme: GraphsTheme.ColorScheme.Dark
                    plotAreaBackgroundVisible: true
                    seriesColors: [s0.color, s1.color, s2.color]
                }

                axisX: ValueAxis {
                    min: xState.min;  max: xState.max
                    tickInterval: xState.tick;  subTickCount: xState.sub
                    labelFormat: xState.fmt
                }
                axisY: ValueAxis {
                    min: yState.min;  max: yState.max
                    tickInterval: yState.tick;  subTickCount: yState.sub
                    labelFormat: yState.fmt
                }

                LineSeries {
                    name: s0.name; width: s0.lineWidth; opacity: s0.opacity
                    pointDelegate: ptComp0
                    Component.onCompleted: {
                        var pts = dp.londonData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: s1.name; width: s1.lineWidth; opacity: s1.opacity
                    pointDelegate: ptComp1
                    Component.onCompleted: {
                        var pts = dp.madridData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
                LineSeries {
                    name: s2.name; width: s2.lineWidth; opacity: s2.opacity
                    pointDelegate: ptComp2
                    Component.onCompleted: {
                        var pts = dp.helsinkiData()
                        for (var i = 0; i < pts.length; i++) append(pts[i].x, pts[i].y)
                    }
                }
            }

            // Inline legend overlay — top-left corner
            Rectangle {
                x: 56; y: 12
                width: legendCol.implicitWidth + 16
                height: legendCol.implicitHeight + 12
                color: "#181825cc"; radius: 6
                border.color: "#313244"; border.width: 1

                Column {
                    id: legendCol; x: 8; y: 6; spacing: 4
                    Row {
                        spacing: 6
                        Rectangle { width: 16; height: 3; radius: 1; color: s0.color; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: s0.name; color: "#cdd6f4"; font.pixelSize: 11 }
                    }
                    Row {
                        spacing: 6
                        Rectangle { width: 16; height: 3; radius: 1; color: s1.color; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: s1.name; color: "#cdd6f4"; font.pixelSize: 11 }
                    }
                    Row {
                        spacing: 6
                        Rectangle { width: 16; height: 3; radius: 1; color: s2.color; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: s2.name; color: "#cdd6f4"; font.pixelSize: 11 }
                    }
                }
            }
        }

        // ── Inspector panel ───────────────────────────────────────────────
        LineChartEditorInspector {
            Layout.preferredWidth: 300
            Layout.fillHeight: true
            series0: s0;  series1: s1;  series2: s2
            xAxisState: xState
            yAxisState: yState
        }
    }
}
