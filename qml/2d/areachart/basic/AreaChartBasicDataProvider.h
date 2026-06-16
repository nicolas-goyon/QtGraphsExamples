#pragma once

#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class AreaChartBasicDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit AreaChartBasicDataProvider(QObject *parent = nullptr);

    // Monthly average high temperatures (°C) — Jan..Dec
    Q_INVOKABLE QVariantList highData() const;

    // Monthly average low temperatures (°C) — Jan..Dec
    Q_INVOKABLE QVariantList lowData() const;
};
