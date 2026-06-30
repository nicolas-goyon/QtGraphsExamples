<div align="center">

# Qt Graphs Examples

An interactive gallery showcasing every chart type available in the **Qt Graphs** module —  
built with Qt Quick, QML, and C++17. Each example is self-contained and meant to be  
read, understood, and used as a starting point.

[![Qt](https://img.shields.io/badge/Qt-6.6%2B-41CD52?style=flat-square&logo=qt&logoColor=white)](https://www.qt.io/)
[![CMake](https://img.shields.io/badge/CMake-3.16%2B-064F8C?style=flat-square&logo=cmake)](https://cmake.org/)
[![C++17](https://img.shields.io/badge/C%2B%2B-17-00599C?style=flat-square&logo=c%2B%2B&logoColor=white)](https://isocpp.org/)
[![Qt Graphs](https://img.shields.io/badge/Qt%20Graphs-6.6%2B-41CD52?style=flat-square)](https://doc.qt.io/qt-6/qtgraphs-index.html)

<br/>

<img src="img_1.png" alt="Application preview — dark-themed interactive chart browser" width="900"/>

</div>

---

## Contents

- [2D Charts](#-2d-charts)
- [3D Charts](#-3d-charts)
- [Requirements](#requirements)
- [Build](#build)
- [Project Layout](#project-layout)

---

## 📊 2D Charts

### Line Chart

| Variant | What it shows |
|---|---|
| Basic Example | Multi-series `LineSeries` with city temperature data |
| With Table | Chart and data table side by side |
| With Target Line | Horizontal goal line overlaid using `LineSeries` |
| With Range | Colored band between min/max bounds using `AreaSeries` |
| Stacked | Multiple area bands stacked with boundary `LineSeries` |
| Stacked + Hover | Stacked bands with synchronized hover labels across series |
| Legend Inline | Series legend rendered inside the chart area |
| Legend Below | Series legend row displayed beneath the chart |
| Live | Timer-driven sliding window updating every second |
| Live Editor | Interactive inspector to tweak series and theme properties at runtime |

### Spline Chart

| Variant | What it shows |
|---|---|
| Basic Example | Multi-series smooth-curve chart using `SplineSeries` with city temperature data |
| Legend Inline | Floating legend overlay inside the chart area |
| Legend Below | Legend row displayed beneath the chart |
| Live | Timer-driven sliding window using `SplineSeries` |

### Area Chart

| Variant | What it shows |
|---|---|
| Basic Example | Single `AreaSeries` with fill and border |
| Stacked | Multiple stacked `AreaSeries` sharing boundaries |
| With Point Labels | Custom `pointDelegate` showing value labels at each data point |
| Stacked + Side Legend | Stacked areas with a color legend row below the chart |
| Stacked + Inline Labels | Stacked areas with series labels placed inside each band |
| Live | Timer-driven area chart updating every second |

### Bar Chart

| Variant | What it shows |
|---|---|
| Basic Example | Single `BarSet` grouped by category |
| Stacked | Multiple `BarSet`s stacked via `BarsType.Stacked` |
| With Labels | Value labels on each bar using `labelsVisible` and `labelsFormat` |
| With Target Line | Horizontal target overlaid using `LineSeries` |
| Stacked 100% | Normalized bars using `BarsType.StackedPercent` |
| Horizontal | Horizontal layout via `BarSeries.BarsOrientation.Horizontal` |
| Mixed + Line | Bar series with an overlaid `LineSeries` on a shared axis |
| Legend Inline | Series legend rendered inside the chart area |
| Legend Below | Series legend row displayed beneath the chart |

### Scatter Chart

| Variant | What it shows |
|---|---|
| Basic Example | Multi-series scatter plot |
| With Trend Line | Linear regression drawn as a `LineSeries` |
| Custom Markers | Per-series custom shapes via `pointDelegate` |
| With Hover | Tooltip on hover using `HoverHandler` inside `pointDelegate` |
| Multi Trendlines | Multiple regression lines, one per series |
| Averages | Horizontal average lines overlaid on each series |
| Legend Inline | Series legend rendered inside the chart area |
| Legend Aside | Series legend column displayed beside the chart |
| Live | Timer-driven scatter plot updating every second |

### Population Pyramid

| Variant | What it shows |
|---|---|
| Basic Example | Back-to-back horizontal bars comparing two populations by age group |

### Heatmap

| Variant | What it shows |
|---|---|
| Basic Example | Pure-QML grid of colored rectangles for website traffic by hour and day, with per-cell tooltip and gradient legend |

> **Note:** Qt Graphs has no built-in heatmap series — this example is implemented entirely in QML using a `Repeater` of `Rectangle`s, with no `GraphsView` needed.

### Flow Diagram

| Variant | What it shows |
|---|---|
| CO₂ / Energy | Pure-QML Sankey flow diagram: primary-energy inputs flow into a central system node, then split into end-use outputs, with conserved totals (sum of inputs = sum of outputs) |
| Multi-Layer | Data-driven layered Sankey where nodes carry a layer index — inputs can enter mid-graph (Solar & Wind at layer 1) and outputs can leave early (Conversion Losses at layer 2) |
| With Hover | The multi-layer flow with cursor hit-testing: hovering a node or flow highlights it, dims the rest, and shows a floating tooltip with the exact value |
| Top-Down | The layered renderer rotated to a vertical orientation — a web conversion funnel flowing top to bottom, with visitors leaving as sink nodes at each stage |
| Partial Layer | A monthly cashflow where a Tax layer routes only earned income; Investments and Gift skip it via links that span two layers at once |

> **Note:** Qt Graphs has no flow / Sankey series. The diagrams are drawn with the Qt Quick 2D `Canvas` API — node bars as filled rectangles and flows as filled cubic-bezier ribbons whose thickness equals the flow value. No `GraphsView` needed.

### Pie Chart

| Variant | What it shows |
|---|---|
| Basic Example | `PieSeries` with labeled `PieSlice` items showing browser market share |
| Donut | Same data as a ring chart using `holeSize: 0.45` on `PieSeries` |

### Radar Chart

| Variant | What it shows |
|---|---|
| Basic Example | Single-series radar / spider chart showing one athlete's performance profile |
| Multi-Series | Three overlapping series (Sprinter, Powerlifter, Triathlete) compared across five metrics |
| Legend Inline | Multi-series with a floating legend overlay inside the chart area |
| Legend Below | Multi-series with a legend row displayed beneath the chart |

> **Note:** Qt Graphs has no native radar series type. The chart is implemented as a reusable `RadarChart.qml` Canvas component using the Qt Quick 2D Canvas API — no `GraphsView` required.

---

## 🧊 3D Charts

### 3D Bars

| Variant | What it shows |
|---|---|
| Basic Example | Regional sales per quarter using `Bars3D` and `ItemModelBarDataProxy` |
| Legend Inline | Same data with a series legend inside the 3D scene |
| Legend Below | Same data with a legend row below the 3D view |

### 3D Surface

| Variant | What it shows |
|---|---|
| Basic Example | Mathematical surface sin(x)·cos(z) via `Surface3D` and `ItemModelSurfaceDataProxy` |
| Legend Inline | Same surface with a color-scale legend inside the 3D scene |
| Legend Aside | Same surface with a legend column beside the 3D view |

---

## Requirements

| Dependency | Version |
|---|---|
| Qt (with Qt Graphs module) | 6.6 or newer |
| CMake | 3.16 or newer |
| C++ compiler | C++17 support required |

---

## Build

```bash
# Configure
cmake -B build -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x.x/<platform>

# Build
cmake --build build

# Run
./build/QtGraphsExamples
```

Or open `CMakeLists.txt` directly in **Qt Creator** and click **Run**.

---

## Project Layout

```
QtGraphsExamples/
├── main.cpp
├── CMakeLists.txt
├── qml/
│   ├── Main.qml              # App shell — tab bar + ChartPage instances
│   ├── ChartPage.qml         # Reusable sidebar + StackLayout host
│   ├── 2d/
│   │   ├── linechart/        # basic · table · target · range · stacked · legend · live · editor
│   │   ├── splinechart/      # basic · legend · live
│   │   ├── areachart/        # basic · stacked · pointlabels · stackedlabels · live
│   │   ├── barchart/         # basic · stacked · labels · targetline · stackedpercent · horizontal · mixedline · legend
│   │   ├── scatterchart/     # basic · trendline · custommarkers · hover · trendlines · averages · legend · live
│   │   ├── populationpyramid/# basic
│   │   ├── heatmap/          # basic
│   │   ├── flowchart/        # basic · multilayer · hover · topdown · partial (pure-QML Canvas Sankey)
│   │   ├── piechart/         # basic · donut
│   │   └── radarchart/       # RadarChart.qml (shared) · basic · multiline · legend
│   └── 3d/
│       ├── bars3d/           # basic · legend
│       └── surface3d/        # basic · legend
```

Each variant subfolder contains:

- **`*Example.qml`** — the chart itself
- **`*Description.qml`** — description and source file list shown below the chart
- **`*DataProvider.h/.cpp`** — C++ `QML_ELEMENT` exposing data to QML *(omitted for pure-QML examples)*

See [`ARCHITECTURE.md`](ARCHITECTURE.md) for the full guide on adding new examples.
