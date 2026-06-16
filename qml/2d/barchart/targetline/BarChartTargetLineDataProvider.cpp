#include "BarChartTargetLineDataProvider.h"
BarChartTargetLineDataProvider::BarChartTargetLineDataProvider(QObject *parent) : QObject(parent) {}
QStringList BarChartTargetLineDataProvider::categories() const {
    return {"Q1 23","Q2 23","Q3 23","Q4 23","Q1 24","Q2 24","Q3 24","Q4 24"};
}
QVariantList BarChartTargetLineDataProvider::salesValues() const {
    return {68.0,74.0,82.0,91.0,78.0,85.0,96.0,104.0};
}
double BarChartTargetLineDataProvider::targetValue() const { return 85.0; }
