#include "ScatterChartLegendDataProvider.h"

ScatterChartLegendDataProvider::ScatterChartLegendDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList ScatterChartLegendDataProvider::makePoints(
    std::initializer_list<std::pair<double, double>> pts)
{
    QVariantList result;
    for (auto [x, y] : pts) {
        QVariantMap m;
        m[QStringLiteral("x")] = x;
        m[QStringLiteral("y")] = y;
        result.append(m);
    }
    return result;
}

// Age (years) vs. annual income ($K) — illustrative data
QVariantList ScatterChartLegendDataProvider::techData() const
{
    return makePoints({
        {25, 95}, {28, 110}, {30, 130}, {33, 155}, {36, 175},
        {40, 200}, {44, 230}, {48, 250}, {52, 270}, {58, 290}
    });
}

QVariantList ScatterChartLegendDataProvider::healthcareData() const
{
    return makePoints({
        {26, 70}, {30, 85}, {34, 105}, {38, 125}, {42, 145},
        {46, 165}, {50, 185}, {54, 200}, {57, 210}, {60, 220}
    });
}

QVariantList ScatterChartLegendDataProvider::educationData() const
{
    return makePoints({
        {24, 45}, {28, 50}, {32, 58}, {36, 63}, {40, 68},
        {44, 72}, {48, 75}, {52, 78}, {56, 80}, {60, 82}
    });
}

QVariantList ScatterChartLegendDataProvider::financeData() const
{
    return makePoints({
        {24, 80}, {28, 100}, {32, 130}, {36, 170}, {40, 210},
        {44, 250}, {48, 270}, {52, 290}, {56, 305}, {60, 315}
    });
}
