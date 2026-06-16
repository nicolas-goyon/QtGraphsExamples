#pragma once

#include <QList>
#include <QString>

// ---------------------------------------------------------------------------
// BasicBarData
// Mock quarterly revenue data (in millions) for three products.
// Self-contained — no external dependencies.
// ---------------------------------------------------------------------------
namespace BasicBarData {

struct BarSet {
    QString     name;
    QList<qreal> values; // one value per category
};

inline QStringList categories()
{
    return {"Q1", "Q2", "Q3", "Q4"};
}

inline QList<BarSet> sets()
{
    return {
        { "Widgets",  { 4.2,  5.8,  6.1,  7.4 } },
        { "Gadgets",  { 3.1,  4.4,  5.9,  6.8 } },
        { "Doohickeys",{ 1.5, 2.0,  2.8,  3.3 } },
    };
}

} // namespace BasicBarData
