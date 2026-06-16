#pragma once

#include <QString>
#include <QStringList>

// ---------------------------------------------------------------------------
// BasicBarDescription
// Human-readable description and source file list for the Basic Bar example.
// ---------------------------------------------------------------------------
namespace BasicBarDescription {

inline QString text()
{
    return
        "Groups three QBarSet objects inside a single QBarSeries to produce a "
        "clustered bar chart of quarterly revenue per product line. "
        "Key points: each QBarSet is constructed with a name and appended with "
        "per-category values; QBarCategoryAxis drives the X axis; QValueAxis "
        "provides a labelled Y axis. The legend identifies each product automatically.";
}

inline QStringList files()
{
    return {
        "examples/2D/Bar/BasicBar/BasicBarExample.h",
        "examples/2D/Bar/BasicBar/BasicBarExample.cpp",
        "examples/2D/Bar/BasicBar/BasicBarData.h",
        "examples/2D/Bar/BasicBar/BasicBarDescription.h",
    };
}

} // namespace BasicBarDescription
