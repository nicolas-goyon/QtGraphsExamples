#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

// Provides monthly average temperature data for three cities (Jan–Dec).
// Each series returns a list of QVariantMap { "x": month (1–12), "y": tempCelsius }.
class SplineChartLegendDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SplineChartLegendDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList parisData()  const;
    Q_INVOKABLE QVariantList miamiData()  const;
    Q_INVOKABLE QVariantList tokyoData()  const;

private:
    static QVariantList makePoints(std::initializer_list<double> ys);
};
