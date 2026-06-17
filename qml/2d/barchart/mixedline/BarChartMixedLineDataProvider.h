#pragma once
#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QtQml/qqml.h>

class BarChartMixedLineDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BarChartMixedLineDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QStringList  months()         const;
    Q_INVOKABLE QVariantList revenueValues()  const;  // bars (M$)
    Q_INVOKABLE QVariantList avgValues()      const;  // 3-month rolling avg line (M$)
};
