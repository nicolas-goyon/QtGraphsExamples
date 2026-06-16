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
| Live | Timer-driven sliding window updating every second |

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

**Scatter Chart**

| Variant | What it shows |
|---|---|
| Basic Example | Multi-series scatter plot |
| With Trend Line | Linear regression line computed from data and drawn as a LineSeries |
| Custom Markers | Per-series custom shapes via `pointDelegate` (circle, diamond, cross) |
| With Hover | Tooltip on hover using HoverHandler inside pointDelegate |
| Live | Timer-driven scatter plot updating every second |

### 3D Charts

| Variant | What it shows |
|---|---|
| 3D Bars — Basic | Regional sales per quarter using `Bars3D` and `ItemModelBarDataProxy` |
| 3D Surface — Basic | Mathematical surface sin(x)·cos(z) using `Surface3D` and `ItemModelSurfaceDataProxy` |

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
│   └── 2d/
│       ├── linechart/
│       ├── areachart/
│       ├── barchart/
│       └── scatterchart/
│   └── 3d/
│       ├── bars3d/
│       └── surface3d/
```

Each chart variant lives in its own subfolder and contains:
- `*Example.qml` — the chart itself
- `*Description.qml` — description and source file list shown below the chart
- `*DataProvider.h/.cpp` — C++ QML_ELEMENT exposing data to QML (omitted for pure-QML examples like live charts)

See `ARCHITECTURE.md` for instructions on adding new examples.
