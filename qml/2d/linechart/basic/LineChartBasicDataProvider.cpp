#include "LineChartBasicDataProvider.h"
#include <QVariantMap>

LineChartBasicDataProvider::LineChartBasicDataProvider(QObject *parent) : QObject(parent) {}

QVariantList LineChartBasicDataProvider::makePoints(
    std::initializer_list<std::pair<double, double>> pts)
{
    QVariantList result;
    result.reserve(static_cast<int>(pts.size()));
    for (auto &[x, y] : pts) {
        QVariantMap m;
        m[QStringLiteral("x")] = x;
        m[QStringLiteral("y")] = y;
        result << m;
    }
    return result;
}

QVariantList LineChartBasicDataProvider::londonData() const
{
    return makePoints({
        {0,5.0},{1,5.5},{2,7.5},{3,10.0},{4,13.5},{5,16.5},
        {6,18.5},{7,18.5},{8,15.5},{9,12.0},{10,8.0},{11,5.5}
    });
}

QVariantList LineChartBasicDataProvider::madridData() const
{
    return makePoints({
        {0,9.0},{1,10.5},{2,13.5},{3,15.5},{4,19.0},{5,24.0},
        {6,29.0},{7,28.5},{8,24.0},{9,18.5},{10,13.0},{11,9.5}
    });
}

QVariantList LineChartBasicDataProvider::helsinkiData() const
{
    return makePoints({
        {0,-3.5},{1,-4.5},{2,-1.5},{3,3.5},{4,9.5},{5,14.5},
        {6,17.5},{7,16.0},{8,11.0},{9,6.0},{10,1.0},{11,-2.0}
    });
}
