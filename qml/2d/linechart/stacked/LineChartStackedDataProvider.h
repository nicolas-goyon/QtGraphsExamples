#pragma once

#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class LineChartStackedDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LineChartStackedDataProvider(QObject *parent = nullptr);

    // Individual (non-cumulative) monthly values — Jan..Jun
    Q_INVOKABLE QVariantList marketingData()   const;
    Q_INVOKABLE QVariantList engineeringData() const;
    Q_INVOKABLE QVariantList salesData()       const;
};
