#pragma once
#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Provides quarterly revenue data (M$) for three products.
// Swap the implementation bodies to load from file, network, etc.
class BarChartBasicDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit BarChartBasicDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QStringList  categories()     const;
    Q_INVOKABLE QVariantList productAValues() const;
    Q_INVOKABLE QVariantList productBValues() const;
    Q_INVOKABLE QVariantList productCValues() const;
};
