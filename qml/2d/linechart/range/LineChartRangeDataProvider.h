#pragma once

#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class LineChartRangeDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LineChartRangeDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList actualData() const;  // Monthly avg temperature °C
    Q_INVOKABLE QVariantList minData()    const;  // Comfort zone lower bound
    Q_INVOKABLE QVariantList maxData()    const;  // Comfort zone upper bound
};
