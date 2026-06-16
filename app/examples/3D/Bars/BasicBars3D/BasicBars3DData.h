#pragma once

#include <QList>
#include <QString>

// ---------------------------------------------------------------------------
// BasicBars3DData
// Mock sales volume data: rows = years (2021-2024), columns = quarters (Q1-Q4).
// Self-contained — no external dependencies.
// ---------------------------------------------------------------------------
namespace BasicBars3DData {

inline QList<QString> rowLabels()   { return {"2021", "2022", "2023", "2024"}; }
inline QList<QString> columnLabels(){ return {"Q1", "Q2", "Q3", "Q4"}; }

// Returns a flat 4×4 matrix: [row0col0, row0col1, ..., row3col3]
inline QList<QList<float>> values()
{
    return {
        { 3.2f,  4.8f,  5.1f,  6.0f },   // 2021
        { 4.5f,  6.2f,  7.0f,  7.8f },   // 2022
        { 5.8f,  7.4f,  8.3f,  9.1f },   // 2023
        { 6.3f,  8.0f,  9.5f, 10.4f },   // 2024
    };
}

} // namespace BasicBars3DData
