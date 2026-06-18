import QtQuick

// Reusable radar / spider chart drawn with Qt Quick Canvas.
//
// Usage:
//   RadarChart {
//       axes:     ["Speed", "Strength", "Endurance", "Agility", "Accuracy"]
//       series:   [
//           { name: "Sprinter",    color: "#89b4fa", values: [95, 72, 55, 85, 78] },
//           { name: "Powerlifter", color: "#f38ba8", values: [60, 98, 45, 50, 62] }
//       ]
//       maxValue: 100
//   }
Canvas {
    id: root

    // ── Public API ────────────────────────────────────────────────────────────
    property var   axes:         []      // list of axis label strings (min 3)
    property var   series:       []      // [{name, color, values:[…]}]
    property real  maxValue:     100     // top of each axis scale
    property int   gridLevels:   5       // number of concentric grid rings
    property real  fillOpacity:  0.15   // polygon fill alpha
    property color gridColor:    "#45475a"
    property color labelColor:   "#cdd6f4"
    property color valueLabelColor: "#585b70"

    // Repaint whenever inputs change
    onAxesChanged:     requestPaint()
    onSeriesChanged:   requestPaint()
    onMaxValueChanged: requestPaint()
    onWidthChanged:    requestPaint()
    onHeightChanged:   requestPaint()

    implicitWidth:  400
    implicitHeight: 400

    // ── Drawing ───────────────────────────────────────────────────────────────
    onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        var n = axes.length
        if (n < 3) return

        var cx      = width  / 2
        var cy      = height / 2
        var radius  = Math.min(cx, cy) * 0.68
        var TAU     = 2 * Math.PI
        var start   = -Math.PI / 2          // first spoke points straight up

        // ── Helper: angle for spoke i ────────────────────────────────────────
        function spokeAngle(i) { return start + (i / n) * TAU }

        // ── Helper: Cartesian point on spoke i at distance r ─────────────────
        function spokePoint(i, r) {
            var a = spokeAngle(i)
            return { x: cx + r * Math.cos(a), y: cy + r * Math.sin(a) }
        }

        // ── Grid rings ────────────────────────────────────────────────────────
        for (var lvl = 1; lvl <= gridLevels; lvl++) {
            var r = radius * lvl / gridLevels
            ctx.beginPath()
            for (var i = 0; i < n; i++) {
                var pt = spokePoint(i, r)
                if (i === 0) ctx.moveTo(pt.x, pt.y)
                else         ctx.lineTo(pt.x, pt.y)
            }
            ctx.closePath()
            ctx.strokeStyle = gridColor
            ctx.lineWidth   = 1
            ctx.globalAlpha = lvl === gridLevels ? 0.55 : 0.30
            ctx.stroke()
        }

        // ── Spokes ────────────────────────────────────────────────────────────
        ctx.globalAlpha = 0.45
        ctx.strokeStyle = gridColor
        ctx.lineWidth   = 1
        for (var i = 0; i < n; i++) {
            var outer = spokePoint(i, radius)
            ctx.beginPath()
            ctx.moveTo(cx, cy)
            ctx.lineTo(outer.x, outer.y)
            ctx.stroke()
        }
        ctx.globalAlpha = 1.0

        // ── Series polygons ───────────────────────────────────────────────────
        for (var s = 0; s < series.length; s++) {
            var ser = series[s]
            var pts = []
            for (var i = 0; i < n; i++) {
                var val = Math.max(0, Math.min(ser.values[i], maxValue))
                pts.push(spokePoint(i, radius * val / maxValue))
            }

            // Filled polygon
            ctx.beginPath()
            ctx.moveTo(pts[0].x, pts[0].y)
            for (var i = 1; i < pts.length; i++) ctx.lineTo(pts[i].x, pts[i].y)
            ctx.closePath()
            var c = Qt.color(ser.color)
            ctx.fillStyle   = Qt.rgba(c.r, c.g, c.b, fillOpacity)
            ctx.globalAlpha = 1.0
            ctx.fill()

            // Outline
            ctx.beginPath()
            ctx.moveTo(pts[0].x, pts[0].y)
            for (var i = 1; i < pts.length; i++) ctx.lineTo(pts[i].x, pts[i].y)
            ctx.closePath()
            ctx.strokeStyle = ser.color
            ctx.lineWidth   = 2
            ctx.stroke()

            // Data-point dots
            for (var i = 0; i < pts.length; i++) {
                ctx.beginPath()
                ctx.arc(pts[i].x, pts[i].y, 4, 0, TAU)
                ctx.fillStyle   = ser.color
                ctx.globalAlpha = 1.0
                ctx.fill()
                ctx.strokeStyle = "#1e1e2e"
                ctx.lineWidth   = 1.5
                ctx.stroke()
            }
        }

        // ── Scale value labels (on the first spoke) ───────────────────────────
        ctx.font         = "10px sans-serif"
        ctx.textAlign    = "left"
        ctx.textBaseline = "middle"
        ctx.globalAlpha  = 1.0
        for (var lvl = 1; lvl <= gridLevels; lvl++) {
            var r    = radius * lvl / gridLevels
            var pt   = spokePoint(0, r)
            ctx.fillStyle = valueLabelColor
            ctx.fillText(String(Math.round(maxValue * lvl / gridLevels)), pt.x + 4, pt.y - 4)
        }

        // ── Axis labels ───────────────────────────────────────────────────────
        ctx.fillStyle = labelColor
        ctx.font      = "bold 12px sans-serif"
        for (var i = 0; i < n; i++) {
            var angle  = spokeAngle(i)
            var cosA   = Math.cos(angle)
            var sinA   = Math.sin(angle)
            var offset = radius + 20
            var lx     = cx + offset * cosA
            var ly     = cy + offset * sinA

            // Horizontal alignment: follow the spoke direction
            if      (cosA < -0.2) ctx.textAlign    = "right"
            else if (cosA >  0.2) ctx.textAlign    = "left"
            else                  ctx.textAlign    = "center"

            // Vertical alignment
            if      (sinA < -0.2) ctx.textBaseline = "bottom"
            else if (sinA >  0.2) ctx.textBaseline = "top"
            else                  ctx.textBaseline = "middle"

            ctx.fillText(axes[i], lx, ly)
        }
    }
}
