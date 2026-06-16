#include "AreaChartPointLabelsDataProvider.h"

AreaChartPointLabelsDataProvider::AreaChartPointLabelsDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList AreaChartPointLabelsDataProvider::mrrData() const
{
    static const double v[] = { 174, 54, 177, 259, 927, 470 };
    QVariantList result;
    for (double x : v) result.append(x);
    return result;
}

QVariantList AreaChartPointLabelsDataProvider::monthLabels() const
{
    static const char* labels[] = {
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    };
    QVariantList result;
    for (const char* l : labels) result.append(QString::fromLatin1(l));
    return result;
}
