#include "BarChartLabelsDataProvider.h"
BarChartLabelsDataProvider::BarChartLabelsDataProvider(QObject *parent) : QObject(parent) {}
QStringList BarChartLabelsDataProvider::categories() const {
    return {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
}
QVariantList BarChartLabelsDataProvider::values() const {
    // Monthly defect rate (%) — values intentionally have non-zero decimal parts
    return {4.23, 3.85, 5.52, 6.14, 2.91, 3.52, 4.71, 5.23, 4.42, 3.81, 3.12, 2.54};
}
