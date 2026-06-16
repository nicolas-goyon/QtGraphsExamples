#include "examples/2D/Scatter/BasicScatter/BasicScatterExample.h"
#include "examples/2D/Scatter/BasicScatter/BasicScatterData.h"

#include <QQuickWidget>
#include <QQmlContext>
#include <QVBoxLayout>

BasicScatterExample::BasicScatterExample(QWidget *parent)
    : QWidget(parent)
{
    auto *quickWidget = new QQuickWidget(this);
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);

    // Expose data to QML — graph configuration lives in BasicScatter.qml
    const auto allSeries = BasicScatterData::series();
    auto *ctx = quickWidget->rootContext();
    ctx->setContextProperty("runAPoints",
                            QVariant::fromValue(allSeries[0].points));
    ctx->setContextProperty("runBPoints",
                            QVariant::fromValue(allSeries[1].points));

    quickWidget->setSource(
        QUrl("qrc:/qml/examples/2D/Scatter/BasicScatter/BasicScatter.qml"));

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(quickWidget);
}
