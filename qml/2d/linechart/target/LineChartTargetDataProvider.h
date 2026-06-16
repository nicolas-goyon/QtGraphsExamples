#pragma once

#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class LineChartTargetDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LineChartTargetDataProvider(QObject *parent = nullptr);

    // Returns [{year: int, value: double}, ...] — values in thousands (k$)
    Q_INVOKABLE QVariantList salesData() const;

    // The target value in the same unit (thousands)
    Q_INVOKABLE double targetValue() const;
};
