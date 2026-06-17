#include "LineChartLegendDataProvider.h"

LineChartLegendDataProvider::LineChartLegendDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList LineChartLegendDataProvider::makePoints(std::initializer_list<double> ys)
{
    QVariantList result;
    int x = 0;
    for (double y : ys) {
        QVariantMap pt;
        pt[QStringLiteral("x")] = x++;
        pt[QStringLiteral("y")] = y;
        result.append(pt);
    }
    return result;
}

// Annual revenue growth % (approx) 2019–2023
QVariantList LineChartLegendDataProvider::appleData()     const { return makePoints({-2.0,  5.5, 33.3, 8.1,  -3.0}); }
QVariantList LineChartLegendDataProvider::googleData()    const { return makePoints({18.4, -1.3, 41.2, 9.8, -3.5}); }
QVariantList LineChartLegendDataProvider::microsoftData() const { return makePoints({14.0, 13.6, 17.5, 18.0, 7.1}); }
QVariantList LineChartLegendDataProvider::amazonData()    const { return makePoints({20.5, 37.6, 21.7, 9.4, -8.6}); }
QVariantList LineChartLegendDataProvider::metaData()      const { return makePoints({27.0, 21.6, 37.0, 7.1, -1.1}); }
