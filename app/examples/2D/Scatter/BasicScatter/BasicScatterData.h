#pragma once

#include <QList>
#include <QPointF>
#include <QString>

// ---------------------------------------------------------------------------
// BasicScatterData
// Mock 2D sensor readings for two measurement runs.
// Self-contained — no external dependencies.
// ---------------------------------------------------------------------------
namespace BasicScatterData {

struct Series {
    QString        name;
    QList<QPointF> points;
};

inline QList<Series> series()
{
    return {
        {
            "Run A",
            {
                {0.5, 1.2}, {1.1, 2.4}, {1.8, 1.8}, {2.6, 3.5},
                {3.2, 2.9}, {4.0, 4.8}, {4.7, 4.1}, {5.5, 5.9},
                {6.1, 5.3}, {6.9, 7.0}, {7.4, 6.6}, {8.2, 8.1}
            }
        },
        {
            "Run B",
            {
                {0.3, 0.5}, {1.0, 1.1}, {1.9, 0.8}, {2.4, 2.0},
                {3.0, 1.5}, {3.8, 3.2}, {4.5, 2.8}, {5.2, 4.4},
                {5.9, 3.9}, {6.7, 5.5}, {7.3, 5.0}, {8.0, 6.8}
            }
        }
    };
}

} // namespace BasicScatterData
