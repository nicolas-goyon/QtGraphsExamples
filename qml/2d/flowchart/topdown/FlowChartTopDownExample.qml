import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Top-down (vertical) Sankey / flow diagram — pure-QML Canvas implementation.
// Same data-driven layered model as the multi-layer variant, but the layers
// run top to bottom instead of left to right: node bars are horizontal
// rectangles (width ∝ value) and flows are downward cubic-bezier ribbons.
// The example is a web conversion funnel — traffic sources at the top funnel
// into a Browse step, which splits into Add-to-Cart vs Bounce, and so on, with
// visitors leaving the funnel (sink nodes) at each stage.
//
// Qt Graphs has no flow / Sankey series; everything is drawn with the
// Qt Quick 2D Canvas API.
Item {
    id: page

    readonly property var nodes: [
        // Layer 0 — traffic sources
        { id: "organic",   name: "Organic",     layer: 0, color: "#a6e3a1" },
        { id: "paid",      name: "Paid Ads",    layer: 0, color: "#f9e2af" },
        { id: "social",    name: "Social",      layer: 0, color: "#89b4fa" },
        { id: "email",     name: "Email",       layer: 0, color: "#cba6f7" },
        // Layer 1 — landing
        { id: "browse",    name: "Browse",      layer: 1, color: "#94e2d5" },
        // Layer 2 — engaged vs lost
        { id: "addcart",   name: "Add to Cart", layer: 2, color: "#89dceb" },
        { id: "bounce",    name: "Bounce",      layer: 2, color: "#6c7086" },
        // Layer 3 — outcomes
        { id: "purchase",  name: "Purchase",    layer: 3, color: "#a6e3a1" },
        { id: "abandoned", name: "Abandoned",   layer: 3, color: "#f38ba8" }
    ]
    readonly property var links: [
        { source: "organic", target: "browse",    value: 400 },
        { source: "paid",    target: "browse",    value: 300 },
        { source: "social",  target: "browse",    value: 200 },
        { source: "email",   target: "browse",    value: 100 },
        { source: "browse",  target: "addcart",   value: 350 },
        { source: "browse",  target: "bounce",    value: 650 },
        { source: "addcart", target: "purchase",  value: 180 },
        { source: "addcart", target: "abandoned", value: 170 }
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
                text: "Top-Down Flow — Web Conversion Funnel"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 560
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

                    // Vertical ribbon: from a source bottom edge (y0, x0a..x0b)
                    // down to a target top edge (y1, x1a..x1b).
                    function ribbonV(ctx, y0, x0a, x0b, y1, x1a, x1b, fill) {
                        var yc = (y0 + y1) / 2
                        ctx.beginPath()
                        ctx.moveTo(x0a, y0)
                        ctx.bezierCurveTo(x0a, yc, x1a, yc, x1a, y1)   // left edge
                        ctx.lineTo(x1b, y1)
                        ctx.bezierCurveTo(x1b, yc, x0b, yc, x0b, y0)   // right edge (back)
                        ctx.closePath()
                        ctx.fillStyle = fill
                        ctx.fill()
                    }

                    // Layered layout, vertical orientation.
                    function computeLayout(W, H) {
                        var ns = page.nodes, ls = page.links
                        var byId = {}, maxLayer = 0
                        for (var i = 0; i < ns.length; i++) {
                            byId[ns[i].id] = { def: ns[i], inV: 0, outV: 0, x: 0, y: 0, w: 0 }
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

                        var topPad = 34, botPad = 34, sidePad = 24, nodeT = 16, gap = 26
                        var plotW = W - 2 * sidePad

                        var scale = Infinity
                        for (i = 0; i < layers.length; i++) {
                            var sv = 0
                            for (var j = 0; j < layers[i].length; j++) sv += byId[layers[i][j]].val
                            if (sv > 0) {
                                var s = (plotW - (layers[i].length - 1) * gap) / sv
                                if (s < scale) scale = s
                            }
                        }
                        var rowStep = (maxLayer > 0)
                                ? (H - topPad - botPad - nodeT) / maxLayer : 0

                        for (i = 0; i < layers.length; i++) {
                            var col = layers[i]
                            var sv2 = 0
                            for (j = 0; j < col.length; j++) sv2 += byId[col[j]].val
                            var rowW = sv2 * scale + (col.length - 1) * gap
                            var x = sidePad + (plotW - rowW) / 2
                            var y = topPad + i * rowStep
                            for (j = 0; j < col.length; j++) {
                                var nd = byId[col[j]]
                                nd.y = y; nd.w = nd.val * scale; nd.x = x
                                x += nd.w + gap
                            }
                        }

                        // Stack links along node edges, ordered by the opposite
                        // endpoint's centre x to reduce crossings.
                        function cx(id) { return byId[id].x + byId[id].w / 2 }
                        var outMap = {}, inMap = {}
                        for (i = 0; i < ns.length; i++) { outMap[ns[i].id] = []; inMap[ns[i].id] = [] }
                        for (i = 0; i < ls.length; i++) { outMap[ls[i].source].push(i); inMap[ls[i].target].push(i) }
                        for (key in outMap)
                            outMap[key].sort(function (a, b) { return cx(ls[a].target) - cx(ls[b].target) })
                        for (key in inMap)
                            inMap[key].sort(function (a, b) { return cx(ls[a].source) - cx(ls[b].source) })

                        var srcLeft = {}, tgtLeft = {}
                        for (key in outMap) {
                            var acc = byId[key].x
                            for (i = 0; i < outMap[key].length; i++) {
                                srcLeft[outMap[key][i]] = acc
                                acc += ls[outMap[key][i]].value * scale
                            }
                        }
                        for (key in inMap) {
                            var acc2 = byId[key].x
                            for (i = 0; i < inMap[key].length; i++) {
                                tgtLeft[inMap[key][i]] = acc2
                                acc2 += ls[inMap[key][i]].value * scale
                            }
                        }

                        var linkGeom = []
                        for (i = 0; i < ls.length; i++) {
                            var L = ls[i], sN = byId[L.source], tN = byId[L.target]
                            var ww = L.value * scale
                            linkGeom.push({
                                y0: sN.y + nodeT, x0a: srcLeft[i], x0b: srcLeft[i] + ww,
                                y1: tN.y,         x1a: tgtLeft[i], x1b: tgtLeft[i] + ww,
                                value: L.value, color: sN.def.color
                            })
                        }
                        var nodeGeom = []
                        for (i = 0; i < ns.length; i++) {
                            var nd2 = byId[ns[i].id]
                            nodeGeom.push({
                                def: ns[i], x: nd2.x, y: nd2.y, w: nd2.w, t: nodeT,
                                val: nd2.val, layer: ns[i].layer
                            })
                        }
                        return { nodes: nodeGeom, links: linkGeom, nodeT: nodeT, maxLayer: maxLayer }
                    }

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()
                        ctx.clearRect(0, 0, width, height)
                        var g = computeLayout(width, height)
                        ctx.font = "12px sans-serif"
                        ctx.textBaseline = "middle"
                        ctx.textAlign = "center"

                        for (var i = 0; i < g.links.length; i++) {
                            var L = g.links[i]
                            canvas.ribbonV(ctx, L.y0, L.x0a, L.x0b, L.y1, L.x1a, L.x1b,
                                           canvas.withAlpha(L.color, 0.42))
                        }
                        for (i = 0; i < g.nodes.length; i++) {
                            var N = g.nodes[i]
                            ctx.fillStyle = N.def.color
                            ctx.fillRect(N.x, N.y, N.w, N.t)
                            var lx = N.x + N.w / 2
                            // Top layer labels above; bottom layer below; middle above.
                            var ly = (N.layer === g.maxLayer) ? N.y + N.t + 10 : N.y - 10
                            ctx.fillStyle = "#cdd6f4"
                            ctx.fillText(N.def.name + "  ·  " + N.val, lx, ly)
                        }
                    }
                }
            }

            FlowChartTopDownDescription {}
        }
    }
}
