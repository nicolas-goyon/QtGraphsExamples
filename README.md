# QtGraphsExamples

A single application showcasing **Qt Graphs** (Qt ≥ 6.11) across both 2D charting and 3D data-visualisation APIs. Each chart type has its own tab with a vertical list of self-contained examples — click an example to see the live graph alongside its description and source file paths.

## Prerequisites

| Tool | Minimum version |
|------|----------------|
| Qt   | 6.11 — install **Graphs** and **Quick** components via Qt Maintenance Tool |
| CMake | 3.21 |
| C++ compiler | C++17 (MSVC 2019, GCC 11, Clang 13) |

Required Qt modules: `Qt6::Graphs`, `Qt6::QuickWidgets`.

All graph types (`GraphsView`, `Bars3D`, `Scatter3D`, `Surface3D`) are QML-only.
C++ hosts them via `QQuickWidget` + `setSource(QUrl("qrc:/qml/..."))`.

> **License note:** `QtGraphs` is GPLv3 for open-source use; a commercial Qt license is required for closed-source products.

## Build

```bash
git clone https://github.com/your-org/QtGraphsExamples.git
cd QtGraphsExamples

cmake -S . -B build -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x.x/<kit>
cmake --build build --parallel
```

The single executable is produced at `build/QtGraphsExamples[.exe]`.

## UI layout

```
MainWindow
├── [Tab] 2D Charts
│   ├── [Tab] Line Chart
│   │   └── [List] Basic Line  →  graph + description + source files
│   ├── [Tab] Bar Chart
│   │   └── [List] Basic Bar
│   └── [Tab] Scatter Chart
│       └── [List] Basic Scatter
└── [Tab] 3D Graphs
    ├── [Tab] Bars 3D
    │   └── [List] Basic Bars 3D
    ├── [Tab] Scatter 3D
    │   └── [List] Basic Scatter 3D
    └── [Tab] Surface 3D
        └── [List] Basic Surface 3D
```

Each example panel layout:

```
+-----------+-------------------------------+
|           |  Live graph widget            |
|  Example  +-------------------------------+
|  list     |  Description text             |
|           |  Source files:                |
|           |    • examples/.../Foo.cpp     |
+-----------+-------------------------------+
```

## Adding a new example

1. Create a folder under `examples/<2D|3D>/<ChartType>/<ExampleName>/`.
2. Add these files (all self-contained — no cross-example dependencies):
   - `<Name>Example.h/.cpp` — the graph widget
   - `<Name>Data.h` — mock data
   - `<Name>Description.h` — description text and file list
3. Register the example in the relevant tab class (`app/tabs/.../`):
   ```cpp
   addExample({
       "My Example",
       [](QWidget *p) { return new MyExample(p); },
       MyDescription::text(),
       MyDescription::files()
   });
   ```
4. Add the new `.h`/`.cpp` files to `app/CMakeLists.txt` under `SOURCES`.

See `ARCHITECTURE.md` for full conventions.

## License

MIT — see `LICENSE`.
