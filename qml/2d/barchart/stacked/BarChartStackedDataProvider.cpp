#include "BarChartStackedDataProvider.h"
BarChartStackedDataProvider::BarChartStackedDataProvider(QObject *parent) : QObject(parent) {}
QStringList BarChartStackedDataProvider::categories() const {
    return {"Jan","Feb","Mar","Apr","May","Jun"};
}
QVariantList BarChartStackedDataProvider::starterValues()    const { return {28.0,31.0,33.0,30.0,35.0,38.0}; }
QVariantList BarChartStackedDataProvider::proValues()        const { return {45.0,48.0,52.0,50.0,55.0,60.0}; }
QVariantList BarChartStackedDataProvider::enterpriseValues() const { return {18.0,20.0,22.0,25.0,27.0,30.0}; }
