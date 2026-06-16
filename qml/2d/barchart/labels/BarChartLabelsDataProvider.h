#pragma once
#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QtQml/qqml.h>

class BarChartLabelsDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BarChartLabelsDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QStringList  categories() const;
    Q_INVOKABLE QVariantList values()     const;
};
