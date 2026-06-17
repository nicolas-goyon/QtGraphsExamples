#include "BarChartLegendDataProvider.h"

BarChartLegendDataProvider::BarChartLegendDataProvider(QObject *parent)
    : QObject(parent) {}

// Illustrative monthly GWh — Jan to Jun
QVariantList BarChartLegendDataProvider::solarData()   const { return {80,  120, 200, 310, 420, 500}; }
QVariantList BarChartLegendDataProvider::windData()    const { return {310, 280, 260, 230, 210, 190}; }
QVariantList BarChartLegendDataProvider::nuclearData() const { return {420, 415, 410, 405, 400, 395}; }
QVariantList BarChartLegendDataProvider::gasData()     const { return {350, 320, 280, 240, 180, 150}; }
