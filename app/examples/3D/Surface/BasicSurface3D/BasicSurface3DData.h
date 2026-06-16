#pragma once

#include <QList>
#include <QSurfaceDataProxy>   // defines QSurfaceDataItem, QSurfaceDataRow, QSurfaceDataArray
#include <cmath>

// ---------------------------------------------------------------------------
// BasicSurface3DData
// Generates a simple sinc (sin(r)/r) surface on a 20×20 grid.
// Self-contained — no external dependencies.
// ---------------------------------------------------------------------------
namespace BasicSurface3DData {

constexpr int   kRows    = 20;
constexpr int   kColumns = 20;
constexpr float kXMin    = -5.0f;
constexpr float kXMax    =  5.0f;
constexpr float kZMin    = -5.0f;
constexpr float kZMax    =  5.0f;

// Qt Graphs 6.11: QSurfaceDataRow = QList<QSurfaceDataItem> (value type).
// Do NOT allocate rows with `new` — use stack values and append by value.
inline QSurfaceDataArray buildArray()
{
    QSurfaceDataArray array;
    array.reserve(kRows);

    for (int row = 0; row < kRows; ++row) {
        QSurfaceDataRow dataRow(kColumns);   // value, not pointer
        float z = kZMin + row * (kZMax - kZMin) / (kRows - 1);

        for (int col = 0; col < kColumns; ++col) {
            float x = kXMin + col * (kXMax - kXMin) / (kColumns - 1);
            float r = std::sqrt(x * x + z * z);
            float y = (r < 1e-4f) ? 1.0f : std::sin(r) / r;
            dataRow[col].setPosition({x, y, z});   // no `*` dereference
        }
        array.append(dataRow);
    }
    return array;
}

} // namespace BasicSurface3DData
