#include "LineChartRangeDataProvider.h"

LineChartRangeDataProvider::LineChartRangeDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList LineChartRangeDataProvider::actualData() const
{
    // Monthly average temperature °C — Jan..Dec (Northern Europe)
    static const double v[] = { 4, 5, 9, 14, 18, 22, 25, 24, 20, 15, 9, 5 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}

QVariantList LineChartRangeDataProvider::minData() const
{
    // Lower bound of the comfortable temperature range
    static const double v[] = { 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}

QVariantList LineChartRangeDataProvider::maxData() const
{
    // Upper bound of the comfortable temperature range
    static const double v[] = { 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}
