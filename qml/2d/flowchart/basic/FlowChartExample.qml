import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Sankey / flow diagram — pure-QML Canvas implementation.
// Qt Graphs has no flow / Sankey series, so the ribbons and nodes are drawn
// directly with the Qt Quick 2D Canvas API (same approach as the radar chart).
//
// The diagram models a system's energy balance: primary energy INPUTS on the
// left flow into a central "Energy System" node, which then splits into the
// end-use OUTPUTS on the right. Because energy is conserved, the sum of the
// inputs equals the sum of the outputs (and the central node height), so every
// ribbon lines up flush against its neighbours with no gaps on the centre node.
Item {
    id: page

    // ── Data ──────────────────────────────────────────────────────────────────
    // value is in the same arbitrary unit (e.g. PJ) for both sides; totals match.
    readonly property var inputs: [
        { name: "Coal",         value: 90, color: "#585b70" },
        { name: "Natural Gas",  value: 80, color: "#f9e2af" },
        { name: "Oil",          value: 70, color: "#fab387" },
        { name: "Nuclear",      value: 40, color: "#cba6f7" },
        { name: "Renewables",   value: 60, color: "#a6e3a1" }
    ]
    readonly property var outputs: [
        { name: "Electricity & Heat", value: 120, color: "#89b4fa" },
        { name: "Transport",          value: 80,  color: "#f38ba8" },
        { name: "Industry",           value: 70,  color: "#fab387" },
        { name: "Buildings",          value: 40,  color: "#94e2d5" },
        { name: "Conversion Losses",  value: 30,  color: "#6c7086" }
    ]
    readonly property string centreName: "Energy System"

    function sum(arr) {
        var t = 0
        for (var i = 0; i < arr.length; i++) t += arr[i].value
        return t
    }

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
                text: "Flow Diagram — Energy Inputs & Outputs of a System"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            // Sankey container
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 460
                color: "#181825"; radius: 8
                border.color: "#313244"; border.width: 1

                Canvas {
                    id: canvas
                    anchors { fill: parent; margins: 12 }
                    antialiasing: true

                    onWidthChanged:  requestPaint()
                    onHeightChanged: requestPaint()
                    Component.onCompleted: requestPaint()

                    // Draw one Sankey ribbon between a source edge segment
                    // (x0, top y0a .. bottom y0b) and a target edge segment
                    // (x1, top y1a .. bottom y1b) as a filled bezier band.
                    function ribbon(ctx, x0, y0a, y0b, x1, y1a, y1b, fill) {
                        var xc = (x0 + x1) / 2
                        ctx.beginPath()
                        ctx.moveTo(x0, y0a)
                        ctx.bezierCurveTo(xc, y0a, xc, y1a, x1, y1a)   // top edge
                        ctx.lineTo(x1, y1b)
                        ctx.bezierCurveTo(xc, y1b, xc, y0b, x0, y0b)   // bottom edge (back)
                        ctx.closePath()
                        ctx.fillStyle = fill
                        ctx.fill()
                    }

                    // Convert "#rrggbb" + alpha into an rgba() string for ribbons.
                    function withAlpha(hex, a) {
                        var r = parseInt(hex.substr(1, 2), 16)
                        var g = parseInt(hex.substr(3, 2), 16)
                        var b = parseInt(hex.substr(5, 2), 16)
                        return "rgba(" + r + "," + g + "," + b + "," + a + ")"
                    }

                    onPaint: {
                        var ctx = getContext("2d")
                        var W = width, H = height
                        ctx.reset()
                        ctx.clearRect(0, 0, W, H)

                        var inp = page.inputs, out = page.outputs
                        var n = inp.length, m = out.length
                        var total = page.sum(inp)        // == page.sum(out)

                        // Layout constants
                        var marginTop = 28, marginBottom = 28
                        var leftLabelW = 116, rightLabelW = 150
                        var nodeW = 16, labelGap = 8
                        var gap = 16                     // vertical gap between stacked nodes

                        var plotH = H - marginTop - marginBottom
                        var maxGaps = Math.max(n - 1, m - 1) * gap
                        var scale = (plotH - maxGaps) / total    // px per unit value

                        // Column x positions
                        var xLeft   = leftLabelW
                        var xCentre = (W - nodeW) / 2
                        var xRight  = W - rightLabelW - nodeW

                        // Stack heights (with gaps) for centring each column
                        var leftStackH  = total * scale + (n - 1) * gap
                        var rightStackH = total * scale + (m - 1) * gap
                        var centreH     = total * scale

                        var leftY0   = marginTop + (plotH - leftStackH) / 2
                        var rightY0  = marginTop + (plotH - rightStackH) / 2
                        var centreY0 = marginTop + (plotH - centreH) / 2

                        ctx.font = "12px sans-serif"
                        ctx.textBaseline = "middle"

                        // ── Ribbons: inputs → centre ──────────────────────────
                        // Centre's left edge is split into input-ordered segments
                        // (no gaps) so they sum exactly to the centre height.
                        var ly = leftY0, cy = centreY0
                        for (var i = 0; i < n; i++) {
                            var h = inp[i].value * scale
                            canvas.ribbon(ctx,
                                          xLeft + nodeW, ly, ly + h,
                                          xCentre,       cy, cy + h,
                                          canvas.withAlpha(inp[i].color, 0.45))
                            ly += h + gap
                            cy += h
                        }

                        // ── Ribbons: centre → outputs ─────────────────────────
                        var cyR = centreY0, ry = rightY0
                        for (var j = 0; j < m; j++) {
                            var ho = out[j].value * scale
                            canvas.ribbon(ctx,
                                          xCentre + nodeW, cyR, cyR + ho,
                                          xRight,          ry,  ry + ho,
                                          canvas.withAlpha(out[j].color, 0.45))
                            cyR += ho
                            ry += ho + gap
                        }

                        // ── Nodes + labels: inputs ────────────────────────────
                        ly = leftY0
                        ctx.textAlign = "right"
                        for (i = 0; i < n; i++) {
                            var hi = inp[i].value * scale
                            ctx.fillStyle = inp[i].color
                            ctx.fillRect(xLeft, ly, nodeW, hi)
                            ctx.fillStyle = "#cdd6f4"
                            ctx.fillText(inp[i].name, xLeft - labelGap, ly + hi / 2 - 7)
                            ctx.fillStyle = "#6c7086"
                            ctx.fillText(inp[i].value + " PJ", xLeft - labelGap, ly + hi / 2 + 8)
                            ly += hi + gap
                        }

                        // ── Nodes + labels: outputs ───────────────────────────
                        ry = rightY0
                        ctx.textAlign = "left"
                        for (j = 0; j < m; j++) {
                            var hj = out[j].value * scale
                            ctx.fillStyle = out[j].color
                            ctx.fillRect(xRight, ry, nodeW, hj)
                            ctx.fillStyle = "#cdd6f4"
                            ctx.fillText(out[j].name, xRight + nodeW + labelGap, ry + hj / 2 - 7)
                            ctx.fillStyle = "#6c7086"
                            ctx.fillText(out[j].value + " PJ", xRight + nodeW + labelGap, ry + hj / 2 + 8)
                            ry += hj + gap
                        }

                        // ── Centre node + label ───────────────────────────────
                        ctx.fillStyle = "#45475a"
                        ctx.fillRect(xCentre, centreY0, nodeW, centreH)
                        ctx.fillStyle = "#cdd6f4"
                        ctx.textAlign = "center"
                        ctx.fillText(page.centreName, xCentre + nodeW / 2, centreY0 - 12)
                        ctx.fillStyle = "#6c7086"
                        ctx.fillText(total + " PJ", xCentre + nodeW / 2, centreY0 + centreH + 12)
                    }
                }
            }

            FlowChartDescription {}
        }
    }
}
