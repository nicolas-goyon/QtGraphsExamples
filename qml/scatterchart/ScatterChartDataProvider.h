#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Provides height/weight scatter data for three groups.
// Swap the implementation bodies to load from file, network, etc.
class ScatterChartDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit ScatterChartDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList groupAData() const;
    Q_INVOKABLE QVariantList groupBData() const;
    Q_INVOKABLE QVariantList groupCData() const;

private:
    static QVariantList makePoints(std::initializer_list<std::pair<double, double>> pts);
};
