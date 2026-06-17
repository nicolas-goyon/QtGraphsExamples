#include "ScatterChartAveragesDataProvider.h"
#include <QVariantMap>
#include <algorithm>

ScatterChartAveragesDataProvider::ScatterChartAveragesDataProvider(QObject *parent) : QObject(parent) {}

static const double sxs[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29};
static const double sys[] = {35,42,38,51,45,48,52,46,55,62,58,64,60,68,72,65,70,75,68,80,74,78,71,76,82,79,85,80,88,84};
static const int sN = 30;

QVariantList ScatterChartAveragesDataProvider::scatterData() const {
    QVariantList result;
    for (int i = 0; i < sN; ++i) {
        QVariantMap m;
        m["x"] = sxs[i];
        m["y"] = sys[i];
        result << m;
    }
    return result;
}

QVariantList ScatterChartAveragesDataProvider::overallAverage() const {
    double sum = 0.0;
    for (int i = 0; i < sN; ++i) sum += sys[i];
    double mean = sum / sN;
    QVariantList result;
    QVariantMap m0, m1;
    m0["x"] = 0.0; m0["y"] = mean;
    m1["x"] = 29.0; m1["y"] = mean;
    result << m0 << m1;
    return result;
}

QVariantList ScatterChartAveragesDataProvider::rollingAverage() const {
    QVariantList result;
    for (int i = 0; i < sN; ++i) {
        int lo = std::max(0, i - 2);
        int hi = std::min(sN - 1, i + 2);
        double sum = 0.0;
        int cnt = hi - lo + 1;
        for (int j = lo; j <= hi; ++j) sum += sys[j];
        QVariantMap m;
        m["x"] = sxs[i];
        m["y"] = sum / cnt;
        result << m;
    }
    return result;
}
