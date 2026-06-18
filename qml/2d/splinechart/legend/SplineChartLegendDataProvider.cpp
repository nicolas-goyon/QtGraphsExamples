#include "SplineChartLegendDataProvider.h"
#include <QVariantMap>

SplineChartLegendDataProvider::SplineChartLegendDataProvider(QObject *parent) : QObject(parent) {}

QVariantList SplineChartLegendDataProvider::makePoints(std::initializer_list<double> ys) {
    QVariantList result;
    int i = 0;
    for (double y : ys) {
        QVariantMap m;
        m["x"] = i + 1;
        m["y"] = y;
        result << m;
        ++i;
    }
    return result;
}

QVariantList SplineChartLegendDataProvider::parisData() const {
    return makePoints({6, 7, 11, 15, 19, 22, 25, 25, 21, 15, 9, 6});
}

QVariantList SplineChartLegendDataProvider::miamiData() const {
    return makePoints({24, 25, 27, 28, 30, 31, 32, 32, 31, 29, 27, 25});
}

QVariantList SplineChartLegendDataProvider::tokyoData() const {
    return makePoints({5, 6, 10, 15, 20, 23, 27, 29, 25, 18, 12, 7});
}
