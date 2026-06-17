#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class ScatterChartAveragesDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScatterChartAveragesDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList scatterData()    const;
    Q_INVOKABLE QVariantList overallAverage() const;  // 2 points: horizontal flat line at mean Y
    Q_INVOKABLE QVariantList rollingAverage() const;  // one point per data point, 5-window centered rolling mean
};
