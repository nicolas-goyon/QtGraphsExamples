#pragma once

#include <QString>
#include <QStringList>

namespace BasicSurface3DDescription {

inline QString text()
{
    return
        "Renders a sinc (sin(r)/r) function as a shaded 3D surface using Q3DSurface. "
        "Key points: surface data is a QSurfaceDataArray — a QList of QSurfaceDataRow "
        "pointers where each item holds a QVector3D position. "
        "QSurfaceDataProxy::resetArray() feeds the data to QSurface3DSeries. "
        "The gradient colour map is applied via QLinearGradient to highlight elevation. "
        "Like other 3D graph types, Q3DSurface is embedded with createWindowContainer().";
}

inline QStringList files()
{
    return {
        "examples/3D/Surface/BasicSurface3D/BasicSurface3DExample.h",
        "examples/3D/Surface/BasicSurface3D/BasicSurface3DExample.cpp",
        "examples/3D/Surface/BasicSurface3D/BasicSurface3DData.h",
        "examples/3D/Surface/BasicSurface3D/BasicSurface3DDescription.h",
    };
}

} // namespace BasicSurface3DDescription
