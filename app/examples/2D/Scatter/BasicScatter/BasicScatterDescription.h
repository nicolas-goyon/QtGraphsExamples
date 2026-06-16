#pragma once

#include <QString>
#include <QStringList>

// ---------------------------------------------------------------------------
// BasicScatterDescription
// Human-readable description and source file list for the Basic Scatter example.
// ---------------------------------------------------------------------------
namespace BasicScatterDescription {

inline QString text()
{
    return
        "Plots two QScatterSeries — two sensor measurement runs — on a shared QGraphsView. "
        "Key points: point size and marker shape are set per-series; both axes use "
        "QValueAxis with explicit ranges so the scatter cloud has comfortable margins. "
        "This is the minimal setup for a labelled, multi-series scatter chart.";
}

inline QStringList files()
{
    return {
        "examples/2D/Scatter/BasicScatter/BasicScatterExample.h",
        "examples/2D/Scatter/BasicScatter/BasicScatterExample.cpp",
        "examples/2D/Scatter/BasicScatter/BasicScatterData.h",
        "examples/2D/Scatter/BasicScatter/BasicScatterDescription.h",
    };
}

} // namespace BasicScatterDescription
