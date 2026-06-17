#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Provides age-vs-income scatter data for four industry sectors.
// Each method returns a QVariantList of QVariantMap { "x": age, "y": incomeK }.
class ScatterChartLegendDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit ScatterChartLegendDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList techData()       const;
    Q_INVOKABLE QVariantList healthcareData() const;
    Q_INVOKABLE QVariantList educationData()  const;
    Q_INVOKABLE QVariantList financeData()    const;

private:
    static QVariantList makePoints(std::initializer_list<std::pair<double, double>> pts);
};
