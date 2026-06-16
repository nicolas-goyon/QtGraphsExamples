#include "ScatterChartBasicDataProvider.h"
#include <QVariantMap>

ScatterChartBasicDataProvider::ScatterChartBasicDataProvider(QObject *parent) : QObject(parent) {}

QVariantList ScatterChartBasicDataProvider::makePoints(
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

QVariantList ScatterChartBasicDataProvider::groupAData() const
{
    return makePoints({
        {158,55},{162,58},{165,61},{168,63},
        {155,52},{170,66},{163,57},{159,56}
    });
}

QVariantList ScatterChartBasicDataProvider::groupBData() const
{
    return makePoints({
        {175,75},{180,80},{185,85},{178,78},
        {182,82},{190,92},{176,76},{183,84}
    });
}

QVariantList ScatterChartBasicDataProvider::groupCData() const
{
    return makePoints({
        {192,100},{195,105},{200,110},{188,95},
        {197,108},{204,115},{191,98},{198,107}
    });
}
