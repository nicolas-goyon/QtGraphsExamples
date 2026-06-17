#pragma once
#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QtQml/qqml.h>

class BarChartHorizontalDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BarChartHorizontalDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QStringList  countries()  const;
    Q_INVOKABLE QVariantList gdpValues()  const;  // in trillion USD
};
