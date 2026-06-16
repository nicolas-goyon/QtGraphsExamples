#include "AreaChartStackedDataProvider.h"

AreaChartStackedDataProvider::AreaChartStackedDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList AreaChartStackedDataProvider::organicData() const
{
    static const double v[] = { 500, 520, 480, 550, 600, 580, 620, 650, 610, 590, 560, 530 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}

QVariantList AreaChartStackedDataProvider::directData() const
{
    static const double v[] = { 300, 280, 320, 310, 290, 330, 340, 320, 300, 310, 290, 280 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}

QVariantList AreaChartStackedDataProvider::socialData() const
{
    static const double v[] = { 150, 180, 160, 200, 220, 190, 210, 230, 200, 180, 170, 160 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}
