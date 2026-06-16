#include "LineChartStackedDataProvider.h"

LineChartStackedDataProvider::LineChartStackedDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList LineChartStackedDataProvider::marketingData() const
{
    // Monthly lead volume — Jan..Jun
    static const double v[] = { 30, 40, 35, 50, 45, 60 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}

QVariantList LineChartStackedDataProvider::engineeringData() const
{
    // Monthly product-trial sign-ups — Jan..Jun
    static const double v[] = { 20, 25, 30, 20, 35, 25 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}

QVariantList LineChartStackedDataProvider::salesData() const
{
    // Monthly closed deals — Jan..Jun
    static const double v[] = { 15, 20, 18, 25, 20, 30 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}
