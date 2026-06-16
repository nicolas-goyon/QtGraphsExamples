#pragma once

#include <QString>
#include <QStringList>

namespace BasicScatter3DDescription {

inline QString text()
{
    return
        "Plots two distinct point clouds using Q3DScatter, each as a separate "
        "QScatter3DSeries with its own colour and dot shape. "
        "Key points: Q3DScatter is embedded via QWidget::createWindowContainer(); "
        "data is supplied through QScatterDataProxy by resetting a QScatterDataArray. "
        "QValue3DAxis is assigned to all three spatial axes so the scale is explicit. "
        "This is the minimal starting point for any 3D cluster or measurement visualisation.";
}

inline QStringList files()
{
    return {
        "examples/3D/Scatter/BasicScatter3D/BasicScatter3DExample.h",
        "examples/3D/Scatter/BasicScatter3D/BasicScatter3DExample.cpp",
        "examples/3D/Scatter/BasicScatter3D/BasicScatter3DData.h",
        "examples/3D/Scatter/BasicScatter3D/BasicScatter3DDescription.h",
    };
}

} // namespace BasicScatter3DDescription
