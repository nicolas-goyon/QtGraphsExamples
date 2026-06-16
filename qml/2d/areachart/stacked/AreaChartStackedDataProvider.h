#pragma once

#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class AreaChartStackedDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit AreaChartStackedDataProvider(QObject *parent = nullptr);

    // Monthly website visitors (Jan–Dec) per acquisition channel
    Q_INVOKABLE QVariantList organicData() const;
    Q_INVOKABLE QVariantList directData()  const;
    Q_INVOKABLE QVariantList socialData()  const;
};
