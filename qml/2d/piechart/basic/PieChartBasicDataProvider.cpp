#include "PieChartBasicDataProvider.h"
#include <QVariantMap>

PieChartBasicDataProvider::PieChartBasicDataProvider(QObject *parent) : QObject(parent) {}

QVariantList PieChartBasicDataProvider::slices() const {
    return {
        QVariantMap{{"label","Chrome"},  {"value",65.2}, {"color","#89b4fa"}},
        QVariantMap{{"label","Safari"},  {"value",18.9}, {"color","#a6e3a1"}},
        QVariantMap{{"label","Edge"},    {"value", 5.1}, {"color","#f9e2af"}},
        QVariantMap{{"label","Firefox"}, {"value", 2.8}, {"color","#f38ba8"}},
        QVariantMap{{"label","Samsung"}, {"value", 2.5}, {"color","#cba6f7"}},
        QVariantMap{{"label","Other"},   {"value", 5.5}, {"color","#fab387"}}
    };
}
