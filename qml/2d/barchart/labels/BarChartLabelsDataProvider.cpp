#include "BarChartLabelsDataProvider.h"
BarChartLabelsDataProvider::BarChartLabelsDataProvider(QObject *parent) : QObject(parent) {}
QStringList BarChartLabelsDataProvider::categories() const {
    return {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
}
QVariantList BarChartLabelsDataProvider::values() const {
    return {42.0,38.0,55.0,61.0,29.0,35.0,47.0,52.0,44.0,38.0,31.0,25.0};
}
