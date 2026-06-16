#pragma once
#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QtQml/qqml.h>

class BarChartStackedDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BarChartStackedDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QStringList  categories()    const;
    Q_INVOKABLE QVariantList starterValues() const;
    Q_INVOKABLE QVariantList proValues()     const;
    Q_INVOKABLE QVariantList enterpriseValues() const;
};
