#include "BarChartStackedPercentDataProvider.h"

BarChartStackedPercentDataProvider::BarChartStackedPercentDataProvider(QObject *parent) : QObject(parent) {}

QVariantList BarChartStackedPercentDataProvider::mobileData() const {
    return {4200.0, 4800.0, 5100.0, 5600.0, 6200.0, 6800.0};
}

QVariantList BarChartStackedPercentDataProvider::desktopData() const {
    return {3800.0, 3600.0, 3400.0, 3100.0, 2900.0, 2600.0};
}

QVariantList BarChartStackedPercentDataProvider::tabletData() const {
    return {1200.0, 1100.0, 980.0, 850.0, 720.0, 600.0};
}

QVariantList BarChartStackedPercentDataProvider::otherData() const {
    return {180.0, 160.0, 140.0, 120.0, 100.0, 80.0};
}

QVariantList BarChartStackedPercentDataProvider::categoryTotals() const {
    // Sum of mobile + desktop + tablet + other per quarter
    // Q1: 4200+3800+1200+180=9380,  Q2: 4800+3600+1100+160=9660
    // Q3: 5100+3400+980+140=9620,   Q4: 5600+3100+850+120=9670
    // Q5: 6200+2900+720+100=9920,   Q6: 6800+2600+600+80=10080
    return {9380.0, 9660.0, 9620.0, 9670.0, 9920.0, 10080.0};
}
