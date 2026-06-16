#pragma once

#include <QList>
#include <QVector3D>
#include <QString>

// ---------------------------------------------------------------------------
// BasicScatter3DData
// Mock 3D point cloud — two clusters of measurements.
// Self-contained — no external dependencies.
// ---------------------------------------------------------------------------
namespace BasicScatter3DData {

struct Series {
    QString          name;
    QList<QVector3D> points;
};

inline QList<Series> series()
{
    return {
        {
            "Cluster A",
            {
                { 1.0f,  2.0f,  1.5f}, { 1.3f,  2.4f,  1.2f},
                { 0.8f,  1.8f,  1.9f}, { 1.5f,  2.1f,  1.0f},
                { 1.1f,  2.6f,  1.7f}, { 0.9f,  1.5f,  1.3f},
                { 1.4f,  2.3f,  0.8f}, { 1.2f,  1.9f,  2.1f},
            }
        },
        {
            "Cluster B",
            {
                { 4.0f,  5.0f,  4.5f}, { 4.3f,  5.4f,  4.2f},
                { 3.8f,  4.8f,  4.9f}, { 4.5f,  5.1f,  4.0f},
                { 4.1f,  5.6f,  4.7f}, { 3.9f,  4.5f,  4.3f},
                { 4.4f,  5.3f,  3.8f}, { 4.2f,  4.9f,  5.1f},
            }
        }
    };
}

} // namespace BasicScatter3DData
