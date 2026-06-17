#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Provides illustrative monthly electricity generation (GWh) for four sources
// (Solar, Wind, Nuclear, Gas) over January–June.
class BarChartLegendDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit BarChartLegendDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList solarData()   const;
    Q_INVOKABLE QVariantList windData()    const;
    Q_INVOKABLE QVariantList nuclearData() const;
    Q_INVOKABLE QVariantList gasData()     const;
};
