import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Sankey with a PARTIAL intermediate layer — pure-QML Canvas implementation.
// Most flows go straight from the income column to the budget column, but the
// two earned-income sources (Salary, Freelance) are routed through an extra
// "Tax" node that sits in a layer of its own between them. Investments and
// Gift skip that layer entirely (their links span two layers at once). The Tax
// node also splits off an early output — Taxes Paid — that leaves before the
// final expense column.
//
// The renderer is the same generic layered Sankey used by the multi-layer
// variant: because links may connect any two layers, a node only needs to be
// placed in an intermediate layer for SOME flows — the rest route around it as
// longer ribbons. Qt Graphs has no Sankey series; everything is drawn with the
// Qt Quick 2D Canvas API.
Item {
    id: page

    readonly property var nodes: [
        // Layer 0 — income sources
        { id: "salary",     name: "Salary",      layer: 0, color: "#89b4fa" },
        { id: "freelance",  name: "Freelance",   layer: 0, color: "#74c7ec" },
        { id: "investments",name: "Investments", layer: 0, color: "#a6e3a1" },
        { id: "gift",       name: "Gift",        layer: 0, color: "#f9e2af" },
        // Layer 1 — PARTIAL: only earned income passes through here
        { id: "tax",        name: "Tax",         layer: 1, color: "#f38ba8" },
        // Layer 2 — net budget pool (+ the tax that left the system)
        { id: "netbudget",  name: "Net Budget",  layer: 2, color: "#94e2d5" },
        { id: "taxespaid",  name: "Taxes Paid",  layer: 2, color: "#6c7086" },
        // Layer 3 — spending
        { id: "housing",    name: "Housing",     layer: 3, color: "#cba6f7" },
        { id: "food",       name: "Food",        layer: 3, color: "#fab387" },
        { id: "savings",    name: "Savings",     layer: 3, color: "#a6e3a1" },
        { id: "leisure",    name: "Leisure",     layer: 3, color: "#f5c2e7" }
    ]
    readonly property var links: [
        { source: "salary",      target: "tax",       value: 3000 },
        { source: "freelance",   target: "tax",       value: 800 },
        { source: "tax",         target: "taxespaid", value: 900 },
        { source: "tax",         target: "netbudget", value: 2900 },
        { source: "investments", target: "netbudget", value: 500 },  // skips Tax layer
        { source: "gift",        target: "netbudget", value: 200 },  // skips Tax layer
        { source: "netbudget",   target: "housing",   value: 1200 },
        { source: "netbudget",   target: "food",      value: 600 },
        { source: "netbudget",   target: "savings",   value: 900 },
        { source: "netbudget",   target: "leisure",   value: 900 }
    ]

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
                text: "Partial Layer — Monthly Cashflow (Tax routes only earned income)"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 520
                color: "#181825"; radius: 8
                border.color: "#313244"; border.width: 1

                Canvas {
                    id: canvas
                    anchors { fill: parent; margins: 12 }
                    antialiasing: true

                    onWidthChanged:  requestPaint()
                    onHeightChanged: requestPaint()
                    Component.onCompleted: requestPaint()

                    function withAlpha(hex, a) {
                        var r = parseInt(hex.substr(1, 2), 16)
                        var g = parseInt(hex.substr(3, 2), 16)
                        var b = parseInt(hex.substr(5, 2), 16)
                        return "rgba(" + r + "," + g + "," + b + "," + a + ")"
                    }

                    function fmt(v) {
                        var s = String(v), out = "", c = 0
                        for (var i = s.length - 1; i >= 0; i--) {
                            out = s[i] + out; c++
                            if (c % 3 === 0 && i > 0) out = "," + out
                        }
                        return "$" + out
                    }

                    function ribbon(ctx, x0, y0a, y0b, x1, y1a, y1b, fill) {
                        var xc = (x0 + x1) / 2
                        ctx.beginPath()
                        ctx.moveTo(x0, y0a)
                        ctx.bezierCurveTo(xc, y0a, xc, y1a, x1, y1a)
                        ctx.lineTo(x1, y1b)
                        ctx.bezierCurveTo(xc, y1b, xc, y0b, x0, y0b)
                        ctx.closePath()
                        ctx.fillStyle = fill
                        ctx.fill()
                    }

                    // Generic layered Sankey — links may span non-adjacent layers,
                    // which is what lets the Tax layer be partial (skip-links).
                    function computeLayout(W, H) {
                        var ns = page.nodes, ls = page.links
                        var byId = {}, maxLayer = 0
                        for (var i = 0; i < ns.length; i++) {
                            byId[ns[i].id] = { def: ns[i], inV: 0, outV: 0, x: 0, y: 0, h: 0 }
                            if (ns[i].layer > maxLayer) maxLayer = ns[i].layer
                        }
                        for (i = 0; i < ls.length; i++) {
                            byId[ls[i].source].outV += ls[i].value
                            byId[ls[i].target].inV  += ls[i].value
                        }
                        for (var key in byId)
                            byId[key].val = Math.max(byId[key].inV, byId[key].outV)

                        var layers = []
                        for (i = 0; i <= maxLayer; i++) layers.push([])
                        for (i = 0; i < ns.length; i++) layers[ns[i].layer].push(ns[i].id)

                        var marginTop = 40, marginBottom = 28
                        var leftPad = 120, rightPad = 130, nodeW = 16, gap = 22
                        var plotH = H - marginTop - marginBottom

                        var scale = Infinity
                        for (i = 0; i < layers.length; i++) {
                            var sv = 0
                            for (var j = 0; j < layers[i].length; j++) sv += byId[layers[i][j]].val
                            if (sv > 0) {
                                var s = (plotH - (layers[i].length - 1) * gap) / sv
                                if (s < scale) scale = s
                            }
                        }
                        var innerW = W - leftPad - rightPad - nodeW

                        for (i = 0; i < layers.length; i++) {
                            var col = layers[i]
                            var sv2 = 0
                            for (j = 0; j < col.length; j++) sv2 += byId[col[j]].val
                            var colH = sv2 * scale + (col.length - 1) * gap
                            var y = marginTop + (plotH - colH) / 2
                            var x = leftPad + (maxLayer > 0 ? i * (innerW / maxLayer) : 0)
                            for (j = 0; j < col.length; j++) {
                                var nd = byId[col[j]]
                                nd.x = x; nd.h = nd.val * scale; nd.y = y
                                y += nd.h + gap
                            }
                        }

                        function cy(id) { return byId[id].y + byId[id].h / 2 }
                        var outMap = {}, inMap = {}
                        for (i = 0; i < ns.length; i++) { outMap[ns[i].id] = []; inMap[ns[i].id] = [] }
                        for (i = 0; i < ls.length; i++) { outMap[ls[i].source].push(i); inMap[ls[i].target].push(i) }
                        for (key in outMap)
                            outMap[key].sort(function (a, b) { return cy(ls[a].target) - cy(ls[b].target) })
                        for (key in inMap)
                            inMap[key].sort(function (a, b) { return cy(ls[a].source) - cy(ls[b].source) })

                        var srcTop = {}, tgtTop = {}
                        for (key in outMap) {
                            var acc = byId[key].y
                            for (i = 0; i < outMap[key].length; i++) {
                                srcTop[outMap[key][i]] = acc
                                acc += ls[outMap[key][i]].value * scale
                            }
                        }
                        for (key in inMap) {
                            var acc2 = byId[key].y
                            for (i = 0; i < inMap[key].length; i++) {
                                tgtTop[inMap[key][i]] = acc2
                                acc2 += ls[inMap[key][i]].value * scale
                            }
                        }

                        var linkGeom = []
                        for (i = 0; i < ls.length; i++) {
                            var L = ls[i], sN = byId[L.source], tN = byId[L.target]
                            var hh = L.value * scale
                            linkGeom.push({
                                x0: sN.x + nodeW, y0a: srcTop[i], y0b: srcTop[i] + hh,
                                x1: tN.x,         y1a: tgtTop[i], y1b: tgtTop[i] + hh,
                                value: L.value, color: sN.def.color,
                                skip: tN.def.layer - sN.def.layer > 1
                            })
                        }
                        var nodeGeom = []
                        for (i = 0; i < ns.length; i++) {
                            var nd2 = byId[ns[i].id]
                            nodeGeom.push({
                                def: ns[i], x: nd2.x, y: nd2.y, w: nodeW, h: nd2.h,
                                val: nd2.val, layer: ns[i].layer
                            })
                        }
                        return { nodes: nodeGeom, links: linkGeom, nodeW: nodeW, maxLayer: maxLayer }
                    }

                    function drawNode(ctx, N, maxLayer) {
                        ctx.fillStyle = N.def.color
                        ctx.fillRect(N.x, N.y, N.w, N.h)
                        var cyy = N.y + N.h / 2
                        if (N.layer === 0) {
                            ctx.textAlign = "right"
                            ctx.fillStyle = "#cdd6f4"; ctx.fillText(N.def.name, N.x - 8, cyy - 7)
                            ctx.fillStyle = "#6c7086"; ctx.fillText(canvas.fmt(N.val), N.x - 8, cyy + 8)
                        } else if (N.layer === maxLayer) {
                            ctx.textAlign = "left"
                            ctx.fillStyle = "#cdd6f4"; ctx.fillText(N.def.name, N.x + N.w + 8, cyy - 7)
                            ctx.fillStyle = "#6c7086"; ctx.fillText(canvas.fmt(N.val), N.x + N.w + 8, cyy + 8)
                        } else {
                            ctx.textAlign = "center"
                            ctx.fillStyle = "#cdd6f4"
                            ctx.fillText(N.def.name + " · " + canvas.fmt(N.val), N.x + N.w / 2, N.y - 11)
                        }
                    }

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()
                        ctx.clearRect(0, 0, width, height)
                        var g = computeLayout(width, height)
                        ctx.font = "12px sans-serif"
                        ctx.textBaseline = "middle"
                        for (var i = 0; i < g.links.length; i++) {
                            var L = g.links[i]
                            // Skip-links (that bypass the partial layer) draw a touch
                            // lighter so the routed-through flows read as primary.
                            canvas.ribbon(ctx, L.x0, L.y0a, L.y0b, L.x1, L.y1a, L.y1b,
                                          canvas.withAlpha(L.color, L.skip ? 0.30 : 0.45))
                        }
                        for (i = 0; i < g.nodes.length; i++)
                            canvas.drawNode(ctx, g.nodes[i], g.maxLayer)
                    }
                }
            }

            FlowChartPartialDescription {}
        }
    }
}
