#include "BarChartDataProvider.h"

BarChartDataProvider::BarChartDataProvider(QObject *parent) : QObject(parent) {}

QStringList BarChartDataProvider::categories() const
{
    return {QStringLiteral("Q1"), QStringLiteral("Q2"),
            QStringLiteral("Q3"), QStringLiteral("Q4")};
}

QVariantList BarChartDataProvider::productAValues() const
{
    return {52.0, 61.0, 74.0, 88.0};
}

QVariantList BarChartDataProvider::productBValues() const
{
    return {38.0, 45.0, 55.0, 70.0};
}

QVariantList BarChartDataProvider::productCValues() const
{
    return {21.0, 29.0, 40.0, 58.0};
}
