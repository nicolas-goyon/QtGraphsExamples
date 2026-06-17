#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class BarChartStackedPercentDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BarChartStackedPercentDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList mobileData()     const;
    Q_INVOKABLE QVariantList desktopData()    const;
    Q_INVOKABLE QVariantList tabletData()     const;
    Q_INVOKABLE QVariantList otherData()      const;
    Q_INVOKABLE QVariantList categoryTotals() const;
};
