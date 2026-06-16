#include "AreaChartBasicDataProvider.h"

AreaChartBasicDataProvider::AreaChartBasicDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList AreaChartBasicDataProvider::highData() const
{
    // London monthly average high temperatures (°C), Jan–Dec
    static const double highs[] = { 8, 9, 12, 15, 19, 22, 24, 24, 21, 16, 11, 8 };
    QVariantList result;
    for (double v : highs) result.append(v);
    return result;
}

QVariantList AreaChartBasicDataProvider::lowData() const
{
    // London monthly average low temperatures (°C), Jan–Dec
    static const double lows[] = { 3, 3, 5, 8, 11, 14, 16, 16, 13, 9, 6, 3 };
    QVariantList result;
    for (double v : lows) result.append(v);
    return result;
}
