#pragma once

#include <QString>
#include <QStringList>

// ---------------------------------------------------------------------------
// BasicBars3DDescription
// Human-readable description and source file list for the Basic Bars 3D example.
// ---------------------------------------------------------------------------
namespace BasicBars3DDescription {

inline QString text()
{
    return
        "Renders a 4×4 grid of bars (years × quarters) using Q3DBars. "
        "Key points: Q3DBars is a QWindow subclass — it must be embedded in a QWidget "
        "via QWidget::createWindowContainer(). Data is loaded through QBarDataProxy "
        "using QBarDataArray (a QList of QBarDataRow pointers). "
        "Row/column labels are set on QCategory3DAxis. Camera preset and bar thickness "
        "are configured for a clear overview of the data layout.";
}

inline QStringList files()
{
    return {
        "examples/3D/Bars/BasicBars3D/BasicBars3DExample.h",
        "examples/3D/Bars/BasicBars3D/BasicBars3DExample.cpp",
        "examples/3D/Bars/BasicBars3D/BasicBars3DData.h",
        "examples/3D/Bars/BasicBars3D/BasicBars3DDescription.h",
    };
}

} // namespace BasicBars3DDescription
