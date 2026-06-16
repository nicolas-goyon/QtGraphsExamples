#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Provides monthly temperature data (°C) for three cities.
// Swap the implementation bodies to load from file, network, etc.
class LineChartBasicDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LineChartBasicDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList londonData()   const;
    Q_INVOKABLE QVariantList madridData()   const;
    Q_INVOKABLE QVariantList helsinkiData() const;

private:
    static QVariantList makePoints(std::initializer_list<std::pair<double, double>> pts);
};
