#include "ScatterChartTrendLineDataProvider.h"
#include <QVariantMap>
ScatterChartTrendLineDataProvider::ScatterChartTrendLineDataProvider(QObject *parent) : QObject(parent) {}
QVariantList ScatterChartTrendLineDataProvider::pts(std::initializer_list<std::pair<double,double>> in) {
    QVariantList r;
    for (auto &[x,y] : in) { QVariantMap m; m["x"]=x; m["y"]=y; r<<m; }
    return r;
}
QVariantList ScatterChartTrendLineDataProvider::scatterData() const {
    return pts({{1,42},{2,55},{3,61},{3,68},{4,72},{4,78},{5,80},{5,85},{6,88},{6,90},{7,92},{8,95}});
}
QVariantList ScatterChartTrendLineDataProvider::trendLineData() const {
    return pts({{1,49},{8,102}});  // y = 7.64x + 41.12
}
