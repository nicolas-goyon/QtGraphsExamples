# Qt Graphs Examples

An interactive example browser showcasing the **Qt Graphs** module (Qt ≥ 6.6). Each example is self-contained and meant to be read, understood, and copied as a starting point.

## Examples

### 2D Charts

**Line Chart**

| Variant | What it shows |
|---|---|
| Basic Example | Simple multi-series line chart with city temperature data |
| With Table | Chart and data table side by side |
| With Target Line | Horizontal goal line overlaid on a LineSeries |
| With Range | Colored band between min/max bounds using AreaSeries |
| Stacked | Multiple area bands stacked with boundary LineSeries |
| Stacked + Hover | Same as Stacked, with synchronized hover labels across series |
| Legend Inline | Series legend rendered inside the chart area |
| Legend Below | Series legend row displayed beneath the chart |
| Live | Timer-driven sliding window updating every second |
| Live Editor | Interactive inspector to tweak series and theme properties at runtime |

**Spline Chart**

| Variant | What it shows |
|---|---|
| Basic Example | Multi-series smooth-curve chart using SplineSeries with city temperature data |
| Legend Inline | Same chart with a floating legend overlay inside the chart area |
| Legend Below | Same chart with a legend row displayed beneath the chart |
| Live | Timer-driven sliding window updating every second using SplineSeries |

**Area Chart**

| Variant | What it shows |
|---|---|
| Basic Example | Single AreaSeries with fill and border |
| Stacked | Multiple stacked AreaSeries sharing boundaries |
| With Point Labels | Custom pointDelegate showing value labels at each data point |
| Stacked + Side Legend | Stacked areas with a color legend row below the chart |
| Stacked + Inline Labels | Stacked areas with labels positioned inside each band |
| Live | Timer-driven area chart updating every second |

**Bar Chart**

| Variant | What it shows |
|---|---|
| Basic Example | Single BarSet grouped by category |
| Stacked | Multiple BarSets stacked using `barsType: BarSeries.BarsType.Stacked` |
| With Labels | Value labels on each bar using `labelsVisible` and `labelsFormat` |
| With Target Line | Horizontal target line overlaid on a BarSeries using LineSeries |
| Stacked 100% | Normalized 100% stacked bars using `BarsType.StackedPercent` |
| Horizontal | Horizontal bar chart using `BarSeries.BarsOrientation.Horizontal` |
| Mixed + Line | Bar series with an overlaid LineSeries on a shared axis |
| Legend Inline | Series legend rendered inside the chart area |
| Legend Below | Series legend row displayed beneath the chart |

**Scatter Chart**

| Variant | What it shows |
|---|---|
| Basic Example | Multi-series scatter plot |
| With Trend Line | Linear regression line computed from data and drawn as a LineSeries |
| Custom Markers | Per-series custom shapes via `pointDelegate` (circle, diamond, cross) |
| With Hover | Tooltip on hover using HoverHandler inside pointDelegate |
| Multi Trendlines | Multiple regression lines, one per series |
| Averages | Horizontal average lines overlaid on each series |
| Legend Inline | Series legend rendered inside the chart area |
| Legend Aside | Series legend column displayed beside the chart |
| Live | Timer-driven scatter plot updating every second |

**Population Pyramid**

| Variant | What it shows |
|---|---|
| Basic Example | Back-to-back horizontal bar chart comparing two populations by age group |

**Heatmap**

| Variant | What it shows |
|---|---|
| Basic Example | Pure-QML grid of colored rectangles showing website traffic by hour and day, with a tooltip on each cell and a gradient color legend |

**Pie Chart**

| Variant | What it shows |
|---|---|
| Basic Example | PieSeries with labeled PieSlice items showing browser market share data |
| Donut | Same data rendered as a ring chart using `holeSize: 0.45` on PieSeries |

### 3D Charts

**3D Bars**

| Variant | What it shows |
|---|---|
| Basic Example | Regional sales per quarter using `Bars3D` and `ItemModelBarDataProxy` |
| Legend Inline | Same data with a series legend rendered inside the 3D scene |
| Legend Below | Same data with a legend row below the 3D view |

**3D Surface**

| Variant | What it shows |
|---|---|
| Basic Example | Mathematical surface sin(x)·cos(z) using `Surface3D` and `ItemModelSurfaceDataProxy` |
| Legend Inline | Same surface with a color-scale legend inside the 3D scene |
| Legend Aside | Same surface with a legend column beside the 3D view |

## Requirements

- Qt 6.6 or newer with the Qt Graphs module
- CMake 3.16+
- C++17 compiler

## Build

```bash
cmake -B build -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x.x/<platform>
cmake --build build
./build/QtGraphsExamples
```

Or open `CMakeLists.txt` directly in Qt Creator and click Run.

## Project layout

```
QtGraphsExamples/
├── main.cpp
├── CMakeLists.txt
├── qml/
│   ├── Main.qml              # App shell (tabs + ChartPage instances)
│   ├── ChartPage.qml         # Reusable sidebar + chart stack layout
│   ├── 2d/
│   │   ├── linechart/        # basic, table, target, range, stacked, legend, live, editor
│   │   ├── splinechart/      # basic, legend, live
│   │   ├── areachart/        # basic, stacked, pointlabels, stackedlabels, live
│   │   ├── barchart/         # basic, stacked, labels, targetline, stackedpercent, horizontal, mixedline, legend
│   │   ├── scatterchart/     # basic, trendline, custommarkers, hover, trendlines, averages, legend, live
│   │   ├── populationpyramid/# basic
│   │   ├── heatmap/          # basic
│   │   └── piechart/         # basic, donut
│   └── 3d/
│       ├── bars3d/           # basic, legend
│       └── surface3d/        # basic, legend
```

Each chart variant lives in its own subfolder and contains:
- `*Example.qml` — the chart itself
- `*Description.qml` — description and source file list shown below the chart
- `*DataProvider.h/.cpp` — C++ QML_ELEMENT exposing data to QML (omitted for pure-QML examples like live charts and the heatmap)

See `ARCHITECTURE.md` for instructions on adding new examples.
