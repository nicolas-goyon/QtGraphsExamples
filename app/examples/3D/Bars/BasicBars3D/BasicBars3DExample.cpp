#include "examples/3D/Bars/BasicBars3D/BasicBars3DExample.h"
#include "examples/3D/Bars/BasicBars3D/BasicBars3DData.h"

// Qt Graphs 3D with pure QML: just expose data via context properties and
// load BasicBars3D.qml — no Q3DBarsWidgetItem or GraphsWidgets needed.
#include <QQuickWidget>
#include <QQmlContext>
#include <QVariantMap>
#include <QVBoxLayout>

BasicBars3DExample::BasicBars3DExample(QWidget *parent)
    : QWidget(parent)
{
    auto *quickWidget = new QQuickWidget(this);
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);
    quickWidget->setMinimumSize(400, 300);
    quickWidget->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    // Build flat list-of-maps for ItemModelBarDataProxy in QML
    QVariantList barData;
    const auto values   = BasicBars3DData::values();
    const auto rowLabels = BasicBars3DData::rowLabels();
    const auto colLabels = BasicBars3DData::columnLabels();
    for (int r = 0; r < values.size(); ++r) {
        for (int c = 0; c < values[r].size(); ++c) {
            barData << QVariantMap{
                {"rowLabel", rowLabels[r]},
                {"colLabel", colLabels[c]},
                {"val",      static_cast<qreal>(values[r][c])}
            };
        }
    }

    // Expose data to QML — graph configuration lives in BasicBars3D.qml
    auto *ctx = quickWidget->rootContext();
    ctx->setContextProperty("barData3D",   barData);
    ctx->setContextProperty("rowLabels3D", BasicBars3DData::rowLabels());
    ctx->setContextProperty("colLabels3D", BasicBars3DData::columnLabels());

    quickWidget->setSource(
        QUrl("qrc:/qml/examples/3D/Bars/BasicBars3D/BasicBars3D.qml"));

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(quickWidget);
}
