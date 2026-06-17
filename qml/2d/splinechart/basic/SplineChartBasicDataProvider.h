#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class SplineChartBasicDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit SplineChartBasicDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList parisData() const;
    Q_INVOKABLE QVariantList miamiData() const;
    Q_INVOKABLE QVariantList tokyoData() const;
private:
    static QVariantList makePoints(std::initializer_list<double> ys);
};
