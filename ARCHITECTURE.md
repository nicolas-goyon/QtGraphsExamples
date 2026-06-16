# Architecture

## Directory layout

```
QtGraphsExamples/
├── CMakeLists.txt                  # Root: finds Qt6, includes helpers, adds app/
├── cmake/
│   └── QtGraphsHelpers.cmake       # add_qt_graphs_example() helper
├── shared/
│   ├── CMakeLists.txt              # INTERFACE library: QtGraphsShared
│   └── DemoWindow.h                # Base QMainWindow (title + size)
├── app/
│   ├── CMakeLists.txt              # Single executable: QtGraphsExamples
│   ├── main.cpp
│   ├── MainWindow.h/.cpp           # Top-level window; hosts 2 page tabs
│   ├── common/
│   │   └── ExampleTab.h/.cpp       # Base tab: vertical list + graph + description
│   ├── pages/
│   │   ├── Page2D.h/.cpp           # "2D Charts" page → Line/Bar/Scatter tabs
│   │   └── Page3D.h/.cpp           # "3D Graphs" page → Bars3D/Scatter3D/Surface3D tabs
│   └── tabs/
│       ├── 2d/
│       │   ├── LineChartTab.h/.cpp
│       │   ├── BarChartTab.h/.cpp
│       │   └── ScatterChartTab.h/.cpp
│       └── 3d/
│           ├── Bars3DTab.h/.cpp
│           ├── Scatter3DTab.h/.cpp
│           └── Surface3DTab.h/.cpp
├── examples/
│   ├── 2D/
│   │   ├── Line/
│   │   │   └── BasicLine/
│   │   │       ├── BasicLineExample.h/.cpp   # Graph widget
│   │   │       ├── BasicLineData.h            # Mock data
│   │   │       └── BasicLineDescription.h     # Description text + file list
│   │   ├── Bar/
│   │   │   └── BasicBar/
│   │   │       ├── BasicBarExample.h/.cpp
│   │   │       ├── BasicBarData.h
│   │   │       └── BasicBarDescription.h
│   │   └── Scatter/
│   │       └── BasicScatter/
│   │           ├── BasicScatterExample.h/.cpp
│   │           ├── BasicScatterData.h
│   │           └── BasicScatterDescription.h
│   └── 3D/
│       ├── Bars/
│       │   └── BasicBars3D/
│       │       ├── BasicBars3DExample.h/.cpp
│       │       ├── BasicBars3DData.h
│       │       └── BasicBars3DDescription.h
│       ├── Scatter/
│       │   └── BasicScatter3D/
│       │       ├── BasicScatter3DExample.h/.cpp
│       │       ├── BasicScatter3DData.h
│       │       └── BasicScatter3DDescription.h
│       └── Surface/
│           └── BasicSurface3D/
│               ├── BasicSurface3DExample.h/.cpp
│               ├── BasicSurface3DData.h
│               └── BasicSurface3DDescription.h
├── README.md
├── ARCHITECTURE.md
├── LICENSE
└── .gitignore
```

## UI hierarchy

```
MainWindow (DemoWindow)
└── QTabWidget  ← top-level pages
    ├── Page2D (QWidget)
    │   └── QTabWidget  ← chart-type tabs
    │       ├── LineChartTab    (ExampleTab)
    │       ├── BarChartTab     (ExampleTab)
    │       └── ScatterChartTab (ExampleTab)
    └── Page3D (QWidget)
        └── QTabWidget  ← graph-type tabs
            ├── Bars3DTab     (ExampleTab)
            ├── Scatter3DTab  (ExampleTab)
            └── Surface3DTab  (ExampleTab)
```

Each `ExampleTab` shows a vertical list on the left; selecting an entry loads the
graph widget and description on the right.

## ExampleTab layout

```
+-----------+-------------------------------+
|           |  Graph widget                 |
|  QList    +-------------------------------+
|  Widget   |  QTextBrowser                 |
|  (left)   |  Description + source files   |
+-----------+-------------------------------+
```

`void ExampleTab::addExample(const ExampleEntry &)` — registers one example entry.
The first entry added is selected automatically.

```cpp
struct ExampleEntry {
    QString                            name;
    std::function<QWidget*(QWidget*)>  createWidget;
    QString                            description;
    QStringList                        files;
};
```

## Example file conventions

Each example folder under `examples/` is **self-contained** — no cross-example
dependencies. Files follow a fixed pattern:

| File | Purpose |
|------|---------|
| `<Name>Example.h/.cpp` | QWidget subclass: creates `QQuickWidget`, sets context properties, loads the QML file |
| `<Name>Data.h` | Inline mock data (no external sources) |
| `<Name>.qml` | Graph configuration in QML — axes, theme, series structure, data binding |
| `<Name>Description.h` | Inline `text()` and `files()` functions |

The split keeps graph *configuration* (visual, axes, QML types) in the `.qml` file and
*data* in C++, injected into QML via `QQmlContext::setContextProperty()`.

This lets users copy a single folder into their own project without bringing
anything else along.

## Include conventions

Two include roots are configured in `app/CMakeLists.txt`:

- `app/` — for internal app headers:
  ```cpp
  #include "common/ExampleTab.h"
  #include "tabs/2d/LineChartTab.h"
  #include "pages/Page2D.h"
  ```
- Project root — for example headers:
  ```cpp
  #include "examples/2D/Line/BasicLine/BasicLineExample.h"
  #include "examples/2D/Line/BasicLine/BasicLineDescription.h"
  ```

Headers from `shared/` are available via the `QtGraphsShared` interface target:

```cpp
#include "DemoWindow.h"
```

## Adding a new example

1. Create `examples/<2D|3D>/<ChartType>/<ExampleName>/` with the files above.
2. Write `<Name>.qml` — import `QtGraphs`, declare the graph, axes, and series. Use context property names for data bindings.
3. Write `<Name>Example.cpp` — set context properties from `<Name>Data.h`, then call `quickWidget->setSource(QUrl("qrc:/qml/examples/.../<Name>.qml"))`.
4. In the matching tab class (`app/tabs/.../`), call `addExample({...})`.
5. Add the `.h`/`.cpp` files to `SOURCES` and the `.qml` file to `qt_add_resources` in `app/CMakeLists.txt`.

## Adding a new chart type tab

1. Create `app/tabs/<2d|3d>/MyTab.h` and `MyTab.cpp`, inheriting `ExampleTab`.
2. Add both files to `app/CMakeLists.txt` under `SOURCES`.
3. `#include` and `addTab(new MyTab(this), "My Tab")` in the relevant Page class.
4. Create at least one example folder under `examples/`.

## C++ conventions

- C++17, `auto *` for Qt object construction
- `Q_OBJECT` only when the class defines signals, slots, or `Q_PROPERTY`
- Forward-declare Qt types in headers; include full headers in `.cpp`
- No `using namespace` in headers

## Qt Graphs API quick reference

> **Qt Graphs 6.11:** `QGraphsView`, `Q3DBars`, `Q3DScatter`, and `Q3DSurface` are
> **not C++ classes**. All graph types live in QML; C++ hosts them via `QQuickWidget`.

### Pattern: QML graph in a QWidget application

**C++ side** (same for 2D and 3D):

```cpp
auto *quickWidget = new QQuickWidget(this);
quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);

// Inject data from *Data.h into QML
auto *ctx = quickWidget->rootContext();
ctx->setContextProperty("myPoints", QVariant::fromValue(data.points));

// Load the QML file (compiled into the binary via qt_add_resources)
quickWidget->setSource(QUrl("qrc:/qml/examples/.../MyGraph.qml"));
layout->addWidget(quickWidget);
```

CMake dependency: `Qt6::QuickWidgets`

**QML side** (2D example):

```qml
import QtGraphs

GraphsView {
    anchors.fill: parent
    axisX: ValueAxis { min: 0; max: 10; title: "X" }
    axisY: ValueAxis { min: 0; max: 10; title: "Y" }

    LineSeries {
        name: "My Data"
        Component.onCompleted: {
            for (let pt of myPoints)  // context property
                append(pt.x, pt.y)
        }
    }
}
```

**QML side** (3D example):

```qml
import QtGraphs

Bars3D {                            // or Scatter3D / Surface3D
    anchors.fill: parent
    Bar3DSeries {
        ItemModelBarDataProxy {
            itemModel: ListModel { id: m }
            rowRole: "rowLabel"; columnRole: "colLabel"; valueRole: "val"
        }
        Component.onCompleted: {
            for (let item of barData3D) m.append(item)  // context property
        }
    }
}
```

### QML type reference

| Need | 2D QML type | 3D QML type |
|------|-------------|-------------|
| Graph view | `GraphsView` | `Bars3D` / `Scatter3D` / `Surface3D` |
| Line series | `LineSeries` | — |
| Bar series | `BarSeries` + `BarSet` | `Bar3DSeries` |
| Scatter series | `ScatterSeries` | `Scatter3DSeries` |
| Surface series | — | `Surface3DSeries` |
| Numeric axis | `ValueAxis` | `ValueAxis3D` |
| Category axis | `BarCategoryAxis` | `CategoryAxis3D` |
| 3D data proxy | — | `ItemModelBarDataProxy` / `ItemModelScatterDataProxy` / `ItemModelSurfaceDataProxy` |
| Theme | `GraphsTheme { }` | `GraphsTheme { }` |
| QML import | `import QtGraphs` | `import QtGraphs` |
