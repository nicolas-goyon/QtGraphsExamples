#include "ScatterChartCustomMarkersDataProvider.h"
#include <QVariantMap>
ScatterChartCustomMarkersDataProvider::ScatterChartCustomMarkersDataProvider(QObject *parent) : QObject(parent) {}
QVariantList ScatterChartCustomMarkersDataProvider::pts(std::initializer_list<std::pair<double,double>> in) {
    QVariantList r;
    for (auto &[x,y] : in) { QVariantMap m; m["x"]=x; m["y"]=y; r<<m; }
    return r;
}
// Visits (k) vs Conversions (%) per channel
QVariantList ScatterChartCustomMarkersDataProvider::blogData() const {
    return pts({{12,3.2},{18,4.1},{22,3.8},{30,5.0},{28,4.7},{35,5.5},{40,6.1},{45,6.8}});
}
QVariantList ScatterChartCustomMarkersDataProvider::socialData() const {
    return pts({{50,1.5},{65,1.8},{72,2.1},{80,2.0},{88,2.4},{95,2.2},{105,2.7},{110,3.0}});
}
QVariantList ScatterChartCustomMarkersDataProvider::emailData() const {
    return pts({{8,8.5},{10,9.2},{12,8.8},{15,10.1},{14,9.7},{18,11.2},{20,10.8},{22,12.0}});
}
