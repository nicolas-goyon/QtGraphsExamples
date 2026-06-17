#include "BarChartHorizontalDataProvider.h"

BarChartHorizontalDataProvider::BarChartHorizontalDataProvider(QObject *parent) : QObject(parent) {}

QStringList BarChartHorizontalDataProvider::countries() const {
    return {"South Korea","Canada","Italy","France","UK","Germany","Japan","China","USA"};
}

QVariantList BarChartHorizontalDataProvider::gdpValues() const {
    return {1.7, 2.1, 2.1, 2.8, 3.1, 4.1, 4.2, 17.7, 25.5};
}
