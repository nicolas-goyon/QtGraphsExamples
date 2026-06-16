#include "examples/3D/Scatter/BasicScatter3D/BasicScatter3DExample.h"
#include "examples/3D/Scatter/BasicScatter3D/BasicScatter3DData.h"

// Qt Graphs 3D with pure QML: just expose data via context properties and
// load BasicScatter3D.qml — no Q3DScatterWidgetItem or GraphsWidgets needed.
#include <QQuickWidget>
#include <QQmlContext>
#include <QVariantMap>
#include <QVBoxLayout>

BasicScatter3DExample::BasicScatter3DExample(QWidget *parent)
    : QWidget(parent)
{
    auto *quickWidget = new QQuickWidget(this);
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);
    quickWidget->setMinimumSize(400, 300);
    quickWidget->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    // Convert each cluster to a list of {x, y, z} maps for ItemModelScatterDataProxy
    auto toMapList = [](const QList<QVector3D> &pts) {
        QVariantList list;
        for (const auto &pt : pts)
            list << QVariantMap{{"x", pt.x()}, {"y", pt.y()}, {"z", pt.z()}};
        return list;
    };

    // Expose data to QML — graph configuration lives in BasicScatter3D.qml
    const auto allSeries = BasicScatter3DData::series();
    auto *ctx = quickWidget->rootContext();
    ctx->setContextProperty("clusterAData", toMapList(allSeries[0].points));
    ctx->setContextProperty("clusterBData", toMapList(allSeries[1].points));

    quickWidget->setSource(
        QUrl("qrc:/qml/examples/3D/Scatter/BasicScatter3D/BasicScatter3D.qml"));

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(quickWidget);
}
