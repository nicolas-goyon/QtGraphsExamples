#include "examples/3D/Surface/BasicSurface3D/BasicSurface3DExample.h"

// Qt Graphs 3D with pure QML: load BasicSurface3D.qml.
// The sinc surface data is generated entirely in QML JavaScript —
// no context properties or C++ data objects needed.
#include <QQuickWidget>
#include <QVBoxLayout>

BasicSurface3DExample::BasicSurface3DExample(QWidget *parent)
    : QWidget(parent)
{
    auto *quickWidget = new QQuickWidget(this);
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);
    quickWidget->setMinimumSize(400, 300);
    quickWidget->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    quickWidget->setSource(
        QUrl("qrc:/qml/examples/3D/Surface/BasicSurface3D/BasicSurface3D.qml"));

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(quickWidget);
}
