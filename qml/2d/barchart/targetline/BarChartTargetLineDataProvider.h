#pragma once
#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QtQml/qqml.h>

class BarChartTargetLineDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BarChartTargetLineDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QStringList  categories()   const;
    Q_INVOKABLE QVariantList salesValues()  const;
    Q_INVOKABLE double       targetValue()  const;
};
