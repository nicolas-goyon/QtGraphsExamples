#pragma once

#include <QString>
#include <QStringList>

// ---------------------------------------------------------------------------
// BasicLineDescription
// Human-readable description and source file list for the Basic Line example.
// ---------------------------------------------------------------------------
namespace BasicLineDescription {

inline QString text()
{
    return
        "Draws two QLineSeries on a shared QGraphsView — monthly average temperatures "
        "for Helsinki and Madrid. "
        "Key points: series are appended with QPointF data, axes are configured via "
        "QValueAxis (Y) and QBarCategoryAxis (X), and the legend is enabled by default. "
        "This is the minimal setup needed to get a labelled, multi-series line chart on screen.";
}

inline QStringList files()
{
    return {
        "examples/2D/Line/BasicLine/BasicLineExample.h",
        "examples/2D/Line/BasicLine/BasicLineExample.cpp",
        "examples/2D/Line/BasicLine/BasicLineData.h",
        "examples/2D/Line/BasicLine/BasicLineDescription.h",
    };
}

} // namespace BasicLineDescription
