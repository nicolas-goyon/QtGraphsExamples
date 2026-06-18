# Architecture

This document explains how the project is structured and how to add new examples.

---

## Overview

The app is a single Qt Quick window (`Main.qml`) with a tab bar at the top (2D Charts / 3D Charts). Each tab renders a `ChartPage`, which provides a collapsible sidebar navigator on the left and a `StackLayout` of chart examples on the right.

Each example is fully self-contained in its own subfolder. Nothing is shared between examples by design — this makes each one easy to read and copy-paste in isolation.

---

## File structure

```
qml/
├── Main.qml              # App shell — declares ChartPage instances and wires up navItems
├── ChartPage.qml         # Reusable sidebar + StackLayout, accepts navItems and chart children
├── 2d/
│   ├── linechart/        # basic, table, target, range, stacked, legend, live, editor
│   ├── splinechart/      # basic, legend, live
│   ├── areachart/        # basic, stacked, pointlabels, stackedlabels, live
│   ├── barchart/         # basic, stacked, labels, targetline, stackedpercent, horizontal, mixedline, legend
│   ├── scatterchart/     # basic, trendline, custommarkers, hover, trendlines, averages, legend, live
│   ├── populationpyramid/# basic
│   ├── heatmap/          # basic
│   └── piechart/         # basic, donut
└── 3d/
    ├── bars3d/           # basic, legend
    └── surface3d/        # basic, legend
```

Each variant subfolder follows this layout:

```
<variant>/
├── <Name>Example.qml         # The chart
├── <Name>Description.qml     # Description block shown below the chart
├── <Name>DataProvider.h      # C++ data provider (if needed)
└── <Name>DataProvider.cpp
```

Naming convention: `BarChartStackedExample.qml`, `BarChartStackedDescription.qml`, `BarChartStackedDataProvider.h/.cpp`. The QML type name must match the filename exactly.

---

## How ChartPage works

`ChartPage.qml` takes two things:

- `navItems` — an array of `{ label: string, variants: [string] }` objects, one per chart group.
- Its children (via `default property alias charts: chartStack.children`) — the actual example components, in the same order as the variants listed in `navItems`.

The sidebar maps each variant label to a flat index into the children stack. The order of children in `Main.qml` must exactly match the order of variants in `navItems` — flat, top to bottom, group by group.

Groups start collapsed by default. Clicking a group header expands or collapses it.

---

## Adding a new example variant

### 1. Create the subfolder

```
qml/2d/<charttype>/<variant>/
```

### 2. Create the QML files

**`<Name>Example.qml`** — wrap everything in a `ScrollView` with this pattern:

```qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtGraphs
import QtGraphsExamples   // only needed if you have a C++ data provider

Item {
    <Name>DataProvider { id: dataProvider }   // omit if pure QML

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
                text: "Chart Title"
                font { pixelSize: 16; bold: true }
                color: "#cdd6f4"
            }

            GraphsView {
                Layout.fillWidth: true
                implicitHeight: 340          // never use Layout.fillHeight: true here
                theme: GraphsTheme { colorScheme: GraphsTheme.ColorScheme.Dark }
                // ...
            }

            <Name>Description {}
        }
    }
}
```

> **Important:** always use `implicitHeight: 340` on `GraphsView`, never `Layout.fillHeight: true`. Fill-height children have zero implicit height, which breaks the `ScrollView`'s `contentHeight` calculation.

**`<Name>Description.qml`** — boilerplate description block:

```qml
import QtQuick
import QtQuick.Layouts

Rectangle {
    Layout.fillWidth: true
    implicitHeight: inner.implicitHeight + 24
    color: "#181825"; radius: 8
    border.color: "#313244"; border.width: 1

    ColumnLayout {
        id: inner
        anchors { fill: parent; margins: 12 }
        spacing: 8

        Text { text: "About this example"; color: "#89b4fa"; font { pixelSize: 13; bold: true } }

        TextEdit {
            Layout.fillWidth: true
            readOnly: true; selectByMouse: true
            selectionColor: "#89b4fa"; selectedTextColor: "#1e1e2e"
            wrapMode: TextEdit.WordWrap
            text: "Explanation of what this example demonstrates and which Qt Graphs APIs it uses."
            color: "#cdd6f4"; font.pixelSize: 12
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#313244" }
        Text { text: "SOURCE FILES"; color: "#6c7086"; font { pixelSize: 10; bold: true; letterSpacing: 1 } }

        Column {
            Layout.fillWidth: true; spacing: 3
            Repeater {
                model: [
                    "qml/2d/<charttype>/<variant>/<Name>Example.qml",
                    "qml/2d/<charttype>/<variant>/<Name>DataProvider.h",
                    "qml/2d/<charttype>/<variant>/<Name>DataProvider.cpp"
                ]
                TextEdit {
                    width: parent.width; readOnly: true; selectByMouse: true
                    selectionColor: "#89b4fa"; selectedTextColor: "#1e1e2e"
                    text: "▸  " + modelData; color: "#a6e3a1"
                    font { pixelSize: 11; family: "Consolas" }
                }
            }
        }
    }
}
```

### 3. Create the C++ data provider (if needed)

Pure-QML examples (like live charts) don't need one. If the example loads static data, create a provider:

**`<Name>DataProvider.h`**

```cpp
#pragma once
#include <QObject>
#include <QList>
#include <QString>
#include <QtQml/qqml.h>

class <Name>DataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit <Name>DataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QList<double> values() const;
    // add more Q_INVOKABLE methods as needed
};
```

**`<Name>DataProvider.cpp`**

```cpp
#include "<Name>DataProvider.h"

<Name>DataProvider::<Name>DataProvider(QObject *parent) : QObject(parent) {}

QList<double> <Name>DataProvider::values() const {
    return { /* your data */ };
}
```

### 4. Register in CMakeLists.txt

Add the `.h` and `.cpp` to the `SOURCES` block:

```cmake
qml/2d/<charttype>/<variant>/<Name>DataProvider.h
qml/2d/<charttype>/<variant>/<Name>DataProvider.cpp
```

Add both QML files to the `QML_FILES` block:

```cmake
qml/2d/<charttype>/<variant>/<Name>Example.qml
qml/2d/<charttype>/<variant>/<Name>Description.qml
```

Add the subfolder to `target_include_directories` (required for the auto-generated type registration to find the header):

```cmake
target_include_directories(QtGraphsExamples PRIVATE
    # ... existing entries ...
    qml/2d/<charttype>/<variant>
)
```

> If the example is pure QML with no data provider, skip the SOURCES and include_directories steps.

### 5. Wire it into Main.qml

Add the variant name to the correct `navItems` entry:

```qml
{ label: "Bar Chart", variants: ["Basic Example", "Stacked", "With Labels", "With Target Line", "New Variant"] }
```

Then add the component as a child of `ChartPage`, in the same position (flat order, matching `navItems`):

```qml
BarChartBasicExample        {}
BarChartStackedExample      {}
BarChartLabelsExample       {}
BarChartTargetLineExample   {}
BarChartNewVariantExample   {}   // ← new
```

---

## Adding a new chart type

Same steps as above, but also:

1. Create a new `{ label: "...", variants: [...] }` entry in the `navItems` array inside `Main.qml`.
2. Add all its example components as children of `ChartPage`, after all existing chart type examples, maintaining flat order.

---

## Key Qt Graphs patterns used in this project

**AreaSeries with stacking** — boundary `LineSeries` must be declared *outside* `GraphsView` as siblings, not inside it. If placed inside, they render as visible lines.

```qml
LineSeries { id: boundary; /* data */ }   // outside GraphsView

GraphsView {
    AreaSeries { upperSeries: boundary }  // references by id
}
```

**Custom point delegates** — use `XYSeries.pointDelegate: Component`. Injected properties available inside: `pointColor`, `pointValueX`, `pointValueY`, `pointSelected`, `pointBorderColor`, `pointBorderWidth`.

**Hover synchronization across series** — use a shared `property int hoveredX` on the parent item, set it from `HoverHandler` inside each `pointDelegate`, and add a short debounce `Timer` (30–40 ms) to clear it. This prevents flicker when the mouse moves between delegates at the same X column.

**Live charts** — `Timer { interval: 1000; running: true; repeat: true }` calls `series.append(tick, value)` and `series.remove(0)` to maintain a sliding window. Update `axisX.min` and `axisX.max` each tick.

**Bar chart stacking** — set `barsType: BarSeries.BarsType.Stacked` on `BarSeries`. Other modes: `BarsType.Groups` (default, side-by-side), `BarsType.StackedPercent` (100% normalized).

**Bar chart target line axis alignment** — `BarCategoryAxis` maps categories to integer positions 0..n-1. A `LineSeries` overlay spanning the full width must go from `-0.5` to `n - 0.5`.

**`qt_policy(SET QTP0004 NEW)`** — enables auto-generation of `qmldir` for all QML files in subdirectories. Without this, QML types in subfolders are not discoverable.

**SplineSeries** — drop-in replacement for `LineSeries` that draws smooth Catmull-Rom curves through the data points. Use exactly like `LineSeries`; `pointDelegate` works the same way.

**PieSeries / PieSlice** — declared directly inside `GraphsView`. Each `PieSlice` carries `label`, `value`, and `color`. Set `labelVisible: true` on individual slices to show labels. Control overall size with `pieSize` (0.0–1.0) on `PieSeries`.

```qml
GraphsView {
    PieSeries {
        pieSize: 0.8
        PieSlice { label: "A"; value: 40; color: "#89b4fa"; labelVisible: true }
        PieSlice { label: "B"; value: 60; color: "#a6e3a1"; labelVisible: true }
    }
}
```

**Custom heatmap (pure QML)** — Qt Graphs has no built-in heatmap series type. The heatmap example is implemented entirely in QML: a `Repeater` of `Row`s, each containing a `Repeater` of `Rectangle`s. Cell color is computed from the value via a JavaScript helper function. `HoverHandler` + `ToolTip` attached properties provide per-cell tooltips. No `GraphsView` or data provider is needed.
