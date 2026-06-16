# Qt Graphs Examples

A C++/QML project showcasing the **Qt Graphs** module (Qt ≥ 6.6).

## Examples included

| Tab | Description |
|-----|-------------|
| Line Chart | Monthly temperature data for 3 cities (2D `LineSeries`) |
| Bar Chart | Quarterly revenue by product (2D `BarSeries` + `BarSet`) |
| Scatter Chart | Height vs weight by group (2D `ScatterSeries`) |
| 3D Bars | Regional sales per quarter (`Bars3D` + `ItemModelBarDataProxy`) |
| 3D Surface | sin(x)·cos(z) mathematical surface (`Surface3D` + `ItemModelSurfaceDataProxy`) |

## Requirements

- Qt 6.6 or newer (Qt Graphs module)
- CMake 3.16+
- C++17 compiler

## Build

```bash
cmake -B build -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x.x/<platform>
cmake --build build
./build/QtGraphsExamples
```

Or open `CMakeLists.txt` directly in Qt Creator.
