#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class ScatterChartTrendLineDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScatterChartTrendLineDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList scatterData()   const;  // {x, y} maps
    Q_INVOKABLE QVariantList trendLineData() const;  // two {x, y} endpoints
private:
    static QVariantList pts(std::initializer_list<std::pair<double,double>>);
};
