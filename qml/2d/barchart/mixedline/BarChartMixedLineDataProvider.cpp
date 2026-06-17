#include "BarChartMixedLineDataProvider.h"
#include <QVariantMap>

BarChartMixedLineDataProvider::BarChartMixedLineDataProvider(QObject *parent) : QObject(parent) {}

QStringList BarChartMixedLineDataProvider::months() const {
    return {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
}

QVariantList BarChartMixedLineDataProvider::revenueValues() const {
    return {42.0, 38.0, 51.0, 63.0, 58.0, 72.0, 68.0, 74.0, 81.0, 76.0, 88.0, 95.0};
}

QVariantList BarChartMixedLineDataProvider::avgValues() const {
    // 3-month rolling average (x = category center; BarCategoryAxis centers bar[i] at i+0.5)
    // Jan: 42.0 (only 1 pt), Feb: (42+38)/2=40.0, Mar onward: rolling 3-month
    static const double pts[][2] = {
        {0.5,  42.0},
        {1.5,  40.0},
        {2.5,  43.7},
        {3.5,  50.7},
        {4.5,  57.3},
        {5.5,  64.3},
        {6.5,  66.0},
        {7.5,  71.3},
        {8.5,  74.3},
        {9.5,  77.0},
        {10.5, 81.7},
        {11.5, 86.3}
    };
    QVariantList result;
    for (auto &p : pts) {
        QVariantMap m;
        m["x"] = p[0];
        m["y"] = p[1];
        result << m;
    }
    return result;
}
