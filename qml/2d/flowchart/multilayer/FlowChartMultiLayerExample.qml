import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Multi-layer Sankey / flow diagram — pure-QML Canvas implementation.
// Unlike the basic two-stage flow, this is a generic layered graph: each node
// declares which "layer" (column) it sits in, and links connect any node to a
// node in the next layer. This lets inputs enter part-way through the system
// (Solar & Wind appears at layer 1, not layer 0) and lets outputs leave early
// (Conversion Losses terminates at layer 2, before the final layer 3).
//
// Qt Graphs has no flow / Sankey series, so nodes (rectangles) and flows
// (cubic-bezier ribbons) are drawn directly with the Qt Quick 2D Canvas API.
Item {
    id: page

    // ── Graph definition ──────────────────────────────────────────────────────
    // A node's bar height is proportional to max(total inflow, total outflow).
    readonly property var nodes: [
        // Layer 0 — primary inputs
        { id: "coal",      name: "Coal",          layer: 0, color: "#585b70" },
        { id: "gas",       name: "Natural Gas",   layer: 0, color: "#f9e2af" },
        { id: "oil",       name: "Oil",           layer: 0, color: "#fab387" },
        // Layer 1 — conversion (+ an input that enters here)
        { id: "power",     name: "Power Plants",  layer: 1, color: "#89b4fa" },
        { id: "refinery",  name: "Refinery",      layer: 1, color: "#eba0ac" },
        { id: "solar",     name: "Solar & Wind",  layer: 1, color: "#a6e3a1" },
        // Layer 2 — energy carriers (+ an output that leaves here)
        { id: "elec",      name: "Electricity",   layer: 2, color: "#89dceb" },
        { id: "fuels",     name: "Fuels",         layer: 2, color: "#fab387" },
        { id: "losses",    name: "Conv. Losses",  layer: 2, color: "#6c7086" },
        // Layer 3 — end uses
        { id: "industry",  name: "Industry",      layer: 3, color: "#cba6f7" },
        { id: "buildings", name: "Buildings",     layer: 3, color: "#94e2d5" },
        { id: "transport", name: "Transport",     layer: 3, color: "#f38ba8" }
    ]
    readonly property var links: [
        { source: "coal",     target: "power",     value: 90 },
        { source: "gas",      target: "power",     value: 50 },
        { source: "gas",      target: "refinery",  value: 30 },
        { source: "oil",      target: "refinery",  value: 70 },
        { source: "power",    target: "elec",      value: 100 },
        { source: "power",    target: "losses",    value: 40 },
        { source: "refinery", target: "fuels",     value: 100 },
        { source: "solar",    target: "elec",      value: 50 },
        { source: "elec",     target: "industry",  value: 60 },
        { source: "elec",     target: "buildings", value: 90 },
        { source: "fuels",    target: "transport", value: 70 },
        { source: "fuels",    target: "industry",  value: 30 }
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
                text: "Multi-Layer Flow — Inputs & Outputs Across Stages"
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

                    // Generic Sankey layout: returns node + link geometry.
                    function computeLayout(W, H) {
                        var ns = page.nodes, ls = page.links
                        var byId = {}
                        var maxLayer = 0
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
                        var leftPad = 130, rightPad = 140, nodeW = 16, gap = 22
                        var plotH = H - marginTop - marginBottom

                        // Pick the largest scale that still lets every column fit.
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

                        // Order links at each node by the other endpoint's centre
                        // (reduces ribbon crossings), then stack them on the edge.
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
                                value: L.value, color: sN.def.color, sId: L.source, tId: L.target,
                                label: sN.def.name + " → " + tN.def.name
                            })
                        }
                        var nodeGeom = []
                        for (i = 0; i < ns.length; i++) {
                            var nd2 = byId[ns[i].id]
                            nodeGeom.push({
                                def: ns[i], x: nd2.x, y: nd2.y, w: nodeW, h: nd2.h, val: nd2.val,
                                layer: ns[i].layer, isSource: nd2.inV === 0, isSink: nd2.outV === 0
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
                            ctx.fillStyle = "#6c7086"; ctx.fillText(N.val + " PJ", N.x - 8, cyy + 8)
                        } else if (N.layer === maxLayer) {
                            ctx.textAlign = "left"
                            ctx.fillStyle = "#cdd6f4"; ctx.fillText(N.def.name, N.x + N.w + 8, cyy - 7)
                            ctx.fillStyle = "#6c7086"; ctx.fillText(N.val + " PJ", N.x + N.w + 8, cyy + 8)
                        } else {
                            ctx.textAlign = "center"
                            ctx.fillStyle = "#cdd6f4"
                            ctx.fillText(N.def.name + " · " + N.val, N.x + N.w / 2, N.y - 11)
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
                            canvas.ribbon(ctx, L.x0, L.y0a, L.y0b, L.x1, L.y1a, L.y1b,
                                          canvas.withAlpha(L.color, 0.42))
                        }
                        for (i = 0; i < g.nodes.length; i++)
                            canvas.drawNode(ctx, g.nodes[i], g.maxLayer)
                    }
                }
            }

            FlowChartMultiLayerDescription {}
        }
    }
}
