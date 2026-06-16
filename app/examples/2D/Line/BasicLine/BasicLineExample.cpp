#include "examples/2D/Line/BasicLine/BasicLineExample.h"
#include "examples/2D/Line/BasicLine/BasicLineData.h"

#include <QQuickWidget>
#include <QQmlContext>
#include <QVBoxLayout>

BasicLineExample::BasicLineExample(QWidget *parent)
    : QWidget(parent)
{
    auto *quickWidget = new QQuickWidget(this);
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);

    // Expose data to QML — graph configuration lives in BasicLine.qml
    const auto allSeries = BasicLineData::series();
    auto *ctx = quickWidget->rootContext();
    ctx->setContextProperty("helsinkiPoints",
                            QVariant::fromValue(allSeries[0].points));
    ctx->setContextProperty("madridPoints",
                            QVariant::fromValue(allSeries[1].points));

    quickWidget->setSource(QUrl("qrc:/qml/examples/2D/Line/BasicLine/BasicLine.qml"));

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(quickWidget);
}
