#include "LineChartTargetDataProvider.h"

LineChartTargetDataProvider::LineChartTargetDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList LineChartTargetDataProvider::salesData() const
{
    // Yearly sales for a fictional shop, in thousands of dollars (k$).
    // 2020 shows a notable dip; 2022-2024 are strong growth years.
    static const struct { int year; double value; } rows[] = {
        { 2015,  72.0 },
        { 2016,  85.0 },
        { 2017,  91.0 },
        { 2018,  88.0 },
        { 2019, 105.0 },
        { 2020,  63.0 },
        { 2021,  95.0 },
        { 2022, 112.0 },
        { 2023, 108.0 },
        { 2024, 125.0 },
    };

    QVariantList result;
    for (const auto &row : rows) {
        QVariantMap entry;
        entry["year"]  = row.year;
        entry["value"] = row.value;
        result.append(entry);
    }
    return result;
}

double LineChartTargetDataProvider::targetValue() const
{
    return 100.0; // 100 k$ per year
}
