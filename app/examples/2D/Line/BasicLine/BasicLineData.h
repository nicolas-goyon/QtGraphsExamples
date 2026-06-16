#pragma once

#include <QList>
#include <QPointF>
#include <QString>

// ---------------------------------------------------------------------------
// BasicLineData
// Mock monthly temperature readings for two cities.
// Self-contained — no external dependencies.
// ---------------------------------------------------------------------------
namespace BasicLineData {

struct Series {
    QString       name;
    QList<QPointF> points; // x = month (1-12), y = °C
};

inline QList<Series> series()
{
    return {
        {
            "Helsinki",
            {
                {1, -4.7}, {2, -5.4}, {3, -1.0}, {4,  4.7},
                {5, 11.4}, {6, 16.0}, {7, 18.5}, {8, 17.3},
                {9, 12.2}, {10, 6.4}, {11, 1.0}, {12, -2.5}
            }
        },
        {
            "Madrid",
            {
                {1,  5.8}, {2,  7.4}, {3, 10.7}, {4, 13.4},
                {5, 17.5}, {6, 22.5}, {7, 25.8}, {8, 25.4},
                {9, 20.8}, {10,14.9}, {11, 9.4}, {12, 6.0}
            }
        }
    };
}

inline QStringList categoryLabels()
{
    return {"Jan","Feb","Mar","Apr","May","Jun",
            "Jul","Aug","Sep","Oct","Nov","Dec"};
}

} // namespace BasicLineData
