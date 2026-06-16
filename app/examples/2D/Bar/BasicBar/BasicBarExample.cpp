#include "examples/2D/Bar/BasicBar/BasicBarExample.h"
#include "examples/2D/Bar/BasicBar/BasicBarData.h"

#include <QQuickWidget>
#include <QQmlContext>
#include <QVBoxLayout>

BasicBarExample::BasicBarExample(QWidget *parent)
    : QWidget(parent)
{
    auto *quickWidget = new QQuickWidget(this);
    quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);

    // Convert each bar set's values to QVariantList so QML sees a JS array
    const auto sets = BasicBarData::sets();
    auto toVariantList = [](const QList<qreal> &vals) {
        QVariantList vl;
        for (qreal v : vals) vl << v;
        return vl;
    };

    // Expose data to QML — graph configuration lives in BasicBar.qml
    auto *ctx = quickWidget->rootContext();
    ctx->setContextProperty("barCategories",    BasicBarData::categories());
    ctx->setContextProperty("widgetsValues",    toVariantList(sets[0].values));
    ctx->setContextProperty("gadgetsValues",    toVariantList(sets[1].values));
    ctx->setContextProperty("doohickeysValues", toVariantList(sets[2].values));

    quickWidget->setSource(QUrl("qrc:/qml/examples/2D/Bar/BasicBar/BasicBar.qml"));

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(quickWidget);
}
